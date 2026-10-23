import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/send_achievement.dart';

import '../helpers/matchers.dart';
import '../helpers/test_app.dart';

void main() {
  late ScoreboardInteractor scoreboard;

  setUp(() async {
    await setUpApp();
    scoreboard = getIt<ScoreboardInteractor>();
  });

  /// Pairs the current user can still send, in a stable order.
  Future<List<SendAchievementRequest>> sendablePairs() async {
    final options = await scoreboard.getSendOptions();
    return [
      for (final colleague in options.colleagues)
        for (final template in options.templates)
          if (!options.alreadySent(template.id, colleague.id))
            SendAchievementRequest(
                templateId: template.id, colleagueId: colleague.id),
    ];
  }

  test('loads the signed-in user and their achievements', () async {
    final user = await scoreboard.getCurrentUser();
    expect(user.id, demoUserId);
    expect(user.isCompanyAdmin, isTrue);
    final achievements = await scoreboard.getAchievementsOf(user.id);
    expect(achievements, isNotEmpty);
    expect(achievements.every((a) => a.userId == user.id), isTrue);
  });

  group('send options', () {
    test('offer only colleagues of the same company', () async {
      final options = await scoreboard.getSendOptions();
      expect(options.colleagues.map((u) => u.id),
          unorderedEquals(['u_01', 'u_02', 'u_03']));
      expect(options.remainingBudget,
          inInclusiveRange(0, SendAchievementOptions.monthlyBudget));
      expect(options.templates, isNotEmpty);
    });
  });

  group('sending a base achievement', () {
    test('reaches the colleague with sender and note', () async {
      final request = (await sendablePairs()).first;
      final budgetBefore = (await scoreboard.getSendOptions()).remainingBudget;
      if (budgetBefore == 0) return markTestSkipped('seed used the budget');

      var notified = false;
      scoreboard.addListener(() => notified = true);
      await scoreboard.sendAchievement(SendAchievementRequest(
          templateId: request.templateId,
          colleagueId: request.colleagueId,
          note: '  Thanks!  '));

      final received = (await scoreboard.getAchievementsOf(request.colleagueId))
          .where((a) =>
              a.templateId == request.templateId && a.awardedById == demoUserId)
          .single;
      expect(received.verified, isFalse);
      expect(received.note, 'Thanks!');
      expect(received.awardedByName, 'Mario Rossi');
      expect(notified, isTrue);
      expect((await scoreboard.getSendOptions()).remainingBudget,
          budgetBefore - 1);
      expect((await scoreboard.getSentAchievements()).first.id, received.id);
    });

    test('is refused twice to the same colleague', () async {
      final options = await scoreboard.getSendOptions();
      if (options.remainingBudget == 0) {
        return markTestSkipped('seed used the budget');
      }
      final request = (await sendablePairs()).first;
      await scoreboard.sendAchievement(request);
      await expectLater(scoreboard.sendAchievement(request),
          throwsSendError(SendAchievementError.alreadySent));
    });

    test('is refused outside the company or for unknown templates', () async {
      final template = (await scoreboard.getSendOptions()).templates.first;
      await expectLater(
          scoreboard.sendAchievement(SendAchievementRequest(
              templateId: template.id, colleagueId: 'u_04')),
          throwsSendError(SendAchievementError.notAColleague));
      await expectLater(
          scoreboard.sendAchievement(SendAchievementRequest(
              templateId: template.id, colleagueId: demoUserId)),
          throwsSendError(SendAchievementError.notAColleague));
      await expectLater(
          scoreboard.sendAchievement(const SendAchievementRequest(
              templateId: 'missing', colleagueId: 'u_01')),
          throwsSendError(SendAchievementError.templateNotFound));
    });

    test('stops when the monthly budget is used up', () async {
      final budget = (await scoreboard.getSendOptions()).remainingBudget;
      final pairs = await sendablePairs();
      expect(pairs.length, greaterThan(budget));
      for (final request in pairs.take(budget)) {
        await scoreboard.sendAchievement(request);
      }
      expect((await scoreboard.getSendOptions()).remainingBudget, 0);
      await expectLater(scoreboard.sendAchievement(pairs[budget]),
          throwsSendError(SendAchievementError.budgetExhausted));
    });

    test('is still there after a restart', () async {
      if ((await scoreboard.getSendOptions()).remainingBudget == 0) {
        return markTestSkipped('seed used the budget');
      }
      final request = (await sendablePairs()).first;
      await scoreboard.sendAchievement(request);

      await setUpApp(prefs: await savedPrefs());
      final options = await getIt<ScoreboardInteractor>().getSendOptions();
      expect(
          options.alreadySent(request.templateId, request.colleagueId), isTrue);
    });
  });

  group('base achievement templates', () {
    test('can be created with allowed points and deleted by the author',
        () async {
      await scoreboard.createTemplate(const AchievementTemplateDraft(
          name: '  Pairing Partner ',
          description: 'Great pairing sessions',
          icon: 'teamwork_icon.png',
          points: 25));
      final created = (await scoreboard.getTemplates())
          .firstWhere((t) => t.name == 'Pairing Partner');
      expect(created.createdById, demoUserId);

      await scoreboard.deleteTemplate(created.id);
      expect((await scoreboard.getTemplates()).map((t) => t.id),
          isNot(contains(created.id)));
    });

    test('refuse points outside the allowed values', () async {
      await expectLater(
          scoreboard.createTemplate(const AchievementTemplateDraft(
              name: 'Too much', description: '', icon: '', points: 30)),
          throwsSendError(SendAchievementError.invalidPoints));
    });

    test('of someone else cannot be deleted', () async {
      final others = (await scoreboard.getTemplates())
          .where((t) => t.createdById != demoUserId);
      if (others.isEmpty) return markTestSkipped('no foreign template');
      await expectLater(scoreboard.deleteTemplate(others.first.id),
          throwsSendError(SendAchievementError.notTemplateOwner));
    });
  });

  group('profile', () {
    test('updates name, role and bio', () async {
      await scoreboard.updateProfile(const ProfileDraft(
          name: 'Mario R.',
          role: 'Staff Engineer',
          bio: 'New bio',
          bannerPreset: 'graphite_grid'));
      final user = await scoreboard.getCurrentUser();
      expect(user.name, 'Mario R.');
      expect(user.role, 'Staff Engineer');
      expect(user.bio, 'New bio');
    });

    test('requires name and role', () async {
      await expectLater(
          scoreboard.updateProfile(const ProfileDraft(
              name: ' ', role: 'Dev', bio: '', bannerPreset: 'graphite_grid')),
          throwsAuthError(AuthError.missingNameOrRole));
    });

    test('rejects an invalid email', () async {
      await expectLater(scoreboard.updateEmail('not-an-email'),
          throwsAuthError(AuthError.invalidEmail));
    });
  });

  group('privacy', () {
    test('hides the user from the global leaderboard only', () async {
      bool listed(Iterable<dynamic> entries) =>
          entries.any((e) => e.user.id == demoUserId);
      expect(listed(await scoreboard.getUserLeaderboard()), isTrue);

      await scoreboard.setHiddenFromCommunity(true);
      expect(listed(await scoreboard.getUserLeaderboard()), isFalse);
      expect(
          listed(await scoreboard.getUserLeaderboard(companyId: 'c_northwind')),
          isTrue);
    });

    test('leaderboards are ranked by points', () async {
      final users = await scoreboard.getUserLeaderboard();
      for (var i = 1; i < users.length; i++) {
        expect(users[i - 1].points, greaterThanOrEqualTo(users[i].points));
        expect(users[i].rank, i + 1);
      }
      final companies = await scoreboard.getCompanyLeaderboard();
      expect(companies, hasLength(4));
      expect(companies.first.rank, 1);
    });
  });
}
