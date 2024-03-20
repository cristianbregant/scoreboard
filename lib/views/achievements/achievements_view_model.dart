import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/achievements/achievements_contract.dart';

class AchievementsViewModel
    extends BaseViewModel<AchievementsViewContract, AchievementsState>
    implements AchievementsViewModelContract {
  @override
  void onTapAchievement(Achievement achievement) {
    print('Tapped achievement: ${achievement.name}');
    sourceView.onTapAchievement(achievement);
  }
}
