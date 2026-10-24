import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/views/_base/base_contract.dart';

enum AuthMode { signIn, register }

/// How a new account gets its company: an existing one only by invitation.
enum RegisterMode { join, createCompany }

abstract class AuthViewContract extends BaseViewContract {
  void openApp();
}

abstract class AuthViewModelContract
    extends BaseViewModelContract<AuthState, AuthViewContract> {
  void onChangeMode(AuthMode mode);
  void onChangeRegisterMode(RegisterMode mode);
  void signIn(String email, String password);
  void register(RegistrationDraft draft);
}

class AuthState extends BaseVMState {
  AuthMode mode = AuthMode.signIn;
  RegisterMode registerMode = RegisterMode.join;
  bool isSubmitting = false;
  String? errorMessage;
}
