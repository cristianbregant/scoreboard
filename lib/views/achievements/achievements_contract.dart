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
  void onSearchChanged(String query);
  void onSortChanged(AchievementSort sort);
  void onTapOpenCatalog();
}

enum AchievementSort { newest, oldest, points, name }

class AchievementsState extends BaseVMState {
  List<Achievement> achievements = [];

  /// null shows every tier.
  AchievementTier? selectedTier;
  String query = '';
  AchievementSort sort = AchievementSort.newest;

  List<Achievement> get visibleAchievements {
    final needle = query.trim().toLowerCase();
    bool matches(String? value) =>
        value != null && value.toLowerCase().contains(needle);
    final visible = achievements
        .where((a) => selectedTier == null || a.tier == selectedTier)
        .where((a) =>
            needle.isEmpty ||
            matches(a.name) ||
            matches(a.description) ||
            matches(a.company) ||
            matches(a.awardedByName))
        .toList();
    final epoch = DateTime(0);
    visible.sort(switch (sort) {
      AchievementSort.newest => (a, b) =>
          (b.date ?? epoch).compareTo(a.date ?? epoch),
      AchievementSort.oldest => (a, b) =>
          (a.date ?? epoch).compareTo(b.date ?? epoch),
      AchievementSort.points => (a, b) =>
          (b.points ?? 0).compareTo(a.points ?? 0),
      AchievementSort.name => (a, b) =>
          (a.name ?? '').toLowerCase().compareTo((b.name ?? '').toLowerCase()),
    });
    return visible;
  }

  int countOf(AchievementTier tier) =>
      achievements.where((a) => a.tier == tier).length;

  int get totalPoints => achievements.fold(
      0, (sum, achievement) => sum + (achievement.points ?? 0));

  int get verifiedCount =>
      achievements.where((achievement) => achievement.verified == true).length;
}
