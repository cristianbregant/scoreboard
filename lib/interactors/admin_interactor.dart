import 'package:scoreboard/interactors/activity_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/insights.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

/// The company catalog of verified achievements and the requests to earn
/// them. Managing them is reserved to company admins.
class AdminInteractor {
  final ScoreboardRepository _repository;
  final ScoreboardInteractor _scoreboard;
  final ActivityInteractor _activity;

  AdminInteractor(this._repository, this._scoreboard, this._activity);

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
    await _activity.log(ActivityType.catalogCreated,
        subject: draft.name.trim());
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
    await _activity.log(ActivityType.catalogUpdated,
        subject: draft.name.trim());
    _scoreboard.dataChanged();
  }

  Future<void> setArchived(String id, bool archived) async {
    final item = await _catalogItem(id);
    await _repository.saveCatalogAchievement(item.copyWith(archived: archived));
    await _activity.log(
        archived ? ActivityType.catalogArchived : ActivityType.catalogRestored,
        subject: item.name);
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
    if (issued > 0) {
      await _activity.log(ActivityType.achievementsIssued,
          subject: item.name, count: issued);
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

  /// Admins see every request of the company; managers their own and their
  /// team's; members only their own.
  Future<List<VerificationRequest>> getRequests() async {
    final user = await _scoreboard.getCurrentUser();
    final requests = await _repository.getRequests(user.companyId);
    if (user.isCompanyAdmin) return requests;
    final team = (await _repository.getTeams(user.companyId))
        .where((t) => t.managerId == user.id)
        .firstOrNull;
    final visible = {
      user.id,
      if (team != null)
        for (final u in await _repository.getUsers())
          if (u.teamId == team.id) u.id,
    };
    return requests.where((r) => visible.contains(r.userId)).toList();
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
    await _activity.log(ActivityType.requestApproved,
        subject: item.name, target: await _nameOf(request.userId));
    _scoreboard.dataChanged();
  }

  Future<String?> _nameOf(String userId) async => (await _repository.getUsers())
      .where((u) => u.id == userId)
      .firstOrNull
      ?.name;

  Future<void> rejectRequest(String requestId, String reason) async {
    final admin = await _requireAdmin();
    final request = await _pendingRequest(admin, requestId);
    final trimmed = reason.trim();
    await _repository.saveRequest(request.decide(RequestStatus.rejected,
        deciderId: admin.id, reason: trimmed.isEmpty ? null : trimmed));
    await _activity.log(ActivityType.requestRejected,
        subject: (await _catalogItem(request.catalogId)).name,
        target: await _nameOf(request.userId));
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

  static const int _months = 6;
  static const int _listSize = 3;

  Future<CompanyInsights> getInsights() async {
    final admin = await _requireAdmin();
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month);
    final last30 = now.subtract(const Duration(days: 30));
    final last90 = now.subtract(const Duration(days: 90));

    final members = (await _repository.getUsers())
        .where((u) => u.companyId == admin.companyId)
        .toList();
    final memberIds = members.map((m) => m.id).toSet();
    final achievements = (await _repository.getAchievements())
        .where((a) => memberIds.contains(a.userId) && a.date != null)
        .toList();
    bool isVerified(a) => a.verified == true;
    final thisMonth =
        achievements.where((a) => !a.date!.isBefore(monthStart)).toList();

    final monthly = [
      for (var i = _months - 1; i >= 0; i--)
        () {
          final start = DateTime(now.year, now.month - i);
          final end = DateTime(now.year, now.month - i + 1);
          final inMonth = achievements
              .where((a) => !a.date!.isBefore(start) && a.date!.isBefore(end));
          return MonthlyCount(
            month: start,
            verified: inMonth.where(isVerified).length,
            peer: inMonth.where((a) => !isVerified(a)).length,
          );
        }(),
    ];

    final recent = achievements.where((a) => a.date!.isAfter(last90));
    final received = [
      for (final m in members) (m, recent.where((a) => a.userId == m.id).length)
    ]..sort((a, b) => a.$2.compareTo(b.$2));
    final sent = [
      for (final m in members)
        (m, recent.where((a) => !isVerified(a) && a.awardedById == m.id).length)
    ]
      ..removeWhere((entry) => entry.$2 == 0)
      ..sort((a, b) => b.$2.compareTo(a.$2));

    final catalog = await _repository.getCatalog(admin.companyId);
    final issued = [
      for (final item in catalog)
        (item, achievements.where((a) => a.catalogId == item.id).length)
    ]
      ..removeWhere((entry) => entry.$2 == 0)
      ..sort((a, b) => b.$2.compareTo(a.$2));

    final recognizedRecently = members
        .where((m) => achievements
            .any((a) => a.userId == m.id && a.date!.isAfter(last30)))
        .length;

    return CompanyInsights(
      verifiedThisMonth: thisMonth.where(isVerified).length,
      peerThisMonth: thisMonth.where((a) => !isVerified(a)).length,
      activeSenders: thisMonth
          .where((a) => !isVerified(a) && a.awardedById != null)
          .map((a) => a.awardedById)
          .toSet()
          .length,
      coveragePercent: members.isEmpty
          ? 0
          : (recognizedRecently * 100 / members.length).round(),
      monthly: monthly,
      leastRecognized: received.take(_listSize).toList(),
      topSenders: sent.take(_listSize).toList(),
      topCatalog: issued.take(_listSize).toList(),
    );
  }
}
