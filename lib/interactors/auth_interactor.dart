import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

class AuthInteractor {
  static const int minPasswordLength = 8;

  final ScoreboardRepository _repository;

  AuthInteractor(this._repository);

  bool get isSignedIn => _repository.sessionUserId != null;

  static bool isValidEmail(String email) =>
      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email.trim());

  Future<UserProfile> signIn(String email, String password) async {
    if (email.trim().isEmpty || password.isEmpty) {
      throw const AuthException("Enter your email and password.");
    }
    return _repository.signIn(email, password);
  }

  Future<UserProfile> register(RegistrationDraft draft) async {
    if (draft.name.trim().isEmpty || draft.role.trim().isEmpty) {
      throw const AuthException("Enter your name and role.");
    }
    if (!isValidEmail(draft.email)) {
      throw const AuthException("Enter a valid email address.");
    }
    _checkPassword(draft.password);
    return _repository.register(draft);
  }

  Future<void> signOut() => _repository.signOut();

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    _checkPassword(newPassword);
    return _repository.changePassword(currentPassword, newPassword);
  }

  Future<List<Company>> getCompanies() => _repository.getCompanies();

  void _checkPassword(String password) {
    if (password.length < minPasswordLength) {
      throw const AuthException(
          "The password must be at least $minPasswordLength characters.");
    }
  }
}
