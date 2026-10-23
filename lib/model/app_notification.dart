enum NotificationType {
  /// A colleague sent the user a base achievement.
  peerAchievementReceived,

  /// The company issued the user a verified achievement.
  verifiedAchievementReceived,
  levelUp,
  requestApproved,
  requestRejected,

  /// For admins: a member asked for a catalog achievement.
  newRequest,
  feedReaction,
  feedComment,
  weeklyRecap,
}

/// A notification for [userId]. It stores a [type] and the values its text
/// needs, so the UI can word it in the current language.
class AppNotification {
  final String id;
  final String userId;
  final NotificationType type;
  final DateTime createdAt;
  final bool read;

  /// Whether it was already shown as a system notification.
  final bool delivered;

  /// Person who caused it: sender, commenter, requester.
  final String? actorName;
  final String? achievementId;
  final String? achievementName;

  /// Level reached, XP of the week, rank or rejection reason, by type.
  final int? number;
  final int? secondNumber;
  final String? text;

  const AppNotification(
      {required this.id,
      required this.userId,
      required this.type,
      required this.createdAt,
      this.read = false,
      this.delivered = false,
      this.actorName,
      this.achievementId,
      this.achievementName,
      this.number,
      this.secondNumber,
      this.text});

  AppNotification copyWith({bool? read, bool? delivered}) => AppNotification(
        id: id,
        userId: userId,
        type: type,
        createdAt: createdAt,
        read: read ?? this.read,
        delivered: delivered ?? this.delivered,
        actorName: actorName,
        achievementId: achievementId,
        achievementName: achievementName,
        number: number,
        secondNumber: secondNumber,
        text: text,
      );

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      AppNotification(
        id: json['id'],
        userId: json['user_id'],
        type: NotificationType.values.byName(json['type']),
        createdAt: DateTime.parse(json['created_at']),
        read: json['read'] ?? false,
        delivered: json['delivered'] ?? false,
        actorName: json['actor_name'],
        achievementId: json['achievement_id'],
        achievementName: json['achievement_name'],
        number: json['number'],
        secondNumber: json['second_number'],
        text: json['text'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'type': type.name,
        'created_at': createdAt.toIso8601String(),
        'read': read,
        'delivered': delivered,
        'actor_name': actorName,
        'achievement_id': achievementId,
        'achievement_name': achievementName,
        'number': number,
        'second_number': secondNumber,
        'text': text,
      };
}
