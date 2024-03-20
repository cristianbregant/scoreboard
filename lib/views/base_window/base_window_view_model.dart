import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/base_window/base_window_contract.dart';

class BaseWindowViewModel
    extends BaseViewModel<BaseWindowViewContract, BaseWindowState>
    implements BaseWindowViewModelContract {
  BaseWindowViewModel();

  @override
  void onChangePage(int index) {
    vmState.pageIndex = index;
    notifyListeners();
  }
}
