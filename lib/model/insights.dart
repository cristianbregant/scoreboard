import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/user_profile.dart';

class MonthlyCount {
  /// First day of the month.
  final DateTime month;
  final int verified;
  final int peer;

  const MonthlyCount(
      {required this.month, required this.verified, required this.peer});

  int get total => verified + peer;
}

/// Recognition activity of a company, for its admins.
class CompanyInsights {
  final int verifiedThisMonth;
  final int peerThisMonth;

  /// People who sent at least one base achievement this month.
  final int activeSenders;

  /// Share of members who received an achievement in the last 30 days, 0-100.
  final int coveragePercent;

  /// Oldest first, the current month last.
  final List<MonthlyCount> monthly;

  /// Members who received the fewest achievements in the last 90 days.
  final List<(UserProfile, int)> leastRecognized;

  /// Members who sent the most base achievements in the last 90 days.
  final List<(UserProfile, int)> topSenders;

  /// Catalog entries issued most often.
  final List<(CatalogAchievement, int)> topCatalog;

  const CompanyInsights(
      {required this.verifiedThisMonth,
      required this.peerThisMonth,
      required this.activeSenders,
      required this.coveragePercent,
      required this.monthly,
      required this.leastRecognized,
      required this.topSenders,
      required this.topCatalog});
}
