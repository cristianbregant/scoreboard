import 'package:scoreboard/views/_base/base_contract.dart';

abstract class BaseWindowViewContract extends BaseViewContract {}

abstract class BaseWindowViewModelContract
    extends BaseViewModelContract<BaseWindowState, BaseWindowViewContract> {
  void onChangePage(int index);
}

class BaseWindowState extends BaseVMState {
  int pageIndex = 0;
}
