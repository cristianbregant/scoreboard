import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/company.dart';

/// An achievement in a company's catalog: only company admins can issue it,
/// and once issued it is verified.
class CatalogAchievement {
  /// Verified achievements range from Bronze to Platinum and beyond.
  static const int minPoints = 50;
  static const int maxPoints = 200;

  final String id;
  final String companyId;
  final String name;
  final String description;
  final String icon;
  final int points;
  final bool archived;
  final DateTime createdAt;

  const CatalogAchievement(
      {required this.id,
      required this.companyId,
      required this.name,
      required this.description,
      required this.icon,
      required this.points,
      this.archived = false,
      required this.createdAt});

  CatalogAchievement copyWith(
      {String? name,
      String? description,
      String? icon,
      int? points,
      bool? archived}) {
    return CatalogAchievement(
      id: id,
      companyId: companyId,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      points: points ?? this.points,
      archived: archived ?? this.archived,
      createdAt: createdAt,
    );
  }

  /// How the achievement looks once issued, for previews.
  Achievement preview(Company company, {DateTime? date}) {
    return Achievement(
      id: 'preview_$id',
      name: name,
      description: description,
      icon: icon,
      points: points,
      verified: true,
      company: company.name,
      companyId: company.id,
      companyBrand: company.brand,
      catalogId: id,
      date: date,
    );
  }

  factory CatalogAchievement.fromJson(Map<String, dynamic> json) {
    return CatalogAchievement(
      id: json['id'],
      companyId: json['company_id'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      points: json['points'],
      archived: json['archived'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'company_id': companyId,
        'name': name,
        'description': description,
        'icon': icon,
        'points': points,
        'archived': archived,
        'created_at': createdAt.toIso8601String(),
      };
}

/// Fields of a catalog achievement, as entered by an admin.
class CatalogAchievementDraft {
  final String name;
  final String description;
  final String icon;
  final int points;

  const CatalogAchievementDraft(
      {required this.name,
      required this.description,
      required this.icon,
      required this.points});
}
