import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/user_profile.dart';

class UserLeaderboardEntry {
  final int rank;
  final UserProfile user;
  final Company company;
  final int points;
  final int achievementsCount;

  const UserLeaderboardEntry(
      {required this.rank,
      required this.user,
      required this.company,
      required this.points,
      required this.achievementsCount});
}

class CompanyLeaderboardEntry {
  final int rank;
  final Company company;
  final int points;
  final int membersCount;
  final int achievementsCount;

  const CompanyLeaderboardEntry(
      {required this.rank,
      required this.company,
      required this.points,
      required this.membersCount,
      required this.achievementsCount});
}
