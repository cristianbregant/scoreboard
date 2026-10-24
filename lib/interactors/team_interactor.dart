import 'package:scoreboard/interactors/activity_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/team.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

/// How a team member is being recognized, for their manager.
class TeamMemberStats {
  final UserProfile member;
  final int receivedLast30Days;
  final int receivedLast90Days;
  final int sentLast90Days;
  final int totalPoints;

  /// Their latest achievement, null if they have none.
  final DateTime? lastRecognizedAt;

  const TeamMemberStats(
      {required this.member,
      required this.receivedLast30Days,
      required this.receivedLast90Days,
      required this.sentLast90Days,
      required this.totalPoints,
      required this.lastRecognizedAt});

  /// Nothing received for a month: worth a manager's attention.
  bool needsAttention(DateTime now) =>
      lastRecognizedAt == null ||
      now.difference(lastRecognizedAt!).inDays > TeamInteractor.attentionDays;
}

class TeamOverview {
  final Team team;

  /// Least recently recognized first, so who needs attention comes first.
  final List<TeamMemberStats> members;

  const TeamOverview({required this.team, required this.members});
}

/// Teams, their managers and what managers can do for their members.
class TeamInteractor {
  static const int attentionDays = 30;

  final ScoreboardRepository _repository;
  final ScoreboardInteractor _scoreboard;
  final ActivityInteractor _activity;

  TeamInteractor(this._repository, this._scoreboard, this._activity);

  /// The current user's company teams.
  Future<List<Team>> getTeams() async {
    final user = await _scoreboard.getCurrentUser();
    return _repository.getTeams(user.companyId);
  }

  /// The team the current user leads, if any.
  Future<Team?> managedTeam() async {
    final user = await _scoreboard.getCurrentUser();
    return (await _repository.getTeams(user.companyId))
        .where((t) => t.managerId == user.id)
        .firstOrNull;
  }

  /// The team the current user leads, with how each member is recognized.
  /// Throws [AdminError.notManager] for anyone else.
  Future<TeamOverview> getOverview() async {
    final team = await managedTeam();
    if (team == null) throw const AdminException(AdminError.notManager);
    final now = DateTime.now();
    final members = (await _repository.getUsers())
        .where((u) => u.teamId == team.id)
        .toList();
    final achievements = await _repository.getAchievements();

    final stats = [
      for (final member in members)
        () {
          final received = achievements
              .where((a) => a.userId == member.id && a.date != null)
              .toList();
          int since(int days) => received
              .where((a) => now.difference(a.date!).inDays <= days)
              .length;
          final latest = received.isEmpty
              ? null
              : received
                  .map((a) => a.date!)
                  .reduce((a, b) => a.isAfter(b) ? a : b);
          return TeamMemberStats(
            member: member,
            receivedLast30Days: since(30),
            receivedLast90Days: since(90),
            sentLast90Days: achievements
                .where((a) =>
                    a.awardedById == member.id &&
                    a.date != null &&
                    now.difference(a.date!).inDays <= 90)
                .length,
            totalPoints: received.fold(0, (sum, a) => sum + (a.points ?? 0)),
            lastRecognizedAt: latest,
          );
        }(),
    ]..sort((a, b) {
        final at = a.lastRecognizedAt, bt = b.lastRecognizedAt;
        if (at == null) return bt == null ? 0 : -1;
        if (bt == null) return 1;
        return at.compareTo(bt);
      });
    return TeamOverview(team: team, members: stats);
  }

