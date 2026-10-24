import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/interactors/team_interactor.dart';
import 'package:scoreboard/model/team.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';
import 'package:scoreboard/views/admin/teams/teams_admin_contract.dart';

class TeamsAdminViewModel
    extends BaseViewModel<TeamsAdminViewContract, TeamsAdminState>
    with AdminScreenFlow<TeamsAdminViewContract, TeamsAdminState>
    implements TeamsAdminViewModelContract {
  final TeamInteractor _teams;
  @override
  final ScoreboardInteractor scoreboard;

  TeamsAdminViewModel(this._teams, this.scoreboard);

  @override
  Future<void> fetch() async {
    final user = await scoreboard.getCurrentUser();
    vmState.teams = await _teams.getTeams();
    vmState.members = (await scoreboard.getUserLeaderboard(
            companyId: user.companyId))
        .map((e) => e.user)
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  Future<void> onTapNewTeam() async {
    final answer = await sourceView.askTeam(vmState.members);
    if (answer == null) return;
    await runAction(
        () => _teams.createTeam(answer.name, managerId: answer.managerId),
        success: l10n.teamSaved);
  }

  @override
  Future<void> onTapEditTeam(Team team) async {
    final answer = await sourceView.askTeam(vmState.members, existing: team);
    if (answer == null) return;
    await runAction(
        () => _teams.updateTeam(team.id,
            name: answer.name, managerId: answer.managerId),
        success: l10n.teamSaved);
  }

  @override
  Future<void> onTapDeleteTeam(Team team) async {
    final confirmed = await sourceView.confirm(
        title: l10n.deleteTeamTitle(team.name),
        body: l10n.deleteTeamBody,
        action: l10n.commonDelete);
    if (!confirmed) return;
    await runAction(() => _teams.deleteTeam(team.id),
        success: l10n.teamDeletedMessage);
  }

  @override
  Future<void> onMoveMember(UserProfile member, String? teamId) =>
      runAction(() => _teams.moveMember(member.id, teamId));
}
