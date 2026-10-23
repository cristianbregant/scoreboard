import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_base/base_contract.dart';

abstract class BaseWindowViewContract extends BaseViewContract {}

abstract class BaseWindowViewModelContract
    extends BaseViewModelContract<BaseWindowState, BaseWindowViewContract> {
  void onChangePage(int index);
  void loadCurrentUser();
}

class BaseWindowState extends BaseVMState {
  int pageIndex = 0;
  UserProfile? currentUser;
  int currentUserPoints = 0;
}
