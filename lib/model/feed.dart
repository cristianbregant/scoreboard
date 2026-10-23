import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/user_profile.dart';

enum ReactionType { like, celebrate, love, insightful }

/// One reaction per user per achievement.
class FeedReaction {
  final String achievementId;
  final String userId;
  final ReactionType type;

  const FeedReaction(
      {required this.achievementId, required this.userId, required this.type});

  factory FeedReaction.fromJson(Map<String, dynamic> json) => FeedReaction(
        achievementId: json['achievement_id'],
        userId: json['user_id'],
        type: ReactionType.values.byName(json['type']),
      );

  Map<String, dynamic> toJson() =>
      {'achievement_id': achievementId, 'user_id': userId, 'type': type.name};
}

class FeedComment {
  final String id;
  final String achievementId;
  final String userId;
  final String text;
  final DateTime createdAt;

  const FeedComment(
      {required this.id,
      required this.achievementId,
      required this.userId,
      required this.text,
      required this.createdAt});

  factory FeedComment.fromJson(Map<String, dynamic> json) => FeedComment(
        id: json['id'],
        achievementId: json['achievement_id'],
        userId: json['user_id'],
        text: json['text'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'achievement_id': achievementId,
        'user_id': userId,
        'text': text,
        'created_at': createdAt.toIso8601String(),
      };
}

/// An achievement as shown on the company feed, with its reactions and
/// comments resolved to people.
class FeedPost {
  final Achievement achievement;
  final UserProfile recipient;
  final Map<ReactionType, int> reactionCounts;
  final ReactionType? myReaction;
  final List<(FeedComment, UserProfile)> comments;

  const FeedPost(
      {required this.achievement,
      required this.recipient,
      required this.reactionCounts,
      required this.myReaction,
      required this.comments});

  int get totalReactions =>
      reactionCounts.values.fold(0, (sum, count) => sum + count);
}
