import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/achievement_template.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';
import 'package:scoreboard/views/base_achievements/base_achievements_contract.dart';

class BaseAchievementsViewModel
    extends BaseViewModel<BaseAchievementsViewContract, BaseAchievementsState>
    with
        SendAchievementFlow<BaseAchievementsViewContract, BaseAchievementsState>
    implements BaseAchievementsViewModelContract {
  @override
  final ScoreboardInteractor interactor;

  BaseAchievementsViewModel(this.interactor);

  @override
  void onInitState() {
    interactor.addListener(loadTemplates);
    loadTemplates();
  }

  @override
  void onDispose() => interactor.removeListener(loadTemplates);

  @override
  Future<void> loadTemplates() async {
    vmState.hasError = false;
    startLoadingState();
    try {
      final options = await interactor.getSendOptions();
      vmState.currentUserId = options.currentUser.id;
      vmState.templates = options.templates;
      vmState.colleagues = {for (final u in options.colleagues) u.id: u};
      vmState.sent = await interactor.getSentAchievements();
    } catch (_) {
      vmState.hasError = true;
    }
    stopLoadingState();
  }

  @override
  Future<void> onTapCreateTemplate() async {
    final draft = await sourceView.askNewTemplate();
    if (draft == null) return;
    try {
      await interactor.createTemplate(draft);
      sourceView.showMessage("\"${draft.name.trim()}\" added to the library");
    } on SendAchievementException catch (e) {
      sourceView.showMessage(e.message);
    } catch (_) {
      sourceView.showMessage("Could not create the achievement. Try again.");
    }
  }

  @override
  Future<void> onTapDeleteTemplate(AchievementTemplate template) async {
    if (!await sourceView.confirmDeleteTemplate(template)) return;
    try {
      await interactor.deleteTemplate(template.id);
      sourceView.showMessage("\"${template.name}\" deleted");
    } on SendAchievementException catch (e) {
      sourceView.showMessage(e.message);
    } catch (_) {
      sourceView.showMessage("Could not delete the achievement. Try again.");
    }
  }
}
