import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/community/community_contract.dart';

class CommunityViewModel
    extends BaseViewModel<CommunityViewContract, CommunityState>
    implements CommunityViewModelContract {
  final ScoreboardInteractor _interactor;

  CommunityViewModel(this._interactor);

  @override
  void onInitState() {
    _interactor.addListener(loadLeaderboards);
    loadLeaderboards();
  }

  @override
  void onDispose() => _interactor.removeListener(loadLeaderboards);

  @override
  Future<void> loadLeaderboards() async {
    vmState.hasError = false;
    startLoadingState();
    try {
      final user = await _interactor.getCurrentUser();
      vmState.currentUserId = user.id;
      vmState.currentCompanyId = user.companyId;
      vmState.currentUserHidden = user.hiddenFromCommunity;
      vmState.users = await _interactor.getUserLeaderboard();
      vmState.companies = await _interactor.getCompanyLeaderboard();
    } catch (_) {
      vmState.hasError = true;
    }
    stopLoadingState();
  }

  @override
  void onChangeTab(CommunityTab tab) {
    vmState.tab = tab;
    notifyListeners();
  }

  @override
  void onSearchChanged(String query) {
    vmState.query = query;
    notifyListeners();
  }
}
