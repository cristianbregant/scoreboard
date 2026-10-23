import 'package:scoreboard/model/achievement_template.dart';
import 'package:scoreboard/model/user_profile.dart';

/// Fields of a new base achievement, as entered by the user.
class AchievementTemplateDraft {
  final String name;
  final String description;
  final String icon;
  final int points;

  const AchievementTemplateDraft(
      {required this.name,
      required this.description,
      required this.icon,
      required this.points});
}

class SendAchievementRequest {
  final String templateId;
  final String colleagueId;
  final String? note;

  const SendAchievementRequest(
      {required this.templateId, required this.colleagueId, this.note});
}

/// What the current user can send, and to whom.
class SendAchievementOptions {
  final UserProfile currentUser;
  final List<UserProfile> colleagues;
  final List<AchievementTemplate> templates;

  /// Pairs already sent by the current user, see [alreadySent].
  final Set<(String templateId, String colleagueId)> sentPairs;

  const SendAchievementOptions(
      {required this.currentUser,
      required this.colleagues,
      required this.templates,
      required this.sentPairs});

  bool alreadySent(String templateId, String colleagueId) =>
      sentPairs.contains((templateId, colleagueId));
}

class SendAchievementException implements Exception {
  final String message;

  const SendAchievementException(this.message);

  @override
  String toString() => message;
}
