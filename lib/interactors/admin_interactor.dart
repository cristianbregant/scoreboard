import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

/// The company catalog of verified achievements and the requests to earn
/// them. Managing them is reserved to company admins.
class AdminInteractor {
  final ScoreboardRepository _repository;
  final ScoreboardInteractor _scoreboard;

  AdminInteractor(this._repository, this._scoreboard);

  Future<UserProfile> _requireAdmin() async {
    final user = await _scoreboard.getCurrentUser();
    if (!user.isCompanyAdmin) throw const AdminException(AdminError.notAdmin);
    return user;
  }

  /// The current user's company catalog; archived entries only on request.
  Future<List<CatalogAchievement>> getCatalog(
      {bool includeArchived = false}) async {
    final user = await _scoreboard.getCurrentUser();
    final catalog = await _repository.getCatalog(user.companyId);
    return catalog.where((c) => includeArchived || !c.archived).toList()
      ..sort((a, b) => b.points.compareTo(a.points));
  }

  Future<void> createCatalogAchievement(CatalogAchievementDraft draft) async {
    final admin = await _requireAdmin();
    _validate(draft);
    final now = DateTime.now();
    await _repository.saveCatalogAchievement(CatalogAchievement(
      id: 'cat_${now.microsecondsSinceEpoch}',
      companyId: admin.companyId,
      name: draft.name.trim(),
      description: draft.description.trim(),
      icon: draft.icon,
      points: draft.points,
      createdAt: now,
    ));
    _scoreboard.dataChanged();
  }

  /// Achievements already issued keep their own copy of the old values.
  Future<void> updateCatalogAchievement(
      String id, CatalogAchievementDraft draft) async {
    _validate(draft);
    final item = await _catalogItem(id);
    await _repository.saveCatalogAchievement(item.copyWith(
      name: draft.name.trim(),
      description: draft.description.trim(),
      icon: draft.icon,
      points: draft.points,
    ));
    _scoreboard.dataChanged();
  }

  Future<void> setArchived(String id, bool archived) async {
    final item = await _catalogItem(id);
    await _repository.saveCatalogAchievement(item.copyWith(archived: archived));
    _scoreboard.dataChanged();
  }

  Future<CatalogAchievement> _catalogItem(String id) async {
    final admin = await _requireAdmin();
    final catalog = await _repository.getCatalog(admin.companyId);
    final item = catalog.where((c) => c.id == id).firstOrNull;
    if (item == null) throw const AdminException(AdminError.notFound);
    return item;
  }

  void _validate(CatalogAchievementDraft draft) {
    if (draft.name.trim().isEmpty || draft.description.trim().isEmpty) {
      throw const AdminException(AdminError.missingFields);
    }
    if (draft.points < CatalogAchievement.minPoints ||
        draft.points > CatalogAchievement.maxPoints) {
      throw const AdminException(AdminError.invalidPoints);
    }
  }

  /// Ids of the company members who already own [catalogId].
  Future<Set<String>> ownersOf(String catalogId) async {
    final achievements = await _repository.getAchievements();
    return {
      for (final a in achievements)
        if (a.catalogId == catalogId) a.userId!
    };
  }

  /// Issues [catalogId] to each of [userIds] who doesn't have it yet.
  Future<IssueResult> issue(String catalogId, Set<String> userIds,
      {String? note}) async {
    final item = await _catalogItem(catalogId);
    final owners = await ownersOf(catalogId);
    final members = (await _repository.getUsers())
        .where((u) => u.companyId == item.companyId)
        .map((u) => u.id)
        .toSet();
    var issued = 0;
    for (final userId in userIds.where(members.contains)) {
      if (owners.contains(userId)) continue;
      await _repository
          .addAchievement(await _verifiedAchievement(item, userId, note: note));
      issued++;
    }
    _scoreboard.dataChanged();
    return IssueResult(issued: issued, skipped: userIds.length - issued);
  }

  Future<Achievement> _verifiedAchievement(
      CatalogAchievement item, String userId,
      {String? note}) async {
    final admin = await _scoreboard.getCurrentUser();
    final company = await _scoreboard.getCompany(item.companyId);
    final trimmed = note?.trim();
    return Achievement(
      id: 'ach_issued_${DateTime.now().microsecondsSinceEpoch}_$userId',
      userId: userId,
      name: item.name,
      description: item.description,
      icon: item.icon,
      points: item.points,
      company: company.name,
      companyId: company.id,
      companyBrand: company.brand,
      catalogId: item.id,
      date: DateTime.now(),
      verified: true,
      awardedById: admin.id,
      note: (trimmed == null || trimmed.isEmpty) ? null : trimmed,
    );
  }

  /// Admins see every request of the company, members only their own.
  Future<List<VerificationRequest>> getRequests() async {
    final user = await _scoreboard.getCurrentUser();
    final requests = await _repository.getRequests(user.companyId);
    return user.isCompanyAdmin
        ? requests
        : requests.where((r) => r.userId == user.id).toList();
  }

  Future<void> submitRequest(String catalogId,
      {required String message, String? evidenceUrl}) async {
    final user = await _scoreboard.getCurrentUser();
    final url = evidenceUrl?.trim();
    if (message.trim().isEmpty) {
      throw const AdminException(AdminError.missingFields);
    }
    if (url != null && url.isNotEmpty && !isValidUrl(url)) {
      throw const AdminException(AdminError.invalidUrl);
    }
    if ((await ownersOf(catalogId)).contains(user.id)) {
      throw const AdminException(AdminError.alreadyOwned);
    }
    final requests = await _repository.getRequests(user.companyId);
    if (requests.any((r) =>
        r.userId == user.id &&
        r.catalogId == catalogId &&
        r.status == RequestStatus.pending)) {
      throw const AdminException(AdminError.requestPending);
    }
    await _repository.saveRequest(VerificationRequest(
      id: 'req_${DateTime.now().microsecondsSinceEpoch}',
      userId: user.id,
      companyId: user.companyId,
      catalogId: catalogId,
      message: message.trim(),
      evidenceUrl: (url == null || url.isEmpty) ? null : url,
      createdAt: DateTime.now(),
    ));
    _scoreboard.dataChanged();
  }

  /// Issues the achievement; the requester is notified of the approval
  /// rather than of a plain new achievement.
  Future<void> approveRequest(String requestId) async {
    final admin = await _requireAdmin();
    final request = await _pendingRequest(admin, requestId);
    final item = await _catalogItem(request.catalogId);
    if (!(await ownersOf(item.id)).contains(request.userId)) {
      await _repository.addAchievement(
          await _verifiedAchievement(item, request.userId),
          notifyRecipient: false);
    }
    await _repository.saveRequest(
        request.decide(RequestStatus.approved, deciderId: admin.id));
    _scoreboard.dataChanged();
  }

  Future<void> rejectRequest(String requestId, String reason) async {
    final admin = await _requireAdmin();
    final request = await _pendingRequest(admin, requestId);
    final trimmed = reason.trim();
    await _repository.saveRequest(request.decide(RequestStatus.rejected,
        deciderId: admin.id, reason: trimmed.isEmpty ? null : trimmed));
    _scoreboard.dataChanged();
  }

  Future<VerificationRequest> _pendingRequest(
      UserProfile admin, String requestId) async {
    final requests = await _repository.getRequests(admin.companyId);
    final request = requests
        .where((r) => r.id == requestId && r.status == RequestStatus.pending)
        .firstOrNull;
    if (request == null) throw const AdminException(AdminError.notFound);
    return request;
  }

  static bool isValidUrl(String value) {
    final uri = Uri.tryParse(value.trim());
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }
}
