import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/l10n_messages.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/widgets/dialogs/send_achievement_dialog.dart';

/// View side of the "send an achievement to a colleague" flow, shared by
/// every screen that offers it.
abstract class SendAchievementViewContract extends BaseViewContract {
  Future<SendAchievementRequest?> askSendAchievement(
      SendAchievementOptions options,
      {String? colleagueId,
      String? templateId});

  void showMessage(String message);
}

abstract class SendAchievementActions {
  void onTapSendAchievement({String? colleagueId, String? templateId});
}

mixin SendAchievementFlow<V extends SendAchievementViewContract,
    S extends BaseVMState> on BaseViewModel<V, S> {
  ScoreboardInteractor get interactor;

  Future<void> onTapSendAchievement(
      {String? colleagueId, String? templateId}) async {
    final SendAchievementOptions options;
    try {
      options = await interactor.getSendOptions();
    } catch (_) {
      sourceView.showMessage(l10n.sendLoadError);
      return;
    }
    if (options.colleagues.isEmpty) {
      sourceView.showMessage(l10n.sendNoColleagues);
      return;
    }
    if (options.templates.isEmpty) {
      sourceView.showMessage(l10n.sendNoTemplates);
      return;
    }
    if (options.remainingBudget == 0) {
      sourceView.showMessage(
          l10n.errorBudgetExhausted(SendAchievementOptions.monthlyBudget));
      return;
    }

    final request = await sourceView.askSendAchievement(options,
        colleagueId: colleagueId, templateId: templateId);
    if (request == null) return;

    try {
      await interactor.sendAchievement(request);
      final colleague =
          options.colleagues.firstWhere((u) => u.id == request.colleagueId);
      sourceView.showMessage(l10n.sendSuccess(colleague.name));
    } on SendAchievementException catch (e) {
      sourceView.showMessage(e.localized(l10n));
    } catch (_) {
      sourceView.showMessage(l10n.sendError);
    }
  }
}

/// Implements [SendAchievementViewContract] for a screen's State.
mixin SendAchievementDialogs<T extends StatefulWidget> on State<T> {
  Future<SendAchievementRequest?> askSendAchievement(
      SendAchievementOptions options,
      {String? colleagueId,
      String? templateId}) {
    return showSendAchievementDialog(context, options,
        colleagueId: colleagueId, templateId: templateId);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
