import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';

abstract class ActivityViewContract extends AdminViewContract {}

abstract class ActivityViewModelContract
    extends BaseViewModelContract<ActivityState, ActivityViewContract> {
  void load();
}

class ActivityState extends BaseVMState {
  /// Newest first.
  List<ActivityEntry> entries = [];
}
