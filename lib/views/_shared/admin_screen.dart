import 'package:flutter/material.dart';
import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';

/// View side shared by the admin console screens.
abstract class AdminViewContract extends BaseViewContract {
  void showMessage(String message);

  /// Asks before a destructive action.
  Future<bool> confirm(
      {required String title, required String body, required String action});
}

/// Loading, reloading when the data changes elsewhere, and running actions
/// with their outcome shown as a message.
mixin AdminScreenFlow<V extends AdminViewContract, S extends BaseVMState>
    on BaseViewModel<V, S> {
  ScoreboardInteractor get scoreboard;

  /// Fills the state; may throw.
  Future<void> fetch();

  @override
  void onInitState() {
    scoreboard.addListener(_reloadSilently);
    load();
  }

  @override
  void onDispose() => scoreboard.removeListener(_reloadSilently);

  Future<void> load() async {
    vmState.hasError = false;
    startLoadingState();
    await _safeFetch();
    stopLoadingState();
  }

  Future<void> _reloadSilently() async {
    await _safeFetch();
    notifyListeners();
  }

  Future<void> _safeFetch() async {
    try {
      await fetch();
    } catch (_) {
      vmState.hasError = true;
    }
  }

  /// Runs [action]; shows [success] or the error. Returns whether it worked.
  Future<bool> runAction(Future<void> Function() action,
      {String? success}) async {
    try {
      await action();
      if (success != null) sourceView.showMessage(success);
      return true;
    } on AdminException catch (e) {
      sourceView.showMessage(e.localized(l10n));
    } catch (_) {
      sourceView.showMessage(l10n.actionError);
    }
    return false;
  }
}

/// Implements [AdminViewContract] for a screen's State.
mixin AdminScreenMessages<T extends StatefulWidget> on State<T> {
  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<bool> confirm(
      {required String title,
      required String body,
      required String action}) async {
    final colorScheme = Theme.of(context).colorScheme;
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: SizedBox(width: 420, child: Text(body)),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(context.l10n.commonCancel)),
              FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: colorScheme.error,
                      foregroundColor: colorScheme.onError),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(action)),
            ],
          ),
        ) ??
        false;
  }
}
