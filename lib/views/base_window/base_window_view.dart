import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/model/player_level.dart';
import 'package:scoreboard/views/views.dart';
import 'package:scoreboard/widgets/base_view/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/base_window/base_window_contract.dart';
import 'package:scoreboard/widgets/common/user_avatar.dart';
import 'package:scoreboard/core/window_chrome.dart';

class BaseWindowView extends BaseStatefulWidget {
  BaseWindowView({super.key}) : super(_BaseWindowViewState());
}

class _BaseWindowViewState extends BaseState<
    BaseWindowView,
    BaseWindowViewModelContract,
    BaseWindowState> implements BaseWindowViewContract {
  static const int _profilePageIndex = 4;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<BaseWindowViewModelContract, BaseWindowState>(
        model: viewModel,
        builder: (context, viewModel, child) => Scaffold(
              body: Row(
                children: [
                  Sidebar(
                      items: [
                        SidebarItem(
                          label: context.l10n.navAchievements,
                          icon: Icons.emoji_events_outlined,
                          selectedIcon: Icons.emoji_events_rounded,
                        ),
                        SidebarItem(
                          label: context.l10n.navBaseAchievements,
                          icon: Icons.volunteer_activism_outlined,
                          selectedIcon: Icons.volunteer_activism_rounded,
                        ),
                        SidebarItem(
                          label: context.l10n.navYourCompany,
                          icon: Icons.business_outlined,
                          selectedIcon: Icons.business_rounded,
                        ),
                        SidebarItem(
                          label: context.l10n.navCommunity,
                          icon: Icons.people_outline,
                          selectedIcon: Icons.people_rounded,
                        ),
                        SidebarItem(
                          label: context.l10n.navProfile,
                          icon: Icons.person_outline,
                          selectedIcon: Icons.person_rounded,
                        ),
                        SidebarItem(
                          label: context.l10n.navSettings,
                          icon: Icons.tune_outlined,
                          selectedIcon: Icons.tune_rounded,
                        ),
                      ],
                      trailing: vmState.currentUser != null
                          ? _buildUserCard(context)
                          : null,
                      onItemSelected: (index) => viewModel.onChangePage(index),
                      index: vmState.pageIndex),
                  Expanded(
                    child: Stack(
                      children: [
                        IndexedStack(
                          index: vmState.pageIndex,
                          children: [
                            getIt<AchievementsView>(),
                            getIt<BaseAchievementsView>(),
                            getIt<YourCompanyView>(),
                            getIt<CommunityView>(),
                            getIt<ProfileView>(),
                            getIt<SettingsView>(),
                          ],
                        ),
                        // Hidden title bar: keep a strip to drag the window.
                        if (WindowChrome.hasHiddenTitleBar)
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            height: WindowChrome.topInset,
                            child:
                                const WindowDragArea(child: SizedBox.expand()),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget _buildUserCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final user = vmState.currentUser!;
    final level = PlayerLevel(vmState.currentUserPoints);

    return Material(
      color: colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => viewModel.onChangePage(_profilePageIndex),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  UserAvatar(
                      initials: user.initials,
                      imagePath: user.avatarPath,
                      radius: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 13.5, fontWeight: FontWeight.w600)),
                        Text(context.l10n.levelAndXp(level.level, level.points),
                            style: TextStyle(
                                fontSize: 12,
                                color: colorScheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: level.progress,
                  minHeight: 5,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
