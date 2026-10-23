import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/views/auth/auth_view.dart';
import 'package:scoreboard/widgets/base_view/side_bar.dart';
import 'package:scoreboard/widgets/common/nav_button.dart';

import '../helpers/test_app.dart';

/// Opens Settings and, when given, one of its sections.
Future<void> _openSettings(WidgetTester tester, [String? section]) async {
  await tester.tap(find.descendant(
      of: find.byType(Sidebar), matching: find.text(l10n.navSettings)));
  await settle(tester);
  if (section != null) {
    await tester.tap(find.widgetWithText(NavButton, section));
    await settle(tester);
  }
}

Future<void> _scrollTo(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(finder, 200,
      scrollable: find.byType(Scrollable).hitTestable().first);
  await settle(tester, frames: 3);
}

void main() {
  testWidgets('switching language translates the app and is remembered',
      (tester) async {
    await pumpApp(tester);
    await _openSettings(tester);
    final englishNav = l10n.navAchievements;

    await tester.tap(find.text('Italiano'));
    await settle(tester);
    final italianNav = l10n.navAchievements;
    expect(italianNav, isNot(englishNav));
    expect(find.text(italianNav), findsWidgets);
    expect(find.text(englishNav), findsNothing);
    expect((await savedPrefs())['language_code'], 'it');

    await tester.tap(find.text('English'));
    await settle(tester);
    expect(find.text(englishNav), findsWidgets);
  });

  testWidgets('the privacy switch hides me from the Community leaderboard',
      (tester) async {
    await pumpApp(tester);
    await _openSettings(tester, l10n.settingsAccount);
    final toggle =
        find.widgetWithText(SwitchListTile, l10n.privacyCommunityTitle);
    await _scrollTo(tester, toggle);
    expect(tester.widget<SwitchListTile>(toggle).value, isTrue);

    await tester.tap(toggle);
    await settle(tester);
    expect(tester.widget<SwitchListTile>(toggle).value, isFalse);

    late List<String> listed;
    await tester.runAsync(() async {
      listed = [
        for (final e
            in await getIt<ScoreboardInteractor>().getUserLeaderboard())
          e.user.id
      ];
    });
    expect(listed, isNot(contains(demoUserId)));
  });

  testWidgets('signing out goes back to the sign-in screen', (tester) async {
    await pumpApp(tester);
    await _openSettings(tester, l10n.settingsAccount);
    final signOut = find.widgetWithText(OutlinedButton, l10n.signOut);
    await _scrollTo(tester, signOut);

    await tester.tap(signOut);
    await settle(tester);
    // A confirmation may come first.
    final confirm = find.widgetWithText(FilledButton, l10n.signOut);
    if (confirm.evaluate().isNotEmpty) {
      await tester.tap(confirm);
      await settle(tester);
    }
    expect(find.byType(AuthView), findsOneWidget);
    expect(getIt<AuthInteractor>().isSignedIn, isFalse);
  });

  testWidgets('the update check reports when the app is up to date',
      (tester) async {
    await pumpApp(tester);
    await _openSettings(tester, l10n.settingsAbout);
    final check = find.text(l10n.checkForUpdates);
    await _scrollTo(tester, check);

    await tester.tap(check);
    await settle(tester);
    expect(updateService.calls, greaterThanOrEqualTo(1));
    expect(find.text(l10n.upToDate), findsOneWidget);
  });
}
