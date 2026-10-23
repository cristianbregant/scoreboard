import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/feed_interactor.dart';
import 'package:scoreboard/interactors/notification_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:scoreboard/model/feed.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

import '../helpers/test_app.dart';

void main() {
  setUp(setUpApp);

  group('feed', () {
    late FeedInteractor feed;

    setUp(() => feed = getIt<FeedInteractor>());

    test('shows achievements of colleagues only, newest first', () async {
      final posts = await feed.getFeed();
      expect(posts, isNotEmpty);
      expect(
          posts.every((p) => p.recipient.companyId == 'c_northwind'), isTrue);
      for (var i = 1; i < posts.length; i++) {
        expect(
            posts[i - 1].achievement.date!.isBefore(posts[i].achievement.date!),
            isFalse);
      }
    });

    test('a reaction is set, changed and removed', () async {
      Future<FeedPost> reload(String id) async =>
          (await feed.getFeed()).firstWhere((p) => p.achievement.id == id);

      final start = (await feed.getFeed()).firstWhere(
          (p) => p.myReaction == null && p.recipient.id != demoUserId);
      final id = start.achievement.id!;
      final likes = start.reactionCounts[ReactionType.like] ?? 0;

      await feed.toggleReaction(start, ReactionType.like);
      var current = await reload(id);
      expect(current.myReaction, ReactionType.like);
      expect(current.reactionCounts[ReactionType.like], likes + 1);

      await feed.toggleReaction(current, ReactionType.celebrate);
      current = await reload(id);
      expect(current.myReaction, ReactionType.celebrate);
      expect(current.reactionCounts[ReactionType.like] ?? 0, likes);

      await feed.toggleReaction(current, ReactionType.celebrate);
      expect((await reload(id)).myReaction, isNull);
    });

    test('comments are trimmed, capped and never empty', () async {
      final post = (await feed.getFeed()).first;
      final id = post.achievement.id!;

      expect(await feed.comment(id, '   '), isFalse);
      expect(await feed.comment(id, '  Congrats!  '), isTrue);
      expect(await feed.comment(id, 'x' * 600), isTrue);

      final comments = (await feed.getFeed())
          .firstWhere((p) => p.achievement.id == id)
          .comments
          .map((c) => c.$1.text)
          .toList();
      expect(comments, contains('Congrats!'));
      expect(comments.last.length, FeedInteractor.maxCommentLength);
    });

    test('the owner is notified of reactions, not the reactor', () async {
      final post = (await feed.getFeed()).firstWhere(
          (p) => p.myReaction == null && p.recipient.id != demoUserId);
      await feed.toggleReaction(post, ReactionType.love);

      final repository = getIt<ScoreboardRepository>();
      final owner = await repository.getNotifications(post.recipient.id);
      expect(
          owner.where((n) =>
              n.type == NotificationType.feedReaction &&
              n.achievementId == post.achievement.id &&
              n.actorName == 'Mario Rossi'),
          hasLength(1));
      final mine = await repository.getNotifications(demoUserId);
      expect(
          mine.where((n) =>
              n.type == NotificationType.feedReaction &&
              n.achievementId == post.achievement.id),
          isEmpty);
    });
  });

  group('notifications', () {
    late NotificationInteractor notifications;

    setUp(() => notifications = getIt<NotificationInteractor>());

    ({String title, String body}) describe(AppNotification n) =>
        (title: n.type.name, body: n.id);

    test('are delivered to the system once', () async {
      final pending =
          (await notifications.getNotifications()).where((n) => !n.delivered);
      await notifications.deliverPending(describe);
      expect(systemNotifications.shown, hasLength(pending.length));

      await notifications.deliverPending(describe);
      expect(systemNotifications.shown, hasLength(pending.length));
      expect((await notifications.getNotifications()).every((n) => n.delivered),
          isTrue);
    });

    test('are marked read and tell the listeners', () async {
      var changed = 0;
      getIt<ScoreboardInteractor>().addListener(() => changed++);
      final all = await notifications.getNotifications();
      await notifications.markRead(all);
      expect((await notifications.getNotifications()).any((n) => !n.read),
          isFalse);
      final expected = all.any((n) => !n.read) ? 1 : 0;
      expect(changed, expected);

      // Nothing left to mark: no write, no rebuild.
      await notifications.markRead(await notifications.getNotifications());
      expect(changed, expected);
    });

    test('the weekly recap comes at most once a week', () async {
      await notifications.getNotifications();
      await notifications.getNotifications();
      final weekAgo = DateTime.now().subtract(const Duration(days: 7));
      final recaps = (await notifications.getNotifications()).where((n) =>
          n.type == NotificationType.weeklyRecap &&
          n.createdAt.isAfter(weekAgo));
      expect(recaps.length, lessThanOrEqualTo(1));
      for (final recap in recaps) {
        expect(recap.number, greaterThan(0));
      }
    });

    test('a received base achievement notifies the colleague', () async {
      final scoreboard = getIt<ScoreboardInteractor>();
      final options = await scoreboard.getSendOptions();
      if (options.remainingBudget == 0) {
        return markTestSkipped('seed used the budget');
      }
      final colleague = options.colleagues.first;
      final template = options.templates
          .firstWhere((t) => !options.alreadySent(t.id, colleague.id));
      await scoreboard.sendAchievement(SendAchievementRequest(
          templateId: template.id, colleagueId: colleague.id));

      final received =
          await getIt<ScoreboardRepository>().getNotifications(colleague.id);
      expect(
          received.where((n) =>
              n.type == NotificationType.peerAchievementReceived &&
              n.achievementName == template.name &&
              n.actorName == 'Mario Rossi'),
          hasLength(1));
    });
  });
}
