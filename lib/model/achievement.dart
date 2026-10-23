import 'package:scoreboard/model/company.dart';

/// An achievement owned by [userId].
///
/// Verified achievements are issued by the company. The others are base
/// achievements sent by a colleague ([awardedById]), created from an
/// [AchievementTemplate] ([templateId]). Verified achievements embed the
/// issuing company's [companyBrand] so cards can draw its logo.
class Achievement {
  final String? name;
  final String? description;
  final String? company;
  final String? companyId;
  final CompanyBrand? companyBrand;
  final String? icon;
  final int? points;
  final DateTime? date;
  final String? id;
  final bool? verified;
  final String? userId;
  final String? templateId;

  /// Catalog entry a verified achievement was issued from.
  final String? catalogId;
  final String? awardedById;
  final String? awardedByName;
  final String? note;

  Achievement(
      {this.name,
      this.description,
      this.company,
      this.companyId,
      this.companyBrand,
      this.icon,
      this.points,
      this.date,
      this.id,
      this.verified,
      this.userId,
      this.templateId,
      this.catalogId,
      this.awardedById,
      this.awardedByName,
      this.note});

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      company: json['company'],
      companyId: json['company_id'],
      companyBrand: json['company_brand'] != null
          ? CompanyBrand.fromJson(json['company_brand'])
          : null,
      points: json['points'],
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      id: json['id'],
      verified: json['verified'],
      userId: json['user_id'],
      templateId: json['template_id'],
      catalogId: json['catalog_id'],
      awardedById: json['awarded_by_id'],
      awardedByName: json['awarded_by_name'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'icon': icon,
        'company': company,
        'company_id': companyId,
        'company_brand': companyBrand?.toJson(),
        'points': points,
        'date': date?.toIso8601String(),
        'id': id,
        'verified': verified,
        'user_id': userId,
        'template_id': templateId,
        'catalog_id': catalogId,
        'awarded_by_id': awardedById,
        'awarded_by_name': awardedByName,
        'note': note,
      };
}
