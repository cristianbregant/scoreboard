import 'package:scoreboard/api/api_client.dart';
import 'package:scoreboard/api/endpoints.dart';
import 'package:scoreboard/api/error/api_error.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/achievement_template.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/company_settings.dart';
import 'package:scoreboard/model/feed.dart';
import 'package:scoreboard/model/invite.dart';
import 'package:scoreboard/model/season.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/model/team.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';
import 'package:scoreboard/services/shared_preferences.dart';

typedef _Json = Map<String, dynamic>;

/// [ScoreboardRepository] backed by the Scoreboard backend
/// (`scoreboard_backend`). The server creates notifications, runs the
/// anniversary and recap jobs, and checks the business rules again.
///
/// The session is a bearer token kept in [SharedPreference] with the
/// user's id, so [sessionUserId] stays synchronous.
class RestScoreboardRepository implements ScoreboardRepository {
  final ApiClient _api;
  final SharedPreference _preferences;

  RestScoreboardRepository(this._api, this._preferences);

  @override
  String? get sessionUserId =>
      _preferences.sessionToken == null ? null : _preferences.sessionUserId;

  @override
  Future<UserProfile> getCurrentUser() async {
    if (sessionUserId == null) throw const AuthException(AuthError.notSignedIn);
    return UserProfile.fromJson(await _object(() => _api.get(ApiEndpoints.me)));
  }

  @override
  Future<UserProfile> signIn(String email, String password) async =>
      _startSession(await _object(() => _api.post(ApiEndpoints.login,
          data: {'email': email, 'password': password})));

  @override
  Future<UserProfile> register(RegistrationDraft draft) async =>
      _startSession(await _object(() => _api.post(ApiEndpoints.register, data: {
            'name': draft.name,
            'role': draft.role,
            'email': draft.email,
            'password': draft.password,
            if (draft.inviteCode case final code?) 'invite_code': code,
            if (draft.newCompany case final company?)
              'company': {
                'name': company.name,
                'industry': company.industry,
                'location': company.location,
              },
          })));

  Future<UserProfile> _startSession(_Json session) async {
    final user = UserProfile.fromJson(session['user']);
    await _preferences.setSessionToken(session['token']);
    await _preferences.setSessionUserId(user.id);
    return user;
  }

  @override
  Future<void> signOut() async {
    try {
      await _send(() => _api.post(ApiEndpoints.logout));
    } finally {
      // Signed out locally even when the server can't be reached.
      await _endSession();
    }
  }

  Future<void> _endSession() async {
    await _preferences.setSessionToken(null);
    await _preferences.setSessionUserId(null);
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) =>
      _send(() => _api.post(ApiEndpoints.password, data: {
            'current_password': currentPassword,
            'new_password': newPassword,
          }));

  @override
  Future<UserProfile> saveCurrentUser(UserProfile profile) async =>
      UserProfile.fromJson(await _object(
          () => _api.put(ApiEndpoints.me, data: profile.toJson())));

  @override
  Future<List<UserProfile>> getUsers() =>
      _list(() => _api.get(ApiEndpoints.users), UserProfile.fromJson);

  @override
  Future<List<Company>> getCompanies() =>
      _list(() => _api.get(ApiEndpoints.companies), Company.fromJson);

  @override
  Future<List<Achievement>> getAchievements() =>
      _list(() => _api.get(ApiEndpoints.achievements), Achievement.fromJson);

  @override
  Future<void> addAchievement(Achievement achievement,
          {bool notifyRecipient = true}) =>
      _send(() => _api.post(ApiEndpoints.achievements,
          data: achievement.toJson(),
          query: notifyRecipient ? null : {'notify': 'false'}));

  @override
  Future<List<AchievementTemplate>> getTemplates() => _list(
      () => _api.get(ApiEndpoints.templates), AchievementTemplate.fromJson);

  @override
  Future<void> addTemplate(AchievementTemplate template) =>
      _send(() => _api.post(ApiEndpoints.templates, data: template.toJson()));

  @override
  Future<void> deleteTemplate(String templateId) =>
      _send(() => _api.delete(ApiEndpoints.template(templateId)));

  @override
  Future<List<CatalogAchievement>> getCatalog(String companyId) => _list(
      () => _api.get(ApiEndpoints.catalog(companyId)),
      CatalogAchievement.fromJson);

  @override
  Future<void> saveCatalogAchievement(CatalogAchievement achievement) =>
      _send(() => _api.put(ApiEndpoints.catalogAchievement(achievement.id),
          data: achievement.toJson()));

  @override
  Future<List<VerificationRequest>> getRequests(String companyId) => _list(
      () => _api.get(ApiEndpoints.requests(companyId)),
      VerificationRequest.fromJson);

  @override
  Future<void> saveRequest(VerificationRequest request) => _send(
      () => _api.put(ApiEndpoints.request(request.id), data: request.toJson()));

  @override
  Future<List<FeedReaction>> getReactions() =>
      _list(() => _api.get(ApiEndpoints.reactions), FeedReaction.fromJson);

