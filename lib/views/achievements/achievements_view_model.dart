import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';
import 'package:scoreboard/views/achievements/achievements_contract.dart';
import 'package:scoreboard/widgets/achievement_style.dart';

class AchievementsViewModel
    extends BaseViewModel<AchievementsViewContract, AchievementsState>
    with SendAchievementFlow<AchievementsViewContract, AchievementsState>
    implements AchievementsViewModelContract {
  @override
  final ScoreboardInteractor interactor;

  AchievementsViewModel(this.interactor);

  @override
  void onInitState() => loadAchievements();

  @override
  Future<void> loadAchievements() async {
    vmState.hasError = false;
    startLoadingState();
    try {
      final user = await interactor.getCurrentUser();
      vmState.achievements = await interactor.getAchievementsOf(user.id);
    } catch (_) {
      vmState.hasError = true;
    }
    stopLoadingState();
  }

  @override
  void onTapAchievement(Achievement achievement) {
    sourceView.onTapAchievement(achievement);
  }

  @override
  void onSelectTier(AchievementTier? tier) {
    vmState.selectedTier = tier;
    notifyListeners();
  }
}
