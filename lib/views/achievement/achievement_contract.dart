import 'package:scoreboard/views/_base/base_contract.dart';

abstract class AchievementViewContract extends BaseViewContract {}

abstract class AchievementViewModelContract
    extends BaseViewModelContract<AchievementState, AchievementViewContract> {
  void onTapChangePage(int page);
}

class AchievementState extends BaseVMState {
  int currentPage = 0;
}
