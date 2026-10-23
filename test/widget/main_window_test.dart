import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/widgets/base_view/side_bar.dart';
import 'package:scoreboard/widgets/common/page_header.dart';
import 'package:scoreboard/widgets/interactive_card.dart';
import 'package:scoreboard/widgets/notifications_panel.dart';

import '../helpers/test_app.dart';

Finder _sidebarItem(String label) =>
    find.descendant(of: find.byType(Sidebar), matching: find.text(label));

Future<void> _open(WidgetTester tester, String label) async {
  await tester.tap(_sidebarItem(label));
  await settle(tester);
}

/// Presses Ctrl + [key]; tests run as Android, so the primary key is Ctrl.
Future<void> _shortcut(WidgetTester tester, LogicalKeyboardKey key) async {
  await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
  await tester.sendKeyEvent(key);
  await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
  await settle(tester);
}

void main() {
  testWidgets('the sidebar opens every page', (tester) async {
    await pumpApp(tester);
    expect(find.text(l10n.achievementsTitle), findsWidgets);

    final pages = {
      l10n.navBaseAchievements: l10n.baseSubtitle,
      l10n.navFeed: l10n.feedSubtitle,
      l10n.navCommunity: l10n.communitySubtitle,
      l10n.navSettings: l10n.appearanceSubtitle,
    };
    for (final MapEntry(key: label, value: subtitle) in pages.entries) {
      await _open(tester, label);
      expect(find.text(subtitle), findsOneWidget, reason: label);
    }
  });

  testWidgets('the console is for company admins only', (tester) async {
    await pumpApp(tester);
    expect(_sidebarItem(l10n.navConsole), findsOneWidget);
    await _open(tester, l10n.navConsole);
    expect(find.text(l10n.consoleSubtitle('Northwind Labs')), findsOneWidget);
  });

  testWidgets('members do not see the console', (tester) async {
    await pumpApp(tester, prefs: {
      ...basePrefs(),
      'session_user_id': 'u_02',
      'onboarding_done_u_02': true,
    });
    expect(_sidebarItem(l10n.navYourCompany), findsOneWidget);
    expect(_sidebarItem(l10n.navConsole), findsNothing);
  });

  testWidgets('search narrows the cards and explains an empty result',
      (tester) async {
    await pumpApp(tester);
    final cards = find.byType(InteractiveCard);
    final all = cards.evaluate().length;
    expect(all, greaterThan(1));

    await tester.enterText(
        find.widgetWithText(TextField, l10n.searchAchievementsHint), 'cloud');
    await settle(tester);
    expect(cards.evaluate().length, inInclusiveRange(1, all - 1));
    expect(find.text('Cloud Computing Expert'), findsWidgets);

    await tester.enterText(
        find.widgetWithText(TextField, 'cloud'), 'no such achievement');
    await settle(tester);
    expect(cards, findsNothing);
    expect(find.text(l10n.noSearchResults), findsOneWidget);
  });

  testWidgets('keyboard shortcuts switch pages and open dialogs',
      (tester) async {
    await pumpApp(tester);

    await _shortcut(tester, LogicalKeyboardKey.digit3);
    expect(find.text(l10n.feedSubtitle), findsOneWidget);

    await _shortcut(tester, LogicalKeyboardKey.comma);
    expect(find.text(l10n.appearanceSubtitle), findsOneWidget);

    await _shortcut(tester, LogicalKeyboardKey.keyK);
    expect(find.text(l10n.sendAnAchievement), findsOneWidget);

    // While a dialog is open the shortcuts are off.
    await _shortcut(tester, LogicalKeyboardKey.digit1);
    expect(find.text(l10n.sendAnAchievement), findsOneWidget);
    await tester.tap(find.text(l10n.commonCancel));
    await settle(tester);
    expect(find.text(l10n.sendAnAchievement), findsNothing);
  });

  testWidgets('the bell lists notifications and marks them read',
      (tester) async {
    await pumpApp(tester);
    final badge = find.descendant(
        of: find.byTooltip(l10n.notificationsOpen),
        matching: find.byType(Badge));
    expect(tester.widget<Badge>(badge).isLabelVisible, isTrue);
    // Pending notifications were handed to the system once.
    expect(systemNotifications.shown, isNotEmpty);

    await tester.tap(find.byTooltip(l10n.notificationsOpen));
    await settle(tester);
    expect(find.byType(NotificationsPanel), findsOneWidget);
    expect(find.text(l10n.notificationsTitle), findsOneWidget);

    await tester.tap(find.text(l10n.markAllRead));
    await settle(tester);
    expect(tester.widget<Badge>(badge).isLabelVisible, isFalse);
  });

  testWidgets('a new account gets an empty state that leads to the catalog',
      (tester) async {
    late String userId;
    await tester.runAsync(() async {
      await setUpApp(prefs: basePrefs(signedIn: false));
      userId = (await getIt<AuthInteractor>().register(const RegistrationDraft(
              name: 'Ada Lovelace',
              role: 'Engineer',
              companyId: 'c_northwind',
              email: 'ada@northwind.dev',
              password: 'analytical')))
          .id;
    });
    await pumpApp(tester,
        prefs: {...await savedPrefs(), 'onboarding_done_$userId': true});

    expect(find.text(l10n.achievementsEmptyTitle), findsOneWidget);
    expect(_sidebarItem(l10n.navConsole), findsNothing);

    await tester.tap(find.text(l10n.emptyOpenCatalog));
    await settle(tester);
    expect(find.text(l10n.achievementsEmptyTitle), findsNothing);
    expect(find.widgetWithText(PageHeader, 'Northwind Labs'), findsOneWidget);
  });

  testWidgets('new users see the introduction once', (tester) async {
    await pumpApp(tester,
        prefs: {...basePrefs(), 'onboarding_done_$demoUserId': false});
    expect(find.text(l10n.onboardingWelcomeBody), findsOneWidget);
  });
}
