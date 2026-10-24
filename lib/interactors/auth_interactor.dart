import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

class AuthInteractor {
  static const int minPasswordLength = 8;

  final ScoreboardRepository _repository;
  final ScoreboardInteractor _scoreboard;

  AuthInteractor(this._repository, this._scoreboard);

  bool get isSignedIn => _repository.sessionUserId != null;

  static bool isValidEmail(String email) =>
      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email.trim());

  Future<UserProfile> signIn(String email, String password) async {
    if (email.trim().isEmpty || password.isEmpty) {
      throw const AuthException(AuthError.missingCredentials);
    }
    final user = await _repository.signIn(email, password);
    // A new session: the app reloads what depends on the user, such as
    // their company's colors.
    _scoreboard.dataChanged();
    return user;
  }

  Future<UserProfile> register(RegistrationDraft draft) async {
    if (draft.name.trim().isEmpty || draft.role.trim().isEmpty) {
      throw const AuthException(AuthError.missingNameOrRole);
    }
    if (!isValidEmail(draft.email)) {
      throw const AuthException(AuthError.invalidEmail);
    }
    _checkPassword(draft.password);
    final user = await _repository.register(draft);
    _scoreboard.dataChanged();
    return user;
  }

  Future<void> signOut() async {
    await _repository.signOut();
    _scoreboard.dataChanged();
  }

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    _checkPassword(newPassword);
    return _repository.changePassword(currentPassword, newPassword);
  }

  Future<List<Company>> getCompanies() => _repository.getCompanies();

  void _checkPassword(String password) {
    if (password.length < minPasswordLength) {
      throw const AuthException(AuthError.passwordTooShort);
    }
  }
}
