import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/model/auth.dart';

import '../helpers/matchers.dart';
import '../helpers/test_app.dart';

RegistrationDraft _draft(
        {String name = 'Ada Lovelace',
        String role = 'Engineer',
        String email = 'ada@northwind.dev',
        String password = 'analytical'}) =>
    RegistrationDraft(
        name: name,
        role: role,
        companyId: 'c_northwind',
        email: email,
        password: password);

void main() {
  late AuthInteractor auth;

  setUp(() async {
    await setUpApp(prefs: basePrefs(signedIn: false));
    auth = getIt<AuthInteractor>();
  });

  test('validates email addresses', () {
    expect(AuthInteractor.isValidEmail(' a@b.co '), isTrue);
    expect(AuthInteractor.isValidEmail('a@b'), isFalse);
    expect(AuthInteractor.isValidEmail('no spaces@b.co'), isFalse);
    expect(AuthInteractor.isValidEmail(''), isFalse);
  });

  group('sign in', () {
    test('works with the demo account, ignoring email case', () async {
      expect(auth.isSignedIn, isFalse);
      final user = await auth.signIn(demoEmail.toUpperCase(), demoPassword);
      expect(user.id, demoUserId);
      expect(auth.isSignedIn, isTrue);
    });

    test('rejects missing or wrong credentials', () async {
      await expectLater(
          auth.signIn('', ''), throwsAuthError(AuthError.missingCredentials));
      await expectLater(auth.signIn(demoEmail, 'wrong-password'),
          throwsAuthError(AuthError.wrongCredentials));
      await expectLater(auth.signIn('nobody@northwind.dev', demoPassword),
          throwsAuthError(AuthError.wrongCredentials));
      expect(auth.isSignedIn, isFalse);
    });

    test('signing out ends the session', () async {
      await auth.signIn(demoEmail, demoPassword);
      await auth.signOut();
      expect(auth.isSignedIn, isFalse);
    });
  });

  group('registration', () {
    test('creates an account that can sign in after a restart', () async {
      final user = await auth.register(_draft());
      expect(user.name, 'Ada Lovelace');
      expect(user.companyId, 'c_northwind');
      expect(user.isCompanyAdmin, isFalse);
      expect(auth.isSignedIn, isTrue);

      await auth.signOut();
      await setUpApp(prefs: await savedPrefs());
      final again = await getIt<AuthInteractor>()
          .signIn('ada@northwind.dev', 'analytical');
      expect(again.id, user.id);
    });

    test('checks the fields', () async {
      await expectLater(auth.register(_draft(name: '  ')),
          throwsAuthError(AuthError.missingNameOrRole));
      await expectLater(auth.register(_draft(email: 'ada')),
          throwsAuthError(AuthError.invalidEmail));
      await expectLater(auth.register(_draft(password: 'short')),
          throwsAuthError(AuthError.passwordTooShort));
      await expectLater(auth.register(_draft(email: demoEmail)),
          throwsAuthError(AuthError.emailTaken));
    });
  });

  group('change password', () {
    setUp(() => auth.signIn(demoEmail, demoPassword));

    test('needs the current password', () async {
      await expectLater(auth.changePassword('nope', 'new-password'),
          throwsAuthError(AuthError.wrongCurrentPassword));
      await expectLater(auth.changePassword(demoPassword, 'short'),
          throwsAuthError(AuthError.passwordTooShort));
    });

    test('replaces the old password', () async {
      await auth.changePassword(demoPassword, 'new-password');
      await auth.signOut();
      await expectLater(auth.signIn(demoEmail, demoPassword),
          throwsAuthError(AuthError.wrongCredentials));
      expect((await auth.signIn(demoEmail, 'new-password')).id, demoUserId);
    });
  });
}
