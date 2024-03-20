import 'package:scoreboard/views/_base/base_contract.dart';

abstract class SettingsViewContract extends BaseViewContract {}

abstract class SettingsViewModelContract
    extends BaseViewModelContract<SettingsState, SettingsViewContract> {
  void onTapChangePage(int page);
}

class SettingsState extends BaseVMState {
  int currentPage = 0;
}
