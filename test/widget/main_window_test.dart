import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/app_navigation.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/app/app.dart';
import 'package:scoreboard/interactors/interactors.dart';
import 'package:scoreboard/views/view_contracts.dart';
import 'package:scoreboard/views/view_models.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';
import 'package:scoreboard/services/shared_preferences.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/views/views.dart';
import 'package:scoreboard/widgets/base_view/side_bar.dart';
import 'package:scoreboard/widgets/common/nav_button.dart';
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

  testWidgets('admin mode swaps the sidebar for the console sections',
      (tester) async {
    await pumpApp(tester);
    // The console isn't a regular page: admins reach it with admin mode.
    expect(_sidebarItem(l10n.navConsole), findsNothing);
    expect(find.byType(AdminBanner), findsNothing);

    await tester.tap(find.byType(AdminModeSwitch));
    await settle(tester);
    expect(find.byType(AdminBanner), findsOneWidget);
    expect(find.text(l10n.adminBadge('Northwind Labs')), findsOneWidget);
    for (final section in [
      l10n.consoleCatalog,
      l10n.consoleAssign,
      l10n.navRequests,
      l10n.consoleStats,
    ]) {
      expect(_sidebarItem(section), findsOneWidget, reason: section);
    }
    expect(_sidebarItem(l10n.navFeed), findsNothing);
    // The whole window takes the admin accent.
    final sidebarTheme = Theme.of(tester.element(find.byType(Sidebar)));
    expect(sidebarTheme.colorScheme.primary,
        anyOf(AppColors.adminLight, AppColors.adminDark));

    await _open(tester, l10n.navRequests);
    expect(find.text(l10n.consoleRequestsSubtitle), findsOneWidget);
    expect(find.text(l10n.pendingSection), findsOneWidget);

    await tester.tap(find.byType(AdminModeSwitch));
    await settle(tester);
    expect(find.byType(AdminBanner), findsNothing);
    expect(_sidebarItem(l10n.navFeed), findsOneWidget);
  });

  testWidgets('admin mode keeps every page alive', (tester) async {
    await pumpApp(tester);
    State<StatefulWidget> feed() =>
        tester.state(find.byType(FeedView, skipOffstage: false));
    final before = feed();

    // Back and forth quickly, while pages are still loading.
    await tester.tap(find.byType(AdminModeSwitch));
    await tester.pump(const Duration(milliseconds: 1));
    await tester.tap(find.byType(AdminModeSwitch));
    await tester.pump(const Duration(milliseconds: 1));
    await tester.tap(find.byType(AdminModeSwitch));
    await settle(tester);
    await tester.tap(find.byType(AdminModeSwitch));
    await settle(tester);

    expect(tester.takeException(), isNull);
    expect(identical(feed(), before), isTrue,
        reason: 'the feed page was rebuilt from scratch');
  });

  testWidgets('pending requests are counted on the sidebar', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byType(AdminModeSwitch));
    await settle(tester);
    final requests = find.ancestor(
        of: _sidebarItem(l10n.navRequests), matching: find.byType(NavButton));
    // The seed has two pending requests at Northwind.
    expect(tester.widget<NavButton>(requests).badge, 2);
  });

  testWidgets('members do not see the console', (tester) async {
    await pumpApp(tester, prefs: {
      ...basePrefs(),
      'session_user_id': 'u_02',
      'onboarding_done_u_02': true,
    });
    expect(_sidebarItem(l10n.navYourCompany), findsOneWidget);
    expect(find.byType(AdminModeSwitch), findsNothing);
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
      final code = await inviteToNorthwind('ada@northwind.dev');
      userId = (await getIt<AuthInteractor>().register(RegistrationDraft.join(
              name: 'Ada Lovelace',
              role: 'Engineer',
              email: 'ada@northwind.dev',
              password: 'analytical',
              inviteCode: code)))
          .id;
    });
    await pumpApp(tester,
        prefs: {...await savedPrefs(), 'onboarding_done_$userId': true});

    expect(find.text(l10n.achievementsEmptyTitle), findsOneWidget);
    expect(find.byType(AdminModeSwitch), findsNothing);

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

  group('with the backend', () {
    /// The app as with a backend: the main window checks for news every
    /// second.
    Future<void> pumpRefreshingApp(WidgetTester tester) async {
      await tester.runAsync(() => setUpApp());
      getIt.unregister<BaseWindowViewModelContract>();
      getIt.registerFactory<BaseWindowViewModelContract>(() =>
          BaseWindowViewModel(
              getIt<ScoreboardInteractor>(),
              getIt<NotificationInteractor>(),
              getIt<AppNavigation>(),
              getIt<AppConfigurationInteractor>(),
              getIt<UpdateInteractor>(),
              getIt<AdminInteractor>(),
              getIt<TeamInteractor>(),
              refreshInterval: const Duration(seconds: 1)));
      tester.view.physicalSize = const Size(1400, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const CompanyAchievements());
      await settle(tester);
    }

    testWidgets('shows what colleagues send without any action',
        (tester) async {
      await pumpRefreshingApp(tester);
      final shownBefore = systemNotifications.shown.length;

      // A colleague sends an achievement, as another app would.
      await tester.runAsync(() => getIt<ScoreboardRepository>().addAchievement(
          Achievement(
              id: 'ach_from_luca',
              userId: demoUserId,
              name: 'Coffee Hero',
              points: 10,
              verified: false,
              awardedById: 'u_02',
              awardedByName: 'Luca Ferrari',
              date: DateTime.now())));
      await tester.pump(const Duration(seconds: 1));
      await settle(tester);

      expect(systemNotifications.shown.length, shownBefore + 1);
      expect(systemNotifications.shown.last.body, contains('Coffee Hero'));
    });

    testWidgets('goes back to sign in when the session ends', (tester) async {
      await pumpRefreshingApp(tester);
      await tester
          .runAsync(() => getIt<SharedPreference>().setSessionUserId(null));
      await tester.pump(const Duration(seconds: 1));
      await settle(tester);

      expect(find.text(l10n.authSignInSubtitle), findsOneWidget);
    });
  });
}
