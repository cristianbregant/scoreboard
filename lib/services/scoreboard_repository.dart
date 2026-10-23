import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/feed.dart';
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

  /// Creates the user and signs them in. Throws [AuthException] when the
  /// email is already registered.
  Future<UserProfile> register(RegistrationDraft draft);

  Future<void> signOut();

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
}
