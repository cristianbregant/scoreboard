import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/feed.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

/// The company feed: every achievement received by a colleague, with
/// reactions and comments.
class FeedInteractor {
  static const int maxCommentLength = 500;

  final ScoreboardRepository _repository;
  final ScoreboardInteractor _scoreboard;

  FeedInteractor(this._repository, this._scoreboard);

  /// Newest first.
  Future<List<FeedPost>> getFeed() async {
    final user = await _scoreboard.getCurrentUser();
    final users = {
      for (final u in await _repository.getUsers())
        if (u.companyId == user.companyId) u.id: u
    };
    final achievements = (await _repository.getAchievements())
        .where((a) => users.containsKey(a.userId) && a.date != null)
        .toList()
      ..sort((a, b) => b.date!.compareTo(a.date!));
    final reactions = await _repository.getReactions();
    final comments = await _repository.getComments();

    return [
      for (final achievement in achievements)
        FeedPost(
          achievement: achievement,
          recipient: users[achievement.userId]!,
          reactionCounts: {
            for (final type in ReactionType.values)
              type: reactions
                  .where((r) =>
                      r.achievementId == achievement.id && r.type == type)
                  .length,
          },
          myReaction: reactions
              .where((r) =>
                  r.achievementId == achievement.id && r.userId == user.id)
              .firstOrNull
              ?.type,
          comments: [
            for (final c
                in comments.where((c) => c.achievementId == achievement.id))
              if (users[c.userId] != null) (c, users[c.userId]!),
          ]..sort((a, b) => a.$1.createdAt.compareTo(b.$1.createdAt)),
        ),
    ];
  }

  /// Sets the user's reaction, or removes it when [type] is the current one.
  Future<void> toggleReaction(FeedPost post, ReactionType type) async {
    final user = await _scoreboard.getCurrentUser();
    await _repository.setReaction(
        post.achievement.id!, user.id, post.myReaction == type ? null : type);
    _scoreboard.dataChanged();
  }

  /// Returns false when the text is empty once trimmed.
  Future<bool> comment(String achievementId, String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return false;
    final user = await _scoreboard.getCurrentUser();
    await _repository.addComment(FeedComment(
      id: 'c_${DateTime.now().microsecondsSinceEpoch}',
      achievementId: achievementId,
      userId: user.id,
      text: trimmed.length > maxCommentLength
          ? trimmed.substring(0, maxCommentLength)
          : trimmed,
      createdAt: DateTime.now(),
    ));
    _scoreboard.dataChanged();
    return true;
  }
}
