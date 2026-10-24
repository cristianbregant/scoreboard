import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/admin_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/interactors/team_interactor.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';
import 'package:scoreboard/views/team/team_contract.dart';

class TeamViewModel extends BaseViewModel<TeamViewContract, TeamState>
    with SendAchievementFlow<TeamViewContract, TeamState>
    implements TeamViewModelContract {
  final TeamInteractor _teams;
  final AdminInteractor _admin;
  final ScoreboardInteractor _scoreboard;

  TeamViewModel(this._teams, this._admin, this._scoreboard);

  @override
  ScoreboardInteractor get interactor => _scoreboard;

  @override
  void onInitState() {
    _scoreboard.addListener(_reloadSilently);
    loadTeam();
  }

  @override
  void onDispose() => _scoreboard.removeListener(_reloadSilently);

  @override
  Future<void> loadTeam() async {
    vmState.hasError = false;
    startLoadingState();
    await _fetch();
    stopLoadingState();
  }

  Future<void> _reloadSilently() async {
    await _fetch();
    notifyListeners();
  }

  Future<void> _fetch() async {
    try {
      final user = await _scoreboard.getCurrentUser();
      if (await _teams.managedTeam() == null) {
        vmState.overview = null;
        return;
      }
      vmState.overview = await _teams.getOverview();
      vmState.company = await _scoreboard.getCompany(user.companyId);
      vmState.catalog = await _admin.getCatalog();
      final requests = await _admin.getRequests();
      vmState.unavailable = {
        for (final stats in vmState.overview!.members)
          stats.member.id: {
            for (final a
                in await _scoreboard.getAchievementsOf(stats.member.id))
              if (a.catalogId != null) a.catalogId!,
            for (final r in requests)
              if (r.userId == stats.member.id &&
                  r.status == RequestStatus.pending)
                r.catalogId,
          }
      };
    } catch (_) {
      vmState.hasError = true;
    }
  }

  @override
  Future<void> onTapNominate(UserProfile member) async {
    final unavailable = vmState.unavailable[member.id] ?? {};
    final options =
        vmState.catalog.where((c) => !unavailable.contains(c.id)).toList();
    if (options.isEmpty) {
      sourceView.showMessage(l10n.errorAlreadyOwned);
      return;
    }
    final answer = await sourceView.askNomination(member, options);
    if (answer == null) return;
    try {
      await _teams.nominate(member.id, answer.catalogId,
          message: answer.message);
      sourceView.showMessage(l10n.nominateSent);
    } on AdminException catch (e) {
      sourceView.showMessage(e.localized(l10n));
    } catch (_) {
      sourceView.showMessage(l10n.actionError);
    }
  }
}
