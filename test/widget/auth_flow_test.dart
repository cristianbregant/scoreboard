import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/views/base_window/base_window_view.dart';
import 'package:scoreboard/widgets/base_view/side_bar.dart';

import '../helpers/test_app.dart';

Finder _field(String label) => find.widgetWithText(TextFormField, label).first;

Finder get _submit => find.widgetWithText(FilledButton, l10n.signIn);

void main() {
  testWidgets('signed out, the app opens on the sign-in screen',
      (tester) async {
    await pumpApp(tester, prefs: basePrefs(signedIn: false));
    expect(find.text(l10n.authWelcomeBack), findsOneWidget);
    expect(find.byType(BaseWindowView), findsNothing);
  });

  testWidgets('the demo account signs in to the main window', (tester) async {
    await pumpApp(tester, prefs: basePrefs(signedIn: false));

    await tester.tap(find.text(l10n.useDemo));
    await tester.pump();
    expect(find.text(demoEmail), findsOneWidget);

    await tester.tap(_submit);
    await settle(tester, frames: 20);

    expect(find.byType(BaseWindowView), findsOneWidget);
    expect(find.text(l10n.achievementsTitle), findsWidgets);
    expect(getIt<AuthInteractor>().isSignedIn, isTrue);
  });

  testWidgets('a wrong password shows an error and stays here', (tester) async {
    await pumpApp(tester, prefs: basePrefs(signedIn: false));

    await tester.enterText(_field(l10n.workEmail), demoEmail);
    await tester.enterText(_field(l10n.passwordLabel), 'wrong-password');
    await tester.tap(_submit);
    await settle(tester);

    expect(find.text(l10n.errorWrongCredentials), findsOneWidget);
    expect(find.byType(BaseWindowView), findsNothing);
  });

  testWidgets('the form checks the fields before calling the backend',
      (tester) async {
    await pumpApp(tester, prefs: basePrefs(signedIn: false));

    await tester.enterText(_field(l10n.workEmail), 'not-an-email');
    await tester.tap(_submit);
    await settle(tester);

    expect(find.text(l10n.invalidEmail), findsOneWidget);
    expect(find.text(l10n.passwordRequired), findsOneWidget);
  });

  testWidgets('switching to "Create account" shows the registration fields',
      (tester) async {
    await pumpApp(tester, prefs: basePrefs(signedIn: false));

    await tester.tap(find.text(l10n.createAccount).first);
    await settle(tester);

    expect(find.text(l10n.authCreateTitle), findsOneWidget);
    expect(_field(l10n.fieldFullName), findsOneWidget);
    expect(_field(l10n.fieldRole), findsOneWidget);
  });

  group('registration', () {
    Future<void> openRegister(WidgetTester tester) async {
      await tester.tap(find.text(l10n.createAccount).first);
      await settle(tester);
    }

    Future<void> fillPerson(WidgetTester tester, String email) async {
      await tester.enterText(_field(l10n.fieldFullName), 'Ada Lovelace');
      await tester.enterText(_field(l10n.fieldRole), 'Engineer');
      await tester.enterText(_field(l10n.workEmail), email);
      await tester.enterText(_field(l10n.passwordLabel), 'analytical');
      await tester.enterText(_field(l10n.confirmLabel), 'analytical');
    }

    Finder submit() => find.widgetWithText(FilledButton, l10n.createAccount);

    testWidgets('joins a company with the invitation code', (tester) async {
      late String code;
      await tester.runAsync(() async {
        await setUpApp(prefs: basePrefs(signedIn: false));
        code = await inviteToNorthwind('ada@northwind.dev');
      });
      await pumpApp(tester, prefs: await tester.runAsync(savedPrefs));
      await openRegister(tester);
      expect(find.text(l10n.authJoinSubtitle), findsOneWidget);
      expect(find.text(l10n.companyNameLabel), findsNothing);

      await fillPerson(tester, 'ada@northwind.dev');
      await tester.enterText(_field(l10n.inviteCodeLabel), 'WRONG-CODE');
      await tester.tap(submit());
      await settle(tester, frames: 20);
      expect(find.text(l10n.errorInvalidInviteCode), findsOneWidget);

      await tester.enterText(_field(l10n.inviteCodeLabel), code);
      await tester.tap(submit());
      await settle(tester, frames: 20);
      expect(find.byType(BaseWindowView), findsOneWidget);
      expect(getIt<AuthInteractor>().isSignedIn, isTrue);
    });

    testWidgets('creates a company and becomes its admin', (tester) async {
      await pumpApp(tester, prefs: basePrefs(signedIn: false));
      await openRegister(tester);
      await tester.tap(find.text(l10n.registerCreateCompany));
      await settle(tester);
      expect(find.text(l10n.authCreateCompanySubtitle), findsOneWidget);
      expect(find.text(l10n.inviteCodeLabel), findsNothing);

      await tester.tap(submit());
      await settle(tester);
      expect(find.text(l10n.companyNameRequired), findsOneWidget);

      await tester.enterText(_field(l10n.companyNameLabel), 'Acme');
      await fillPerson(tester, 'ada@acme.dev');
      await tester.tap(submit());
      await settle(tester, frames: 20);
      expect(find.byType(BaseWindowView), findsOneWidget);
      expect(find.byType(AdminModeSwitch), findsOneWidget);
    });
  });
}
