import 'package:scoreboard/interactors/interactors.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/settings/settings_contract.dart';

class SettingsViewModel
    extends BaseViewModel<SettingsViewContract, SettingsState>
    implements SettingsViewModelContract {
  final ScoreboardInteractor _scoreboardInteractor;
  final AuthInteractor _authInteractor;
  final AppConfigurationInteractor _appConfigurationInteractor;

  SettingsViewModel(this._scoreboardInteractor, this._authInteractor,
      this._appConfigurationInteractor);

  @override
  void onInitState() {
    vmState.appName = _appConfigurationInteractor.appName;
    vmState.appVersion = _appConfigurationInteractor.appVersion;
    loadAccount();
  }

  @override
  void onTapChangePage(int page) {
    vmState.currentPage = page;
    notifyListeners();
  }

  @override
  Future<void> loadAccount() async {
    vmState.hasError = false;
    startLoadingState();
    try {
      sourceView.fillAccountForm(await _scoreboardInteractor.getCurrentUser());
    } catch (_) {
      vmState.hasError = true;
    }
    stopLoadingState();
  }

  @override
  Future<void> saveEmail(String email) async {
    vmState.isSavingEmail = true;
    notifyListeners();
    try {
      await _scoreboardInteractor.updateEmail(email);
      sourceView.showMessage("Email updated");
    } on AuthException catch (e) {
      sourceView.showMessage(e.message);
    } catch (_) {
      sourceView.showMessage("Could not save your email. Try again.");
    }
    vmState.isSavingEmail = false;
    notifyListeners();
  }

  @override
  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    vmState.isChangingPassword = true;
    notifyListeners();
    try {
      await _authInteractor.changePassword(currentPassword, newPassword);
      sourceView.clearPasswordForm();
      sourceView.showMessage("Password changed");
    } on AuthException catch (e) {
      sourceView.showMessage(e.message);
    } catch (_) {
      sourceView.showMessage("Could not change your password. Try again.");
    }
    vmState.isChangingPassword = false;
    notifyListeners();
  }

  @override
  Future<void> signOut() async {
    try {
      await _authInteractor.signOut();
      sourceView.openSignIn();
    } catch (_) {
      sourceView.showMessage("Could not sign out. Try again.");
    }
  }
}
