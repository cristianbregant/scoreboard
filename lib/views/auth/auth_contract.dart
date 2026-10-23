import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/views/_base/base_contract.dart';

enum AuthMode { signIn, register }

abstract class AuthViewContract extends BaseViewContract {
  void openApp();
}

abstract class AuthViewModelContract
    extends BaseViewModelContract<AuthState, AuthViewContract> {
  void onChangeMode(AuthMode mode);
  void signIn(String email, String password);
  void register(RegistrationDraft draft);
}

class AuthState extends BaseVMState {
  AuthMode mode = AuthMode.signIn;
  bool isSubmitting = false;
  String? errorMessage;
  List<Company> companies = [];
}
