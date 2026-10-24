import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/insights.dart';
import 'package:scoreboard/widgets/charts/monthly_achievements_chart.dart';
import 'package:scoreboard/widgets/common/stat_tile.dart';
import 'package:scoreboard/widgets/interactive_card.dart';

import '../helpers/test_app.dart';

final _verified = Achievement(
  id: 'v',
  name: 'Cloud Computing Expert',
  description: 'Designed and ran cloud infrastructure.',
  icon: 'cloud_icon.png',
  points: 140,
  verified: true,
  company: 'Northwind Labs',
  companyBrand: const CompanyBrand(symbol: 'air', color: 0xFF0EA5E9),
  date: DateTime(2026, 8, 22),
);

final _peer = Achievement(
  id: 'p',
  name: 'Great Idea',
  description: 'Had the idea that unblocked the team.',
  icon: 'idea_icon.png',
  points: 25,
  verified: false,
  awardedByName: 'Giulia Bianchi',
  date: DateTime(2026, 9, 12),
);

void main() {
  group('InteractiveCard', () {
    Future<void> flip(WidgetTester tester) async {
      await tester.tap(find.byType(InteractiveCard));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
    }

    testWidgets('a verified card shows the company on the back',
        (tester) async {
      await pumpInApp(
          tester,
          InteractiveCard(
              achievement: _verified, onPressed: () {}, flipOnTap: true));
      expect(find.text('Cloud Computing Expert'), findsOneWidget);
      expect(find.text(l10n.cardIssuedBy), findsNothing);

      await flip(tester);
      expect(find.text(l10n.cardIssuedBy), findsOneWidget);
      expect(find.text('Northwind Labs'), findsWidgets);

      await flip(tester);
      expect(find.text(l10n.cardIssuedBy), findsNothing);
    });

    testWidgets('holding a card flips it with a haptic; a click has none',
        (tester) async {
      final played = <Object?>[];
      const channel = MethodChannel('scoreboard/haptics');
      final messenger = tester.binding.defaultBinaryMessenger;
      messenger.setMockMethodCallHandler(channel, (call) async {
        played.add(call.arguments);
        return null;
      });
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      var opened = 0;
      await pumpInApp(tester,
          InteractiveCard(achievement: _verified, onPressed: () => opened++));

      // A click opens the card: the trackpad's own click is the feedback.
      await tester.tap(find.byType(InteractiveCard));
      await tester.pump();
      expect(opened, 1);
      expect(played, isEmpty);

      // Holding flips it, with the haptic played while still pressed.
      final gesture = await tester
          .startGesture(tester.getCenter(find.byType(InteractiveCard)));
      await tester.pump(kLongPressTimeout + const Duration(milliseconds: 50));
      expect(played, ['alignment']);
      await gesture.up();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.text(l10n.cardIssuedBy), findsOneWidget);
      expect(opened, 1);

      debugDefaultTargetPlatformOverride = null;
      messenger.setMockMethodCallHandler(channel, null);
    });

    testWidgets('a base card shows who sent it on the back', (tester) async {
      await pumpInApp(
          tester,
          InteractiveCard(
              achievement: _peer, onPressed: () {}, flipOnTap: true));
      await flip(tester);
      expect(find.text(l10n.cardSentBy), findsOneWidget);
      expect(find.textContaining('Giulia Bianchi'), findsWidgets);
    });

    testWidgets('a card without a back opens instead of flipping',
        (tester) async {
      var opened = 0;
      final preview =
          Achievement(id: 't', name: 'Template', points: 10, verified: false);
      expect(InteractiveCard.canFlip(preview), isFalse);
      await pumpInApp(
          tester,
          InteractiveCard(
              achievement: preview,
              onPressed: () => opened++,
              flipOnTap: true));
      await tester.tap(find.byType(InteractiveCard));
      await tester.pump();
      expect(opened, 1);
    });

    testWidgets('in a grid, tapping opens and the hover button flips',
        (tester) async {
      var opened = 0;
      await pumpInApp(tester,
          InteractiveCard(achievement: _verified, onPressed: () => opened++));
      await tester.tap(find.byType(InteractiveCard));
      await tester.pump();
      expect(opened, 1);
      expect(find.byTooltip(l10n.cardFlip), findsOneWidget);
    });
  });

  group('MonthlyAchievementsChart', () {
    final months = [
      for (var i = 0; i < 6; i++)
        MonthlyCount(month: DateTime(2026, 4 + i), verified: i, peer: i * 2),
    ];

    testWidgets('labels each month with its total', (tester) async {
      await pumpInApp(
          tester,
          SizedBox(
              width: 600, child: MonthlyAchievementsChart(months: months)));
      expect(tester.takeException(), isNull);
      for (final month in months.where((m) => m.total > 0)) {
        expect(find.text('${month.total}'), findsWidgets);
      }
      expect(find.text('Apr'), findsOneWidget);
      expect(find.text('Sep'), findsOneWidget);
    });

    testWidgets('copes with months without data', (tester) async {
      await pumpInApp(
          tester,
          SizedBox(
              width: 600,
              child: MonthlyAchievementsChart(months: [
                for (final m in months)
                  MonthlyCount(month: m.month, verified: 0, peer: 0)
              ])));
      expect(tester.takeException(), isNull);
      expect(find.text('Apr'), findsOneWidget);
    });
  });

  testWidgets('StatRow keeps tiles the same height', (tester) async {
    await pumpInApp(
        tester,
        const SizedBox(
          width: 600,
          child: StatRow(tiles: [
            StatTile(label: 'Short', value: '1', icon: Icons.star),
            StatTile(
                label: 'A much longer label that wraps on two lines here',
                value: '2',
                icon: Icons.star),
          ]),
        ));
    final sizes = tester
        .widgetList(find.byType(StatTile))
        .map((w) => tester.getSize(find.byWidget(w)).height)
        .toSet();
    expect(sizes, hasLength(1));
  });
}
