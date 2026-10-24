import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/interactors.dart';
import 'package:scoreboard/model/auth.dart';

import '../helpers/matchers.dart';
import '../helpers/test_app.dart';

RegistrationDraft _join(String inviteCode,
        {String name = 'Ada Lovelace',
        String role = 'Engineer',
        String email = 'ada@northwind.dev',
        String password = 'analytical'}) =>
    RegistrationDraft.join(
        name: name,
        role: role,
        email: email,
        password: password,
        inviteCode: inviteCode);

RegistrationDraft _create(String companyName,
        {String email = 'grace@acme.dev'}) =>
    RegistrationDraft.createCompany(
        name: 'Grace Hopper',
        role: 'Founder',
        email: email,
        password: 'compiler',
        newCompany: CompanyDraft(name: companyName, location: 'Udine, IT'));

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

  group('joining with an invitation', () {
    late String code;

    setUp(() async => code = await inviteToNorthwind('ada@northwind.dev'));

    test('creates an account that can sign in after a restart', () async {
      final user = await auth.register(_join(code));
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

    test('accepts the code in any case, with or without the dash', () async {
      final typed = code.toLowerCase().replaceAll('-', ' ');
      expect((await auth.register(_join(typed))).companyId, 'c_northwind');
    });

    test('needs the code sent to that very email', () async {
      await expectLater(
          auth.register(_join(code, email: 'mallory@northwind.dev')),
          throwsAuthError(AuthError.invalidInviteCode));
      await expectLater(auth.register(_join('ABCD-EFGH')),
          throwsAuthError(AuthError.invalidInviteCode));
      await expectLater(auth.register(_join('')),
          throwsAuthError(AuthError.invalidInviteCode));
    });

    test('a code works only once', () async {
      await auth.register(_join(code));
      await auth.signOut();
      await expectLater(auth.register(_join(code, email: 'ada2@northwind.dev')),
          throwsAuthError(AuthError.invalidInviteCode));
    });

    test('five wrong codes cancel the invitation', () async {
      for (var i = 0; i < 5; i++) {
        await expectLater(auth.register(_join('WRONG-CODE')),
            throwsAuthError(AuthError.invalidInviteCode));
      }
      await expectLater(auth.register(_join(code)),
          throwsAuthError(AuthError.invalidInviteCode));
    });

    test('checks the fields', () async {
      await expectLater(auth.register(_join(code, name: '  ')),
          throwsAuthError(AuthError.missingNameOrRole));
      await expectLater(auth.register(_join(code, email: 'ada')),
          throwsAuthError(AuthError.invalidEmail));
      await expectLater(auth.register(_join(code, password: 'short')),
          throwsAuthError(AuthError.passwordTooShort));
      await expectLater(auth.register(_join(code, email: demoEmail)),
          throwsAuthError(AuthError.emailTaken));
    });
  });

  group('creating a company', () {
    test('makes its first person the admin, after a restart too', () async {
      final user = await auth.register(_create('Acme'));
      expect(user.isCompanyAdmin, isTrue);
      final company =
          await getIt<ScoreboardInteractor>().getCompany(user.companyId);
      expect(company.name, 'Acme');
      expect(company.location, 'Udine, IT');

      await auth.signOut();
      await setUpApp(prefs: await savedPrefs());
      final again =
          await getIt<AuthInteractor>().signIn('grace@acme.dev', 'compiler');
      expect(again.isCompanyAdmin, isTrue);
      expect(
          (await getIt<ScoreboardInteractor>().getCompany(again.companyId))
              .name,
          'Acme');
    });

    test('needs a name nobody uses', () async {
      await expectLater(auth.register(_create('  ')),
          throwsAuthError(AuthError.missingCompanyName));
      await expectLater(auth.register(_create('northwind labs')),
          throwsAuthError(AuthError.companyNameTaken));
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
