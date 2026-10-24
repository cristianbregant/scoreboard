import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/interactors/season_interactor.dart';
import 'package:scoreboard/model/season.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';
import 'package:scoreboard/views/admin/seasons/seasons_admin_contract.dart';

class SeasonsAdminViewModel
    extends BaseViewModel<SeasonsAdminViewContract, SeasonsAdminState>
    with AdminScreenFlow<SeasonsAdminViewContract, SeasonsAdminState>
    implements SeasonsAdminViewModelContract {
  final SeasonInteractor _seasons;
  @override
  final ScoreboardInteractor scoreboard;

  SeasonsAdminViewModel(this._seasons, this.scoreboard);

  @override
  Future<void> fetch() async {
    vmState.seasons = (await _seasons.getSeasons()).reversed.toList();
  }

  @override
  Future<void> onTapNewSeason() async {
    final draft = await sourceView.askSeason();
    if (draft == null) return;
    await runAction(() => _seasons.createSeason(draft),
        success: l10n.seasonSaved);
  }

  @override
  Future<void> onTapEditSeason(Season season) async {
    final draft = await sourceView.askSeason(existing: season);
    if (draft == null) return;
    await runAction(() => _seasons.updateSeason(season.id, draft),
        success: l10n.seasonSaved);
  }

  @override
  Future<void> onTapDeleteSeason(Season season) async {
    final confirmed = await sourceView.confirm(
        title: l10n.deleteSeasonTitle(season.name),
        body: l10n.deleteSeasonBody,
        action: l10n.commonDelete);
    if (!confirmed) return;
    await runAction(() => _seasons.deleteSeason(season.id),
        success: l10n.seasonDeletedMessage);
  }
}
