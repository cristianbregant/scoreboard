import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';
import 'package:scoreboard/widgets/achievement_style.dart';

abstract class AchievementsViewContract extends SendAchievementViewContract {
  void onTapAchievement(Achievement achievement);
}

abstract class AchievementsViewModelContract
    extends BaseViewModelContract<AchievementsState, AchievementsViewContract>
    implements SendAchievementActions {
  void loadAchievements();
  void onTapAchievement(Achievement achievement);
  void onSelectTier(AchievementTier? tier);
}

class AchievementsState extends BaseVMState {
  List<Achievement> achievements = [];

  /// null shows every tier.
  AchievementTier? selectedTier;

  List<Achievement> get visibleAchievements => selectedTier == null
      ? achievements
      : achievements.where((a) => a.tier == selectedTier).toList();

  int countOf(AchievementTier tier) =>
      achievements.where((a) => a.tier == tier).length;

  int get totalPoints => achievements.fold(
      0, (sum, achievement) => sum + (achievement.points ?? 0));

  int get verifiedCount =>
      achievements.where((achievement) => achievement.verified == true).length;
}
