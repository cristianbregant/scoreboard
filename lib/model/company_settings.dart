import 'package:scoreboard/model/catalog_achievement.dart';

/// What a company's admins configure: its look in the app, its work
/// anniversary achievements and how much the app ranks and flags people.
///
/// The two privacy switches are mirrored on [Company] by the repository, so
/// every screen (and other companies' leaderboards) can honor them.
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

  /// Leaderboards and ranks of individual people. Off, the company's people
  /// are never ranked against each other, nor in the Community leaderboard;
  /// company totals stay.
  final bool individualRankings;

  /// Lists of who received little recognition lately, for managers and
  /// admins. Some works councils treat these as performance monitoring.
  final bool recognitionGaps;

  /// Single sign-on: the Microsoft Entra tenant id and the Google Workspace
  /// domain whose accounts may sign in to this company; null when unused.
  final String? ssoMicrosoftTenant;
  final String? ssoGoogleDomain;

  const CompanySettings(
      {required this.companyId,
      this.accentColor,
      this.logoPath,
      this.anniversariesEnabled = true,
      this.anniversaryYears = defaultAnniversaryYears,
      this.individualRankings = true,
      this.recognitionGaps = true,
      this.ssoMicrosoftTenant,
      this.ssoGoogleDomain});

  /// Nullable fields are cleared by passing `clearAccent` / `clearLogo`.
  CompanySettings copyWith(
          {int? accentColor,
          bool clearAccent = false,
          String? logoPath,
          bool clearLogo = false,
          bool? anniversariesEnabled,
          List<int>? anniversaryYears,
          bool? individualRankings,
          bool? recognitionGaps,
          String? ssoMicrosoftTenant,
          bool clearSsoMicrosoftTenant = false,
          String? ssoGoogleDomain,
          bool clearSsoGoogleDomain = false}) =>
      CompanySettings(
        companyId: companyId,
        accentColor: clearAccent ? null : (accentColor ?? this.accentColor),
        logoPath: clearLogo ? null : (logoPath ?? this.logoPath),
        anniversariesEnabled: anniversariesEnabled ?? this.anniversariesEnabled,
        anniversaryYears: anniversaryYears ?? this.anniversaryYears,
        individualRankings: individualRankings ?? this.individualRankings,
        recognitionGaps: recognitionGaps ?? this.recognitionGaps,
        ssoMicrosoftTenant: clearSsoMicrosoftTenant
            ? null
            : (ssoMicrosoftTenant ?? this.ssoMicrosoftTenant),
        ssoGoogleDomain: clearSsoGoogleDomain
            ? null
            : (ssoGoogleDomain ?? this.ssoGoogleDomain),
      );

  factory CompanySettings.fromJson(Map<String, dynamic> json) =>
      CompanySettings(
        companyId: json['company_id'],
        accentColor: json['accent_color'],
        logoPath: json['logo_path'],
        anniversariesEnabled: json['anniversaries_enabled'] ?? true,
        anniversaryYears: (json['anniversary_years'] as List?)?.cast<int>() ??
            defaultAnniversaryYears,
        individualRankings: json['individual_rankings'] ?? true,
        recognitionGaps: json['recognition_gaps'] ?? true,
        ssoMicrosoftTenant: json['sso_microsoft_tenant'],
        ssoGoogleDomain: json['sso_google_domain'],
      );

  Map<String, dynamic> toJson() => {
        'company_id': companyId,
        'accent_color': accentColor,
        'logo_path': logoPath,
        'anniversaries_enabled': anniversariesEnabled,
        'anniversary_years': anniversaryYears,
        'individual_rankings': individualRankings,
        'recognition_gaps': recognitionGaps,
        'sso_microsoft_tenant': ssoMicrosoftTenant,
        'sso_google_domain': ssoGoogleDomain,
      };
}
