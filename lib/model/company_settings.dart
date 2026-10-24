import 'package:scoreboard/model/catalog_achievement.dart';

/// What a company's admins configure: its look in the app and its work
/// anniversary achievements.
class CompanySettings {
  /// Years of service that earn an anniversary achievement.
  static const List<int> availableAnniversaryYears = [1, 2, 3, 5, 10, 15, 20];
  static const List<int> defaultAnniversaryYears = [1, 3, 5, 10];

  /// 60 XP for the first year, 10 more per year, up to the catalog's 200.
  static int anniversaryPoints(int years) => (50 + years * 10)
      .clamp(CatalogAchievement.minPoints, CatalogAchievement.maxPoints);

  final String companyId;

  /// ARGB accent replacing Scoreboard's gold for the company's people;
  /// null keeps the gold. The app adjusts it to stay readable.
  final int? accentColor;

  /// Local path of the company logo, shown in the sidebar.
  final String? logoPath;

  final bool anniversariesEnabled;
  final List<int> anniversaryYears;

  const CompanySettings(
      {required this.companyId,
      this.accentColor,
      this.logoPath,
      this.anniversariesEnabled = true,
      this.anniversaryYears = defaultAnniversaryYears});

  /// Nullable fields are cleared by passing `clearAccent` / `clearLogo`.
  CompanySettings copyWith(
          {int? accentColor,
          bool clearAccent = false,
          String? logoPath,
          bool clearLogo = false,
          bool? anniversariesEnabled,
          List<int>? anniversaryYears}) =>
      CompanySettings(
        companyId: companyId,
        accentColor: clearAccent ? null : (accentColor ?? this.accentColor),
        logoPath: clearLogo ? null : (logoPath ?? this.logoPath),
        anniversariesEnabled: anniversariesEnabled ?? this.anniversariesEnabled,
        anniversaryYears: anniversaryYears ?? this.anniversaryYears,
      );

  factory CompanySettings.fromJson(Map<String, dynamic> json) =>
      CompanySettings(
        companyId: json['company_id'],
        accentColor: json['accent_color'],
        logoPath: json['logo_path'],
        anniversariesEnabled: json['anniversaries_enabled'] ?? true,
        anniversaryYears: (json['anniversary_years'] as List?)?.cast<int>() ??
            defaultAnniversaryYears,
      );

  Map<String, dynamic> toJson() => {
        'company_id': companyId,
        'accent_color': accentColor,
        'logo_path': logoPath,
        'anniversaries_enabled': anniversariesEnabled,
        'anniversary_years': anniversaryYears,
      };
}
