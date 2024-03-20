import 'package:flutter/material.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';

abstract class BaseState<
    T extends BaseStatefulWidget,
    VM extends BaseViewModelContract,
    S extends BaseVMState> extends State<T> implements BaseViewContract {
  late VM _viewModel;

  VM get viewModel => _viewModel;

  S get vmState => _viewModel.vmState as S;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<VM>();
    _viewModel.vmState = getIt<S>();
    _viewModel.sourceView = this;
  }

  @override
  void showLoader() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const CircularProgressIndicator.adaptive();
      },
    );
  }

  @override
  void hideLoader() {
    Navigator.pop(context);
  }

  @override
  void dismissScreen([Object? parameter]) {
    Navigator.pop(context, parameter);
  }

  @override
  void openExternalLink(
    String url,
  ) async {
    // if (!await launchUrlString(url, mode: mode)) {
    //   throw 'Could not launch $url';
    // }
  }
}
