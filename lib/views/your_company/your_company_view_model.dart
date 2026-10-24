import 'package:scoreboard/interactors/season_interactor.dart';
import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/admin_interactor.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';
import 'package:scoreboard/views/your_company/your_company_contract.dart';

class YourCompanyViewModel
    extends BaseViewModel<YourCompanyViewContract, YourCompanyState>
    with SendAchievementFlow<YourCompanyViewContract, YourCompanyState>
    implements YourCompanyViewModelContract {
  @override
  final ScoreboardInteractor interactor;

  final AdminInteractor _admin;
  final SeasonInteractor _seasons;

  YourCompanyViewModel(this.interactor, this._admin, this._seasons);

  @override
  void onInitState() {
    interactor.addListener(loadCompany);
    loadCompany();
  }

  @override
  void onDispose() => interactor.removeListener(loadCompany);

  @override
  Future<void> loadCompany() async {
    vmState.hasError = false;
    startLoadingState();
    try {
      final user = await interactor.getCurrentUser();
      vmState.currentUserId = user.id;
      vmState.company = await interactor.getCompany(user.companyId);
      vmState.members =
          await interactor.getUserLeaderboard(companyId: user.companyId);
      vmState.season = await _seasons.currentSeason();
      vmState.seasonBoard = vmState.season == null
          ? []
          : await _seasons.leaderboard(vmState.season!);
      vmState.catalog = await _admin.getCatalog();
      vmState.ownedCatalogIds = {
        for (final a in await interactor.getAchievementsOf(user.id))
          if (a.catalogId != null) a.catalogId!
      };
      vmState.myRequests = (await _admin.getRequests())
          .where((r) => r.userId == user.id)
          .toList();
    } catch (_) {
      vmState.hasError = true;
    }
    stopLoadingState();
  }

  @override
  Future<void> onTapRequest(CatalogAchievement item) async {
    final answer = await sourceView.askRequest(item);
    if (answer == null) return;
    try {
      await _admin.submitRequest(item.id,
          message: answer.message, evidenceUrl: answer.evidenceUrl);
      sourceView.showMessage(l10n.requestSent);
    } on AdminException catch (e) {
      sourceView.showMessage(e.localized(l10n));
    } catch (_) {
      sourceView.showMessage(l10n.actionError);
    }
  }
}
