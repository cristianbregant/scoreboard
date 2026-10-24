import 'package:scoreboard/model/team.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';

abstract class TeamsAdminViewContract extends AdminViewContract {
  /// Name and manager for a new team, or [existing]; null if cancelled.
  Future<({String name, String? managerId})?> askTeam(List<UserProfile> members,
      {Team? existing});
}

abstract class TeamsAdminViewModelContract
    extends BaseViewModelContract<TeamsAdminState, TeamsAdminViewContract> {
  void load();
  void onTapNewTeam();
  void onTapEditTeam(Team team);
  void onTapDeleteTeam(Team team);
  void onMoveMember(UserProfile member, String? teamId);
}

class TeamsAdminState extends BaseVMState {
  List<Team> teams = [];

  /// The company's people, by name.
  List<UserProfile> members = [];

  List<UserProfile> membersOf(Team team) =>
      members.where((m) => m.teamId == team.id).toList();

  UserProfile? manager(Team team) =>
      members.where((m) => m.id == team.managerId).firstOrNull;
}
