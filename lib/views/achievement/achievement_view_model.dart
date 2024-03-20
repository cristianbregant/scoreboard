import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/achievement/achievement_contract.dart';

class AchievementViewModel
    extends BaseViewModel<AchievementViewContract, AchievementState>
    implements AchievementViewModelContract {
  AchievementViewModel();

  @override
  void onTapChangePage(int page) {
    vmState.currentPage = page;
    notifyListeners();
  }
}
