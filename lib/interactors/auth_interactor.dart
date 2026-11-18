import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/sso.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';
import 'package:scoreboard/services/sso_service.dart';

class AuthInteractor {
  static const int minPasswordLength = 8;

  final ScoreboardRepository _repository;
  final ScoreboardInteractor _scoreboard;
  final SsoService _sso;

  AuthInteractor(this._repository, this._scoreboard, this._sso);

  /// Providers to offer as buttons. None when the backend can't be reached:
  /// signing in with a password still works.
  Future<List<SsoProvider>> ssoProviders() async {
    try {
      return await _repository.getSsoProviders();
    } catch (_) {
      return const [];
    }
  }

  /// Why the last single sign-on failed, when the page came back from one
  /// (web); read once by the sign-in screen.
  static AuthError? _pendingSsoError;

  AuthError? takePendingSsoError() {
    final error = _pendingSsoError;
    _pendingSsoError = null;
    return error;
  }

  /// Finishes a sign-in the page came back from (web): the code is traded
  /// for a session, or the failure kept for the sign-in screen.
  Future<void> finishSsoRedirect(
      ({String? code, AuthError? error}) result) async {
    final code = result.code;
    if (code == null) {
      _pendingSsoError = result.error ?? AuthError.ssoFailed;
      return;
    }
    try {
      await _repository.completeSso(code);
      _scoreboard.dataChanged();
    } on AuthException catch (e) {
      _pendingSsoError = e.error;
    } catch (_) {
      _pendingSsoError = AuthError.ssoFailed;
    }
  }

  /// Signs in through [provider] in the browser.
  Future<UserProfile> signInWithSso(SsoProvider provider,
      {required SsoPageTexts texts}) async {
    final code = await _sso.authorize(
        (redirectUri, state) => _repository.ssoStartUrl(provider.id,
            redirectUri: redirectUri, state: state),
        texts: texts);
    final user = await _repository.completeSso(code);
    _scoreboard.dataChanged();
    return user;
  }

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
    if (draft.newCompany case final company? when company.name.trim().isEmpty) {
      throw const AuthException(AuthError.missingCompanyName);
    }
    if (draft.inviteCode case final code? when code.trim().isEmpty) {
      throw const AuthException(AuthError.invalidInviteCode);
    }
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

  void _checkPassword(String password) {
    if (password.length < minPasswordLength) {
      throw const AuthException(AuthError.passwordTooShort);
    }
  }
}
