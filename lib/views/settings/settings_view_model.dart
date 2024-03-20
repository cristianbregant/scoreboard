import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/settings/settings_contract.dart';

class SettingsViewModel
    extends BaseViewModel<SettingsViewContract, SettingsState>
    implements SettingsViewModelContract {
  SettingsViewModel();

  @override
  void onTapChangePage(int page) {
    vmState.currentPage = page;
    notifyListeners();
  }
}
