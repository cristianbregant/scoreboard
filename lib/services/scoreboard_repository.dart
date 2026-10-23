import 'package:scoreboard/model/achievement.dart';
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

  Future<void> addAchievement(Achievement achievement);

  Future<List<AchievementTemplate>> getTemplates();

  Future<void> addTemplate(AchievementTemplate template);

  Future<void> deleteTemplate(String templateId);
}
