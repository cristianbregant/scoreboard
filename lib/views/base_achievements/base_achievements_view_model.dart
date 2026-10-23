import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/l10n_messages.dart';
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
      vmState.remainingBudget = options.remainingBudget;
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
      sourceView.showMessage(l10n.templateAdded(draft.name.trim()));
    } on SendAchievementException catch (e) {
      sourceView.showMessage(e.localized(l10n));
    } catch (_) {
      sourceView.showMessage(l10n.templateCreateError);
    }
  }

  @override
  Future<void> onTapDeleteTemplate(AchievementTemplate template) async {
    if (!await sourceView.confirmDeleteTemplate(template)) return;
    try {
      await interactor.deleteTemplate(template.id);
      sourceView.showMessage(l10n.templateDeleted(template.name));
    } on SendAchievementException catch (e) {
      sourceView.showMessage(e.localized(l10n));
    } catch (_) {
      sourceView.showMessage(l10n.templateDeleteError);
    }
  }
}
