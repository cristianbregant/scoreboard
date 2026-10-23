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
  /// Base achievements each person can send per calendar month, so they
  /// stay meaningful rather than turning into spam.
  static const int monthlyBudget = 5;

  final UserProfile currentUser;
  final List<UserProfile> colleagues;
  final List<AchievementTemplate> templates;

  /// Pairs already sent by the current user, see [alreadySent].
  final Set<(String templateId, String colleagueId)> sentPairs;

  /// Base achievements the current user can still send this month.
  final int remainingBudget;

  const SendAchievementOptions(
      {required this.currentUser,
      required this.colleagues,
      required this.templates,
      required this.sentPairs,
      required this.remainingBudget});

  bool alreadySent(String templateId, String colleagueId) =>
      sentPairs.contains((templateId, colleagueId));
}

enum SendAchievementError {
  invalidPoints,
  notTemplateOwner,
  notAColleague,
  templateNotFound,
  alreadySent,
  budgetExhausted,
}

/// Carries a [SendAchievementError] code, plus the names the message
/// needs; the UI turns it into localized text.
class SendAchievementException implements Exception {
  final SendAchievementError error;
  final String? templateName;
  final String? colleagueName;

  const SendAchievementException(this.error,
      {this.templateName, this.colleagueName});

  @override
  String toString() => 'SendAchievementException($error)';
}
