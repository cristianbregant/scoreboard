import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_base/base_contract.dart';

abstract class ProfileViewContract extends BaseViewContract {
  void onTapAchievement(Achievement achievement);
  Future<ProfileDraft?> askEditProfile(UserProfile user);
  void showMessage(String message);
}

abstract class ProfileViewModelContract
    extends BaseViewModelContract<ProfileState, ProfileViewContract> {
  void loadProfile();
  void onTapAchievement(Achievement achievement);
  void onTapEditProfile();

  /// Opens the system file picker; used by the edit dialog.
  Future<String?> pickImage();
}

class ProfileState extends BaseVMState {
  static const int recentAchievementsCount = 5;

  UserProfile? user;
  Company? company;
  List<Achievement> achievements = [];
  int? companyRank;
  int? globalRank;

  int get totalPoints => achievements.fold(
      0, (sum, achievement) => sum + (achievement.points ?? 0));
  int get verifiedCount =>
      achievements.where((achievement) => achievement.verified == true).length;
  List<Achievement> get recentAchievements =>
      achievements.take(recentAchievementsCount).toList();
}
