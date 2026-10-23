import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/views/base_window/base_window_view.dart';

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
}
