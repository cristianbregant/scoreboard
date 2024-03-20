import 'package:scoreboard/views/community/community_contract.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_widget.dart';

class CommunityView extends BaseStatefulWidget {
  CommunityView({
    Key? key,
  }) : super(_CommunityViewState(), key: key);
}

class _CommunityViewState
    extends BaseState<CommunityView, CommunityViewModelContract, CommunityState>
    implements CommunityViewContract {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<CommunityViewModelContract, CommunityState>(
        model: viewModel,
        builder: (context, viewModel, child) => Builder(builder: (context) {
              return Scaffold(
                  appBar: AppBar(title: Text("Community")),
                  body: Row(
                    children: [],
                  ));
            }));
  }
}
