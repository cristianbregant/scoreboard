import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';

class _State extends BaseVMState {}

class _ViewModel extends BaseViewModel<BaseViewContract, _State> {}

void main() {
  test('updates after dispose are dropped, not failing', () {
    final viewModel = _ViewModel()..vmState = _State();
    var notified = 0;
    viewModel.addListener(() => notified++);
    viewModel.startLoadingState();
    expect(notified, 1);

    viewModel.dispose();
    // A load that finishes after its page closed.
    expect(viewModel.stopLoadingState, returnsNormally);
    expect(notified, 1);
  });
}
