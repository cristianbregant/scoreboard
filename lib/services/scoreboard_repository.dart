import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/model/company_settings.dart';
import 'package:scoreboard/model/season.dart';
import 'package:scoreboard/model/team.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/chat_integration.dart';
import 'package:scoreboard/model/feed.dart';
import 'package:scoreboard/model/invite.dart';
import 'package:scoreboard/model/issued_credential.dart';
import 'package:scoreboard/model/sso.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/model/achievement_template.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/user_profile.dart';

/// Data source for the scoreboard. [MockScoreboardRepository] is the local
/// implementation; a REST implementation can be swapped in via the locator.
abstract class ScoreboardRepository {
  /// Id of the signed-in user, null when signed out.
  String? get sessionUserId;

  /// Throws [AuthException] when nobody is signed in.
  Future<UserProfile> getCurrentUser();

  /// Throws [AuthException] when the credentials are wrong.
  Future<UserProfile> signIn(String email, String password);

  /// Creates the user and signs them in: into the company that invited
  /// them, or into a new company they become the admin of. Throws
  /// [AuthException] when the email is already registered, the invitation
  /// code is not valid or the company name is taken.
  Future<UserProfile> register(RegistrationDraft draft);

  Future<void> signOut();

  /// Single sign-on providers the backend offers; none on the local mock.
  Future<List<SsoProvider>> getSsoProviders();

  /// Where the browser starts single sign-on with [providerId]; the backend
  /// sends the code to [redirectUri] with [state].
  Uri ssoStartUrl(String providerId,
      {required Uri redirectUri, required String state});

  /// Trades the one-time code of single sign-on for a session. Throws
  /// [AuthException] with [AuthError.ssoFailed] when it's not valid.
  Future<UserProfile> completeSso(String code);

  Future<void> changePassword(String currentPassword, String newPassword);

  /// Saves the signed-in user's profile. Throws [AuthException] when the
  /// email belongs to someone else.
  Future<UserProfile> saveCurrentUser(UserProfile profile);

  Future<List<UserProfile>> getUsers();

  Future<List<Company>> getCompanies();

  Future<List<Achievement>> getAchievements();

  /// Adds an achievement and notifies its recipient, unless
  /// [notifyRecipient] is false (e.g. when a request approval says it).
  Future<void> addAchievement(Achievement achievement,
      {bool notifyRecipient = true});

  Future<List<AchievementTemplate>> getTemplates();

  Future<void> addTemplate(AchievementTemplate template);

  Future<void> deleteTemplate(String templateId);

  /// The company's catalog of verified achievements, archived ones included.
  Future<List<CatalogAchievement>> getCatalog(String companyId);

  /// Inserts or updates a catalog achievement.
  Future<void> saveCatalogAchievement(CatalogAchievement achievement);

  Future<List<VerificationRequest>> getRequests(String companyId);

  /// Inserts or updates a request. A new request notifies the company's
  /// admins; a decision notifies the requester.
  Future<void> saveRequest(VerificationRequest request);

  Future<List<FeedReaction>> getReactions();

  /// Sets or, with a null [type], removes the user's reaction. Notifies the
  /// recipient of the achievement.
  Future<void> setReaction(
      String achievementId, String userId, ReactionType? type);

  Future<List<FeedComment>> getComments();

  /// Notifies the recipient of the achievement.
  Future<void> addComment(FeedComment comment);

  /// The user's notifications, newest first.
  Future<List<AppNotification>> getNotifications(String userId);

  /// Saves read/delivered changes.
  Future<void> updateNotifications(List<AppNotification> notifications);

  Future<List<Team>> getTeams(String companyId);

  /// Inserts or updates a team.
  Future<void> saveTeam(Team team);

  /// Deletes the team; its members are left without one.
  Future<void> deleteTeam(String teamId);

  /// Moves [userId] to [teamId], or out of any team with null.
  Future<void> setUserTeam(String userId, String? teamId);

  /// Oldest first.
  Future<List<Season>> getSeasons(String companyId);

  /// Inserts or updates a season.
  Future<void> saveSeason(Season season);

  Future<void> deleteSeason(String seasonId);

  /// Newest first.
  Future<List<ActivityEntry>> getActivity(String companyId);

  Future<void> addActivity(ActivityEntry entry);

  /// Defaults when the company never changed them.
  Future<CompanySettings> getCompanySettings(String companyId);

  /// Also brings the work anniversary achievements in line with them.
  Future<void> saveCompanySettings(CompanySettings settings);

  /// Invitations not used yet, expired ones included, newest first.
  Future<List<Invite>> getInvites(String companyId);

  /// Invites [email] to the signed-in admin's company and emails them a
  /// code, written in [languageCode]. Replaces an earlier invitation of the
  /// same email. Throws [AdminException] when the email has an account or
  /// can't be reached.
  Future<Invite> createInvite(String email, {required String languageCode});

  /// Invites many people at once (see [createInvite]); each draft succeeds
  /// or is skipped on its own. At most [maxBulkInvites] per call.
  Future<BulkInviteResult> createInvites(List<InviteDraft> drafts,
      {required String languageCode});

  /// Drafts one import may hold.
  static const int maxBulkInvites = 500;

  Future<void> revokeInvite(String inviteId);

  /// Grants or revokes the admin role. Throws [AdminException] with
  /// [AdminError.lastAdmin] for the company's only admin.
  Future<void> setCompanyAdmin(String userId, bool isAdmin);

  /// The company's Teams and Slack channels. Admins only.
  Future<ChatIntegration> getChatIntegration(String companyId);

  /// Throws [AdminException] with [AdminError.invalidWebhook] for URLs that
  /// aren't Teams or Slack webhooks.
  Future<ChatIntegration> updateChatIntegration(
      String companyId, ChatIntegrationUpdate update);

  /// Posts a test message to [channel]. Throws [AdminException] with
  /// [AdminError.webhookFailed] when the service refuses it.
  Future<void> testChatIntegration(String companyId, ChatChannel channel);

  /// The verified achievement [achievementId] signed by the issuer, with
  /// its public verification page. Null when this data source can't sign
  /// (the local mock): only the backend holds the issuer's key.
  Future<IssuedCredential?> getCredential(String achievementId);
}
