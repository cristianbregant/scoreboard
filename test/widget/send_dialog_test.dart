import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/model/achievement_template.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/widgets/dialogs/send_achievement_dialog.dart';

import '../helpers/test_app.dart';

UserProfile _user(String id, String name) => UserProfile(
    id: id,
    name: name,
    role: 'Developer',
    email: '$id@northwind.dev',
    companyId: 'c_northwind',
    joinedAt: DateTime(2022));

AchievementTemplate _template(String id, String name) => AchievementTemplate(
    id: id,
    name: name,
    description: '$name description',
    icon: 'idea_icon.png',
    points: 25,
    createdById: 'u_me',
    createdByName: 'Mario Rossi',
    createdAt: DateTime(2026));

SendAchievementOptions _options({int budget = 3}) => SendAchievementOptions(
      currentUser: _user('u_me', 'Mario Rossi'),
      colleagues: [
        _user('u_01', 'Giulia Bianchi'),
        _user('u_02', 'Luca Ferrari')
      ],
      templates: [
        _template('t_idea', 'Great Idea'),
        _template('t_help', 'Helping Hand')
      ],
      // Giulia already got "Great Idea".
      sentPairs: {('t_idea', 'u_01')},
      remainingBudget: budget,
    );

/// Opens the dialog and returns a getter for what it was closed with.
Future<SendAchievementRequest? Function()> _open(
    WidgetTester tester, SendAchievementOptions options) async {
  SendAchievementRequest? result;
  await pumpInApp(
      tester,
      Builder(
          builder: (context) => TextButton(
              onPressed: () async =>
                  result = await showSendAchievementDialog(context, options),
              child: const Text('open'))));
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return () => result;
}

Finder get _sendButton => find.widgetWithText(FilledButton, l10n.commonSend);

bool _enabled(WidgetTester tester) =>
    tester.widget<FilledButton>(_sendButton).onPressed != null;

void main() {
  testWidgets('sending needs a colleague and an achievement', (tester) async {
    final result = await _open(tester, _options());
    expect(
        find.text(
            l10n.budgetRemaining(3, SendAchievementOptions.monthlyBudget)),
        findsOneWidget);
    expect(_enabled(tester), isFalse);

    await tester.tap(find.text('Luca Ferrari'));
    await tester.pump();
    expect(_enabled(tester), isFalse);

    await tester.tap(find.text('Great Idea'));
    await tester.pump();
    expect(_enabled(tester), isTrue);

    await tester.enterText(find.byType(TextField), 'Thanks!');
    await tester.tap(_sendButton);
    await tester.pumpAndSettle();

    final request = result()!;
    expect(request.colleagueId, 'u_02');
    expect(request.templateId, 't_idea');
    expect(request.note, 'Thanks!');
  });

  testWidgets('an achievement already sent to that colleague is disabled',
      (tester) async {
    await _open(tester, _options());

    await tester.tap(find.text('Great Idea'));
    await tester.pump();
    // Choosing Giulia drops the choice: she already has it.
    await tester.tap(find.text('Giulia Bianchi'));
    await tester.pump();
    expect(find.text(l10n.alreadySentToColleague), findsOneWidget);
    expect(_enabled(tester), isFalse);

    await tester.tap(find.text('Great Idea'));
    await tester.pump();
    expect(_enabled(tester), isFalse);

    await tester.tap(find.text('Helping Hand'));
    await tester.pump();
    expect(_enabled(tester), isTrue);
  });

  testWidgets('nothing can be sent once the budget is used up', (tester) async {
    await _open(tester, _options(budget: 0));
    expect(
        find.text(
            l10n.budgetRemaining(0, SendAchievementOptions.monthlyBudget)),
        findsOneWidget);

    await tester.tap(find.text('Luca Ferrari'));
    await tester.tap(find.text('Helping Hand'));
    await tester.pump();
    expect(_enabled(tester), isFalse);
  });

  testWidgets('cancel closes without sending', (tester) async {
    final result = await _open(tester, _options());
    await tester.tap(find.text(l10n.commonCancel));
    await tester.pumpAndSettle();
    expect(find.text(l10n.sendAnAchievement), findsNothing);
    expect(result(), isNull);
  });
}
