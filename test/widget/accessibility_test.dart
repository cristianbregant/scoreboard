import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/views/achievement/achievement_view.dart';
import 'package:scoreboard/widgets/base_view/side_bar.dart';
import 'package:scoreboard/widgets/common/nav_button.dart';
import 'package:scoreboard/widgets/interactive_card.dart';

import '../helpers/test_app.dart';

/// WCAG 2.2 target size (minimum) for pointer input: 24×24. The 48×48
/// Android guideline is meant for touch screens.
const _desktopTapTarget = MinimumTapTargetGuideline(
    size: Size(24, 24),
    link: 'https://www.w3.org/WAI/WCAG22/Understanding/target-size-minimum');

Future<void> _expectGuidelines(WidgetTester tester, String screen) async {
  for (final guideline in [
    labeledTapTargetGuideline,
    _desktopTapTarget,
    textContrastGuideline,
  ]) {
    final evaluation = await guideline.evaluate(tester);
    expect(evaluation.passed, isTrue,
        reason: '$screen, ${guideline.description}:\n${evaluation.reason}');
  }
}

Future<void> _openPage(WidgetTester tester, String label) async {
  await tester.tap(
      find.descendant(of: find.byType(Sidebar), matching: find.text(label)));
  await settle(tester);
}

/// Presses Tab until the focused widget sits inside [target].
Future<void> _tabTo(WidgetTester tester, Finder target) async {
  final targets = target.evaluate().toSet();
  for (var i = 0; i < 80; i++) {
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    final focused = FocusManager.instance.primaryFocus?.context;
    var inside = false;
    focused?.visitAncestorElements((element) {
      inside = targets.contains(element);
      return !inside;
    });
    if (inside) return;
  }
  fail('Tab never reached $target');
}

final _verified = Achievement(
  id: 'v',
  name: 'Cloud Computing Expert',
  icon: 'cloud_icon.png',
  points: 140,
  verified: true,
  company: 'Northwind Labs',
  date: DateTime(2026, 8, 22),
);

void main() {
  for (final dark in [false, true]) {
    final theme = dark ? 'dark' : 'light';

    testWidgets('every page meets the guidelines in the $theme theme',
        (tester) async {
      final semantics = tester.ensureSemantics();
      await pumpApp(tester, prefs: {...basePrefs(), 'dark_theme': dark});
      await _expectGuidelines(tester, 'Achievements');

      await tester.tap(find.byType(InteractiveCard).at(1));
      await settle(tester);
      expect(find.byType(AchievementView), findsOneWidget);
      await _expectGuidelines(tester, 'Achievement detail');
      await tester.tap(find.byTooltip(l10n.commonBack).hitTestable().first);
      await settle(tester);

      await tester.tap(find.byTooltip(l10n.notificationsOpen));
      await settle(tester);
      await _expectGuidelines(tester, 'Notifications');
      await tester.tapAt(const Offset(1300, 850));
      await settle(tester);

      for (final page in [
        l10n.navBaseAchievements,
        l10n.navFeed,
        l10n.navYourCompany,
        l10n.navTeam,
        l10n.navCommunity,
        l10n.navProfile,
        l10n.navSettings,
      ]) {
        await _openPage(tester, page);
        await _expectGuidelines(tester, page);
      }

      // Admin mode, in its own accent.
      await tester.tap(find.byType(AdminModeSwitch));
      await settle(tester);
      for (final section in [
        l10n.consoleCatalog,
        l10n.consoleAssign,
        l10n.navRequests,
        l10n.consoleMembers,
        l10n.consoleTeams,
        l10n.consoleSeasons,
        l10n.consoleStats,
        l10n.consoleReports,
        l10n.consoleActivity,
        l10n.consoleCompany,
      ]) {
        await _openPage(tester, section);
        await _expectGuidelines(tester, 'Admin: $section');
      }
      semantics.dispose();
    });
  }

  testWidgets('the sign-in screen meets the guidelines', (tester) async {
    final semantics = tester.ensureSemantics();
    await pumpApp(tester, prefs: basePrefs(signedIn: false));
    await _expectGuidelines(tester, 'Sign in');

    await tester.tap(find.text(l10n.createAccount).first);
    await settle(tester);
    await _expectGuidelines(tester, 'Join a company');
    await tester.tap(find.text(l10n.registerCreateCompany));
    await settle(tester);
    await _expectGuidelines(tester, 'Create a company');
    semantics.dispose();
  });

  group('keyboard', () {
    testWidgets('sidebar pages are reached with Tab and opened with Enter',
        (tester) async {
      await pumpApp(tester);
      await _tabTo(tester, find.widgetWithText(NavButton, l10n.navFeed));
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await settle(tester);
      expect(find.text(l10n.feedSubtitle), findsOneWidget);
    });

    testWidgets('achievement cards are reached with Tab and opened with Enter',
        (tester) async {
      await pumpApp(tester);
      await _tabTo(tester, find.byType(InteractiveCard).first);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await settle(tester);
      expect(find.byType(AchievementView), findsOneWidget);
    });

    testWidgets('F flips the focused card', (tester) async {
      await pumpInApp(
          tester, InteractiveCard(achievement: _verified, onPressed: () {}));
      await _tabTo(tester, find.byType(InteractiveCard));
      await tester.sendKeyEvent(LogicalKeyboardKey.keyF);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.text(l10n.cardIssuedBy), findsOneWidget);
    });
  });

  group('screen readers', () {
    testWidgets(
        'a card is one button, read in a sensible order, '
        'with flipping as an action', (tester) async {
      final semantics = tester.ensureSemantics();
      await pumpInApp(
          tester, InteractiveCard(achievement: _verified, onPressed: () {}));
      final node = tester.getSemantics(find.byType(InteractiveCard));
      final data = node.getSemanticsData();
      expect(data.flagsCollection.isButton, isTrue);
      expect(
          data.label, startsWith('Cloud Computing Expert. Platinum, 140 XP'));
      expect(data.label, contains('Northwind Labs'));
      expect(data.customSemanticsActionIds, isNotEmpty);
      semantics.dispose();
    });

    testWidgets('the bell says how many notifications are unread',
        (tester) async {
      final semantics = tester.ensureSemantics();
      await pumpApp(tester);
      final bell = tester
          .getSemantics(find.byTooltip(l10n.notificationsOpen))
          .getSemanticsData();
      expect(bell.label, matches(RegExp(r'^\d+ unread notifications?$')));
      semantics.dispose();
    });

    testWidgets('the current page is announced as selected', (tester) async {
      final semantics = tester.ensureSemantics();
      await pumpApp(tester);
      // The label's own text leads to the node of the whole entry.
      SemanticsData item(String label) => tester
          .getSemantics(find.descendant(
              of: find.byType(Sidebar), matching: find.text(label)))
          .getSemanticsData();
      expect(item(l10n.navAchievements).flagsCollection.isSelected,
          Tristate.isTrue);
      expect(item(l10n.navFeed).flagsCollection.isSelected,
          isNot(Tristate.isTrue));
      expect(item(l10n.navFeed).flagsCollection.isButton, isTrue);
      semantics.dispose();
    });
  });

  testWidgets('with reduced motion the card flips without animating',
      (tester) async {
    await pumpInApp(
        tester,
        MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: InteractiveCard(
              achievement: _verified, onPressed: () {}, flipOnTap: true),
        ));
    await tester.tap(find.byType(InteractiveCard));
    await tester.pump();
    expect(find.text(l10n.cardIssuedBy), findsOneWidget);
  });
}
