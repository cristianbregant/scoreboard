import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_contract.dart';

abstract class BaseViewModel<V extends BaseViewContract, S extends BaseVMState>
    extends ChangeNotifier implements BaseViewModelContract<S, V> {
  @override
  late V sourceView;

  @override
  late S vmState;

  void startLoadingState() {
    vmState.isLoading = true;
    notifyListeners();
  }

  void stopLoadingState() {
    vmState.isLoading = false;
    notifyListeners();
  }

  @override
  void onInitState() {}

  @override
  void onResumed() {}

  @override
  void onDispose() {}

  void startLoading() {
    sourceView.showLoader();
  }

  void stopLoading() {
    sourceView.hideLoader();
  }
}
