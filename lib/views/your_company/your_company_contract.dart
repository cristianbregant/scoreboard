import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/leaderboard_entry.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';

abstract class YourCompanyViewContract extends SendAchievementViewContract {}

abstract class YourCompanyViewModelContract
    extends BaseViewModelContract<YourCompanyState, YourCompanyViewContract>
    implements SendAchievementActions {
  void loadCompany();
}

class YourCompanyState extends BaseVMState {
  Company? company;
  String? currentUserId;
  List<UserLeaderboardEntry> members = [];

  int get totalPoints => members.fold(0, (sum, e) => sum + e.points);
  int get totalAchievements =>
      members.fold(0, (sum, e) => sum + e.achievementsCount);
  int? get currentUserRank =>
      members.where((e) => e.user.id == currentUserId).firstOrNull?.rank;
}
