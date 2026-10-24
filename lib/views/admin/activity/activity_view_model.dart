import 'package:scoreboard/interactors/activity_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';
import 'package:scoreboard/views/admin/activity/activity_contract.dart';

class ActivityViewModel
    extends BaseViewModel<ActivityViewContract, ActivityState>
    with AdminScreenFlow<ActivityViewContract, ActivityState>
    implements ActivityViewModelContract {
  final ActivityInteractor _activity;
  @override
  final ScoreboardInteractor scoreboard;

  ActivityViewModel(this._activity, this.scoreboard);

  @override
  Future<void> fetch() async {
    vmState.entries = await _activity.getActivity();
  }
}
