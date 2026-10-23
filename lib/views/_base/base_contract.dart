import 'package:flutter/material.dart';

abstract class BaseViewContract {
  void showLoader();

  void hideLoader();

  /// Opens [url] in the default browser; false if it couldn't.
  Future<bool> openExternalLink(String url);

  void dismissScreen([Object parameter]);
}

abstract class BaseViewModelContract<S extends BaseVMState,
    V extends BaseViewContract> extends ChangeNotifier {
  late S vmState;
  late V sourceView;

  void onInitState();
  void onResumed();
  void onDispose();
}

abstract class BaseVMState {
  bool isLoading = false;
  bool hasError = false;
}
