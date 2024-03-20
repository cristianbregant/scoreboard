import 'package:scoreboard/views/profile/profile_contract.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_widget.dart';

class ProfileView extends BaseStatefulWidget {
  ProfileView({
    Key? key,
  }) : super(_ProfileViewState(), key: key);
}

class _ProfileViewState
    extends BaseState<ProfileView, ProfileViewModelContract, ProfileState>
    implements ProfileViewContract {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<ProfileViewModelContract, ProfileState>(
        model: viewModel,
        builder: (context, viewModel, child) => Builder(builder: (context) {
              return Scaffold(
                  appBar: AppBar(title: const Text("Profile")),
                  body: Row(
                    children: [],
                  ));
            }));
  }
}
