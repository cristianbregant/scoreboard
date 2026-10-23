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

  YourCompanyViewModel(this.interactor);

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
    } catch (_) {
      vmState.hasError = true;
    }
    stopLoadingState();
  }
}
