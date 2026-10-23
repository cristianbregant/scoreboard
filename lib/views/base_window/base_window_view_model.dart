import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/base_window/base_window_contract.dart';

class BaseWindowViewModel
    extends BaseViewModel<BaseWindowViewContract, BaseWindowState>
    implements BaseWindowViewModelContract {
  final ScoreboardInteractor _interactor;

  BaseWindowViewModel(this._interactor);

  @override
  void onInitState() {
    _interactor.addListener(loadCurrentUser);
    loadCurrentUser();
  }

  @override
  void onDispose() => _interactor.removeListener(loadCurrentUser);

  @override
  void onChangePage(int index) {
    vmState.pageIndex = index;
    notifyListeners();
  }

  @override
  Future<void> loadCurrentUser() async {
    try {
      final user = await _interactor.getCurrentUser();
      final achievements = await _interactor.getAchievementsOf(user.id);
      vmState.currentUser = user;
      vmState.currentUserPoints =
          achievements.fold(0, (sum, a) => sum + (a.points ?? 0));
      notifyListeners();
    } catch (_) {
      // The sidebar footer simply stays hidden.
    }
  }
}
