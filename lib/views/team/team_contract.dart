import 'package:scoreboard/interactors/team_interactor.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';

abstract class TeamViewContract extends SendAchievementViewContract {
  Future<({String catalogId, String message})?> askNomination(
      UserProfile member, List<CatalogAchievement> catalog);
}

abstract class TeamViewModelContract
    extends BaseViewModelContract<TeamState, TeamViewContract>
    implements SendAchievementActions {
  void loadTeam();
  void onTapNominate(UserProfile member);
}

class TeamState extends BaseVMState {
  TeamOverview? overview;
  Company? company;

  /// The company's active catalog.
  List<CatalogAchievement> catalog = [];

  /// Catalog ids each member already owns or has pending.
  Map<String, Set<String>> unavailable = {};

  int needAttentionCount(DateTime now) =>
      overview?.members.where((m) => m.needsAttention(now)).length ?? 0;

  int get receivedLast30Days =>
      overview?.members.fold(0, (sum, m) => sum! + m.receivedLast30Days) ?? 0;
}
