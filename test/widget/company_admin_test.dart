import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/interactors/interactors.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/widgets/base_view/side_bar.dart';

import '../helpers/test_app.dart';

Finder _sidebarItem(String label) =>
    find.descendant(of: find.byType(Sidebar), matching: find.text(label));

Future<void> _open(WidgetTester tester, String label) async {
  await tester.tap(_sidebarItem(label));
  await settle(tester);
}

Future<void> _adminMode(WidgetTester tester) async {
  await tester.tap(find.byType(AdminModeSwitch));
  await settle(tester);
}

void main() {
  group('team page', () {
    testWidgets('managers see their team and who needs attention',
        (tester) async {
      await pumpApp(tester);
      expect(_sidebarItem(l10n.navTeam), findsOneWidget);
      await _open(tester, l10n.navTeam);
      expect(find.text('Platform & QA'), findsOneWidget);
      expect(find.text('Sara Romano'), findsOneWidget);
      expect(find.text(l10n.teamNominate), findsOneWidget);
    });

    testWidgets('a proposal goes through the dialog to the admins',
        (tester) async {
      await pumpApp(tester);
      await _open(tester, l10n.navTeam);
      await tester.tap(find.text(l10n.teamNominate));
      await settle(tester);
      expect(find.text(l10n.nominateDialogSubtitle('Sara Romano')),
          findsOneWidget);

      final send = find.widgetWithText(FilledButton, l10n.commonSend);
      expect(tester.widget<FilledButton>(send).onPressed, isNull);
      await tester.tap(find
          .descendant(of: find.byType(Dialog), matching: find.byType(InkWell))
          .first);
      await tester.enterText(find.byType(TextField), 'Shipped the release');
      await tester.pump();
      await tester.tap(send);
      await settle(tester);
      expect(find.text(l10n.nominateSent), findsOneWidget);

      late List<ActivityEntry> log;
      await tester.runAsync(
          () async => log = await getIt<ActivityInteractor>().getActivity());
      expect(log.first.type, ActivityType.nominationSubmitted);
      expect(log.first.target, 'Sara Romano');
    });

    testWidgets('people who lead no team have no team page', (tester) async {
      await pumpApp(tester, prefs: {
        ...basePrefs(),
        'session_user_id': 'u_02',
        'onboarding_done_u_02': true,
      });
      expect(_sidebarItem(l10n.navTeam), findsNothing);
    });
  });

  group('admin console', () {
    testWidgets('sections are grouped and each one opens', (tester) async {
      await pumpApp(tester);
      await _adminMode(tester);
      for (final header in [
        l10n.adminGroupRecognition,
        l10n.adminGroupPeople,
        l10n.adminGroupData,
        l10n.adminGroupCompany,
      ]) {
        expect(find.text(header), findsOneWidget, reason: header);
      }
      final sections = {
        l10n.consoleTeams: l10n.teamsHint,
        l10n.consoleSeasons: l10n.seasonsHint,
        l10n.consoleReports: l10n.reportsHint,
        l10n.consoleActivity: l10n.activityHint,
        l10n.consoleCompany: l10n.brandTitle,
      };
      for (final MapEntry(key: section, value: text) in sections.entries) {
        await _open(tester, section);
        expect(find.text(text), findsOneWidget, reason: section);
      }
    });

    testWidgets('teams are created from the dialog', (tester) async {
      await pumpApp(tester);
      await _adminMode(tester);
      await _open(tester, l10n.consoleTeams);
      expect(find.text('App & Web'), findsWidgets);

      await tester.tap(find.text(l10n.newTeam));
      await settle(tester);
      await tester.enterText(
          find.widgetWithText(TextField, l10n.teamName), 'Design');
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, l10n.commonSave));
      await settle(tester);
      expect(find.text(l10n.teamSaved), findsOneWidget);
      expect(find.text('Design'), findsWidgets);
    });

    testWidgets('seasons show their status', (tester) async {
      await pumpApp(tester);
      await _adminMode(tester);
      await _open(tester, l10n.consoleSeasons);
      expect(find.text('Season 3'), findsOneWidget);
      expect(find.text(l10n.seasonActive), findsOneWidget);
      expect(find.text(l10n.seasonEnded), findsOneWidget);
    });

    testWidgets('the activity log lists what admins did', (tester) async {
      await pumpApp(tester);
      await _adminMode(tester);
      await _open(tester, l10n.consoleActivity);
      expect(
          find.textContaining(l10n.activitySeasonCreated('Season 3'),
              findRichText: true),
          findsOneWidget);
    });

    testWidgets('a brand color recolors the app outside admin mode',
        (tester) async {
      await pumpApp(tester);
      Color primary() =>
          Theme.of(tester.element(find.byType(Sidebar))).colorScheme.primary;
      final gold = primary();

      await _adminMode(tester);
      await _open(tester, l10n.consoleCompany);
      await tester.tap(find.byTooltip('#16A34A'));
      await settle(tester);
      expect(find.text(l10n.settingsSavedMessage), findsOneWidget);

      await _adminMode(tester);
      final branded = primary();
      expect(branded, isNot(gold));
      final themes = AppTheme.branded(const Color(0xFF16A34A));
      expect(branded,
          anyOf(themes.$1.colorScheme.primary, themes.$2.colorScheme.primary));
      expect(branded, isNot(anyOf(AppColors.adminLight, AppColors.adminDark)));
    });
  });

  testWidgets('Your company shows the season in progress', (tester) async {
    await pumpApp(tester);
    await tester.tap(_sidebarItem(l10n.navYourCompany));
    await settle(tester);
    expect(find.text(l10n.seasonCurrent.toUpperCase()), findsOneWidget);
    expect(find.text('Season 3'), findsOneWidget);
  });
}
