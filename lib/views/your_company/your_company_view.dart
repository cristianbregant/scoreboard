import 'package:scoreboard/views/your_company/your_company_contract.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_widget.dart';

class YourCompanyView extends BaseStatefulWidget {
  YourCompanyView({
    Key? key,
  }) : super(_YourCompanyViewState(), key: key);
}

class _YourCompanyViewState extends BaseState<
    YourCompanyView,
    YourCompanyViewModelContract,
    YourCompanyState> implements YourCompanyViewContract {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<YourCompanyViewModelContract, YourCompanyState>(
        model: viewModel,
        builder: (context, viewModel, child) => Builder(builder: (context) {
              return Scaffold(
                  appBar: AppBar(title: const Text("Your Company")),
                  body: Row(
                    children: [],
                  ));
            }));
  }
}