  /// Proposes a verified achievement for a member of the manager's team.
  /// It reaches the admins as a request, marked as nominated.
  Future<void> nominate(String memberId, String catalogId,
      {required String message}) async {
    final manager = await _scoreboard.getCurrentUser();
    final team = await managedTeam();
    if (team == null) throw const AdminException(AdminError.notManager);
    final member = (await _repository.getUsers())
        .where((u) => u.id == memberId)
        .firstOrNull;
    if (member == null || member.teamId != team.id || member.id == manager.id) {
      throw const AdminException(AdminError.notInTeam);
    }
    if (message.trim().isEmpty) {
      throw const AdminException(AdminError.missingFields);
    }
    final catalog = await _repository.getCatalog(manager.companyId);
    final item = catalog.where((c) => c.id == catalogId).firstOrNull;
    if (item == null || item.archived) {
      throw const AdminException(AdminError.notFound);
    }
    final achievements = await _repository.getAchievements();
    if (achievements
        .any((a) => a.userId == memberId && a.catalogId == catalogId)) {
      throw const AdminException(AdminError.alreadyOwned);
    }
    final requests = await _repository.getRequests(manager.companyId);
    if (requests.any((r) =>
        r.userId == memberId &&
        r.catalogId == catalogId &&
        r.status == RequestStatus.pending)) {
      throw const AdminException(AdminError.requestPending);
    }
    await _repository.saveRequest(VerificationRequest(
      id: 'req_${DateTime.now().microsecondsSinceEpoch}',
      userId: memberId,
      companyId: manager.companyId,
      catalogId: catalogId,
      message: message.trim(),
      createdAt: DateTime.now(),
      nominatedById: manager.id,
    ));
    await _activity.log(ActivityType.nominationSubmitted,
        subject: item.name, target: member.name);
    _scoreboard.dataChanged();
  }

  // Admins -----------------------------------------------------------------

  Future<UserProfile> _requireAdmin() async {
    final user = await _scoreboard.getCurrentUser();
    if (!user.isCompanyAdmin) throw const AdminException(AdminError.notAdmin);
    return user;
  }

  /// [managerId] must be a member of the company, or null.
  Future<void> createTeam(String name, {String? managerId}) async {
    final admin = await _requireAdmin();
    final trimmed = name.trim();
    if (trimmed.isEmpty) throw const AdminException(AdminError.missingFields);
    await _checkMember(admin, managerId);
    await _repository.saveTeam(Team(
      id: 't_${DateTime.now().microsecondsSinceEpoch}',
      companyId: admin.companyId,
      name: trimmed,
      managerId: managerId,
    ));
    await _activity.log(ActivityType.teamCreated, subject: trimmed);
    _scoreboard.dataChanged();
  }

  Future<void> updateTeam(String teamId,
      {required String name, String? managerId}) async {
    final admin = await _requireAdmin();
    final trimmed = name.trim();
    if (trimmed.isEmpty) throw const AdminException(AdminError.missingFields);
    await _checkMember(admin, managerId);
    final team = await _team(admin, teamId);
    await _repository
        .saveTeam(team.copyWith(name: trimmed, managerId: managerId ?? ''));
    await _activity.log(ActivityType.teamUpdated, subject: trimmed);
    _scoreboard.dataChanged();
  }

  /// Its members are left without a team.
  Future<void> deleteTeam(String teamId) async {
    final admin = await _requireAdmin();
    final team = await _team(admin, teamId);
    await _repository.deleteTeam(team.id);
    await _activity.log(ActivityType.teamDeleted, subject: team.name);
    _scoreboard.dataChanged();
  }

  /// Moves a member to [teamId], or out of any team with null.
  Future<void> moveMember(String userId, String? teamId) async {
    final admin = await _requireAdmin();
    final member = await _checkMember(admin, userId);
    final team = teamId == null ? null : await _team(admin, teamId);
    await _repository.setUserTeam(member!.id, team?.id);
    await _activity.log(ActivityType.memberMoved,
        subject: member.name, target: team?.name);
    _scoreboard.dataChanged();
  }

  Future<Team> _team(UserProfile admin, String teamId) async {
    final team = (await _repository.getTeams(admin.companyId))
        .where((t) => t.id == teamId)
        .firstOrNull;
    if (team == null) throw const AdminException(AdminError.notFound);
    return team;
  }

  /// Null passes; otherwise the user must belong to the admin's company.
  Future<UserProfile?> _checkMember(UserProfile admin, String? userId) async {
    if (userId == null) return null;
    final user = (await _repository.getUsers())
        .where((u) => u.id == userId && u.companyId == admin.companyId)
        .firstOrNull;
    if (user == null) throw const AdminException(AdminError.notFound);
    return user;
  }
}