  /// The server reacts as the signed-in user; [userId] is always theirs.
  @override
  Future<void> setReaction(
          String achievementId, String userId, ReactionType? type) =>
      _send(() => _api.put(ApiEndpoints.reaction(achievementId),
          data: {'type': type?.name}));

  @override
  Future<List<FeedComment>> getComments() =>
      _list(() => _api.get(ApiEndpoints.comments), FeedComment.fromJson);

  @override
  Future<void> addComment(FeedComment comment) =>
      _send(() => _api.post(ApiEndpoints.comments, data: comment.toJson()));

  /// The server answers with the signed-in user's notifications.
  @override
  Future<List<AppNotification>> getNotifications(String userId) => _list(
      () => _api.get(ApiEndpoints.notifications), AppNotification.fromJson);

  @override
  Future<void> updateNotifications(List<AppNotification> notifications) =>
      _send(() => _api.patch(ApiEndpoints.notifications, data: [
            for (final n in notifications)
              {'id': n.id, 'read': n.read, 'delivered': n.delivered},
          ]));

  @override
  Future<List<Team>> getTeams(String companyId) =>
      _list(() => _api.get(ApiEndpoints.teams(companyId)), Team.fromJson);

  @override
  Future<void> saveTeam(Team team) =>
      _send(() => _api.put(ApiEndpoints.team(team.id), data: team.toJson()));

  @override
  Future<void> deleteTeam(String teamId) =>
      _send(() => _api.delete(ApiEndpoints.team(teamId)));

  @override
  Future<void> setUserTeam(String userId, String? teamId) => _send(
      () => _api.put(ApiEndpoints.userTeam(userId), data: {'team_id': teamId}));

  @override
  Future<List<Season>> getSeasons(String companyId) =>
      _list(() => _api.get(ApiEndpoints.seasons(companyId)), Season.fromJson);

  @override
  Future<void> saveSeason(Season season) => _send(
      () => _api.put(ApiEndpoints.season(season.id), data: season.toJson()));

  @override
  Future<void> deleteSeason(String seasonId) =>
      _send(() => _api.delete(ApiEndpoints.season(seasonId)));

  @override
  Future<List<ActivityEntry>> getActivity(String companyId) => _list(
      () => _api.get(ApiEndpoints.activity(companyId)), ActivityEntry.fromJson);

  @override
  Future<void> addActivity(ActivityEntry entry) =>
      _send(() => _api.post(ApiEndpoints.newActivity, data: entry.toJson()));

  @override
  Future<CompanySettings> getCompanySettings(String companyId) async =>
      CompanySettings.fromJson(
          await _object(() => _api.get(ApiEndpoints.settings(companyId))));

  @override
  Future<void> saveCompanySettings(CompanySettings settings) => _send(() => _api
      .put(ApiEndpoints.settings(settings.companyId), data: settings.toJson()));

  @override
  Future<List<Invite>> getInvites(String companyId) =>
      _list(() => _api.get(ApiEndpoints.invites(companyId)), Invite.fromJson);

  /// The server emails the code; the invitation it returns has none.
  @override
  Future<Invite> createInvite(String email,
      {required String languageCode}) async {
    final admin = await getCurrentUser();
    return Invite.fromJson(await _object(() => _api.post(
        ApiEndpoints.invites(admin.companyId),
        data: {'email': email, 'language': languageCode})));
  }

  @override
  Future<void> revokeInvite(String inviteId) =>
      _send(() => _api.delete(ApiEndpoints.invite(inviteId)));

  @override
  Future<void> setCompanyAdmin(String userId, bool isAdmin) =>
      _send(() => _api.put(ApiEndpoints.userAdmin(userId),
          data: {'is_company_admin': isAdmin}));

  Future<List<T>> _list<T>(
      Future<dynamic> Function() request, T Function(_Json) fromJson) async {
    final response = await _call(request);
    return [for (final json in response.data as List) fromJson(json as _Json)];
  }

  Future<_Json> _object(Future<dynamic> Function() request) async =>
      (await _call(request)).data as _Json;

  Future<void> _send(Future<dynamic> Function() request) async {
    await _call(request);
  }

  /// Runs [request] and turns the server's error codes into the domain
  /// exceptions the interactors and views already handle. Other failures
  /// (no connection, server errors) stay [ApiError]s.
  Future<dynamic> _call(Future<dynamic> Function() request) async {
    try {
      return await request();
    } on ApiError catch (error) {
      final details = error.details ?? const {};
      final code = details['code'];
      switch (details['type']) {
        case 'auth':
          final authError = AuthError.values.asNameMap()[code];
          if (authError == AuthError.notSignedIn) await _endSession();
          if (authError != null) throw AuthException(authError);
        case 'admin':
          final adminError = AdminError.values.asNameMap()[code];
          if (adminError != null) throw AdminException(adminError);
        case 'send':
          final sendError = SendAchievementError.values.asNameMap()[code];
          if (sendError != null) {
            throw SendAchievementException(sendError,
                templateName: details['template_name'],
                colleagueName: details['colleague_name']);
          }
      }
      rethrow;
    }
  }
}
