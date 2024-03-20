import 'package:scoreboard/views/views.dart';
import 'package:scoreboard/widgets/base_view/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/base_window/base_window_contract.dart';
import 'package:scoreboard/views/settings/settings_view.dart';
import 'package:scoreboard/views/achievements/achievements_view.dart';

class BaseWindowView extends BaseStatefulWidget {
  BaseWindowView({Key? key}) : super(_BaseWindowViewState(), key: key);
}

class _BaseWindowViewState extends BaseState<
    BaseWindowView,
    BaseWindowViewModelContract,
    BaseWindowState> implements BaseWindowViewContract {
  bool appInitialized = false;

  void _appInit(BuildContext context) async {
    locatorSetupWithContext(context: context);
    await getIt.allReady();
    // viewModel.dependencyCreated();
    appInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    if (!appInitialized) _appInit(context);

    return BaseWidget<BaseWindowViewModelContract, BaseWindowState>(
        model: viewModel,
        builder: (context, viewModel, child) => Scaffold(
              body: Row(
                children: [
                  Sidebar(
                      items: [
                        SidebarItem(
                          label: "Achievements",
                          icon: Icons.emoji_events_outlined,
                          selectedIcon: Icons.emoji_events,
                        ),
                        SidebarItem(
                          label: "Your company",
                          icon: Icons.business_outlined,
                          selectedIcon: Icons.business,
                        ),
                        SidebarItem(
                          label: "Community",
                          icon: Icons.people_outline,
                          selectedIcon: Icons.people,
                        ),
                        SidebarItem(
                          label: "Profile",
                          icon: Icons.person_outline,
                          selectedIcon: Icons.person,
                        ),
                        SidebarItem(
                          label: "Settings",
                          icon: Icons.tune_outlined,
                          selectedIcon: Icons.tune,
                        ),
                      ],
                      onItemSelected: (index) => viewModel.onChangePage(index),
                      index: vmState.pageIndex),
                  Expanded(
                    child: IndexedStack(
                      index: vmState.pageIndex,
                      children: [
                        getIt<AchievementsView>(),
                        Container(), // Your company
                        getIt<CommunityView>(),
                        getIt<ProfileView>(),
                        getIt<SettingsView>(),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
