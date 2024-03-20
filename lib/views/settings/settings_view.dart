import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/settings/settings_contract.dart';

class SettingsView extends BaseStatefulWidget {
  SettingsView({Key? key}) : super(_SettingsViewState(), key: key);
}

class _SettingsViewState
    extends BaseState<SettingsView, SettingsViewModelContract, SettingsState>
    implements SettingsViewContract {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<SettingsViewModelContract, SettingsState>(
        model: viewModel,
        builder: (context, viewModel, child) => Builder(builder: (context) {
              return Scaffold(
                  body: Row(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: Column(
                      children: [
                        ListTile(
                          selected: vmState.currentPage == 0,
                          leading: const Icon(Icons.commit),
                          title: const Text("Bitbucket repositories"),
                          onTap: () => viewModel.onTapChangePage(0),
                        ),
                        ListTile(
                          selected: vmState.currentPage == 1,
                          leading: const Icon(Icons.code),
                          title: const Text("Github repository"),
                          onTap: () => viewModel.onTapChangePage(1),
                        ),
                        ListTile(
                          selected: vmState.currentPage == 2,
                          leading: const Icon(Icons.settings_applications),
                          title: const Text("General"),
                          onTap: () => viewModel.onTapChangePage(2),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                  Expanded(
                      child: IndexedStack(
                    index: vmState.currentPage,
                    children: const [],
                  ))
                ],
              ));
            }));
  }
}
