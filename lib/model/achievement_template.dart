import 'package:scoreboard/model/achievement.dart';

/// A base achievement: created by any user and sent between colleagues.
/// Sending one creates an unverified [Achievement] for the recipient.
class AchievementTemplate {
  /// Base achievements are worth less than the ones issued by the company.
  static const List<int> allowedPoints = [10, 25, 50];

  final String id;
  final String name;
  final String description;
  final String icon;
  final int points;
  final String createdById;
  final String createdByName;
  final DateTime createdAt;

  const AchievementTemplate(
      {required this.id,
      required this.name,
      required this.description,
      required this.icon,
      required this.points,
      required this.createdById,
      required this.createdByName,
      required this.createdAt});

  factory AchievementTemplate.fromJson(Map<String, dynamic> json) {
    return AchievementTemplate(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      points: json['points'],
      createdById: json['created_by_id'],
      createdByName: json['created_by_name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'icon': icon,
        'points': points,
        'created_by_id': createdById,
        'created_by_name': createdByName,
        'created_at': createdAt.toIso8601String(),
      };

  /// How the achievement looks once sent, for previews.
  Achievement preview({String? awardedByName, String? note, DateTime? date}) {
    return Achievement(
      id: 'preview_$id',
      name: name,
      description: description,
      icon: icon,
      points: points,
      verified: false,
      templateId: id,
      awardedByName: awardedByName,
      note: note,
      date: date,
    );
  }
}
