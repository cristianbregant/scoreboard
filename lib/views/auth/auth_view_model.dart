import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/auth/auth_contract.dart';

class AuthViewModel extends BaseViewModel<AuthViewContract, AuthState>
    implements AuthViewModelContract {
  final AuthInteractor _interactor;

  AuthViewModel(this._interactor);

  @override
  void onChangeMode(AuthMode mode) {
    vmState.mode = mode;
    vmState.errorMessage = null;
    notifyListeners();
  }

  @override
  void onChangeRegisterMode(RegisterMode mode) {
    vmState.registerMode = mode;
    vmState.errorMessage = null;
    notifyListeners();
  }

  @override
  Future<void> signIn(String email, String password) =>
      _submit(() => _interactor.signIn(email, password));

  @override
  Future<void> register(RegistrationDraft draft) =>
      _submit(() => _interactor.register(draft));

  Future<void> _submit(Future<void> Function() action) async {
    if (vmState.isSubmitting) return;
    vmState.isSubmitting = true;
    vmState.errorMessage = null;
    notifyListeners();
    try {
      await action();
      sourceView.openApp();
    } on AuthException catch (e) {
      vmState.errorMessage = e.localized(l10n);
    } catch (_) {
      vmState.errorMessage = l10n.genericError;
    }
    vmState.isSubmitting = false;
    notifyListeners();
  }
}
