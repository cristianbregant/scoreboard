import 'package:flutter/services.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/shortcuts.dart';
import 'package:scoreboard/model/release.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';
import 'package:scoreboard/widgets/dialogs/onboarding_dialog.dart';
import 'package:scoreboard/widgets/dialogs/update_dialog.dart';
import 'package:scoreboard/core/routing/dynamic_routes.dart';
import 'package:scoreboard/core/routing/route_names.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/widgets/notifications_panel.dart';
import 'package:window_manager/window_manager.dart';
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

class _BaseWindowViewState extends BaseState<BaseWindowView,
        BaseWindowViewModelContract, BaseWindowState>
    with SendAchievementDialogs
    implements BaseWindowViewContract {
  @override
  void openNotificationsPanel() => _openNotifications();

  @override
  Future<void> showOnboarding() => showOnboardingDialog(context);

  @override
  void showUpdateAvailable(ReleaseInfo release) =>
      showUpdateDialog(context, release, onDownload: openExternalLink);

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_onKey);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_onKey);
    super.dispose();
  }

  /// ⌘/Ctrl shortcuts. A global handler, so they work wherever the focus
  /// is; ignored while a dialog or another page covers the window.
  bool _onKey(KeyEvent event) {
    if (event is! KeyDownEvent ||
        !(ModalRoute.of(context)?.isCurrent ?? false)) {
      return false;
    }
    final pages = vmState.pages;
    final actions = <ShortcutActivator, VoidCallback>{
      AppShortcuts.quickSend: () => viewModel.onTapSendAchievement(),
      AppShortcuts.notifications: _openNotifications,
      AppShortcuts.settings: () => viewModel.onChangePage(AppPage.settings),
      for (var i = 0; i < pages.length && i < AppShortcuts.pageKeys.length; i++)
        AppShortcuts.primary(AppShortcuts.pageKeys[i]): () =>
            viewModel.onChangePage(pages[i]),
    };
    for (final entry in actions.entries) {
      if (entry.key.accepts(event, HardwareKeyboard.instance)) {
        entry.value();
        return true;
      }
    }
    return false;
  }

  @override
  void openAchievement(Achievement achievement) {
    Navigator.of(context).pushNamed(RouteNames.achievement,
        arguments: NavigatorArguments(
            nativeArgument: achievement,
            nativeArgument2: 'notification_${achievement.id}'));
  }

  @override
  Future<void> bringToFront() async {
    await windowManager.show();
    await windowManager.focus();
  }

  SidebarItem _item(AppPage page) {
    final l10n = context.l10n;
    return switch (page) {
      AppPage.achievements => SidebarItem(
          label: l10n.navAchievements,
          icon: Icons.emoji_events_outlined,
          selectedIcon: Icons.emoji_events_rounded),
      AppPage.baseAchievements => SidebarItem(
          label: l10n.navBaseAchievements,
          icon: Icons.volunteer_activism_outlined,
          selectedIcon: Icons.volunteer_activism_rounded),
      AppPage.feed => SidebarItem(
          label: l10n.navFeed,
          icon: Icons.dynamic_feed_outlined,
          selectedIcon: Icons.dynamic_feed_rounded),
      AppPage.yourCompany => SidebarItem(
          label: l10n.navYourCompany,
          icon: Icons.business_outlined,
          selectedIcon: Icons.business_rounded),
      AppPage.community => SidebarItem(
          label: l10n.navCommunity,
          icon: Icons.people_outline,
          selectedIcon: Icons.people_rounded),
      AppPage.profile => SidebarItem(
          label: l10n.navProfile,
          icon: Icons.person_outline,
          selectedIcon: Icons.person_rounded),
      AppPage.console => SidebarItem(
          label: l10n.navConsole,
          icon: Icons.admin_panel_settings_outlined,
          selectedIcon: Icons.admin_panel_settings_rounded),
      AppPage.settings => SidebarItem(
          label: l10n.navSettings,
          icon: Icons.tune_outlined,
          selectedIcon: Icons.tune_rounded),
    };
  }

  Widget _page(AppPage page) => switch (page) {
        AppPage.achievements => getIt<AchievementsView>(),
        AppPage.baseAchievements => getIt<BaseAchievementsView>(),
        AppPage.feed => getIt<FeedView>(),
        AppPage.yourCompany => getIt<YourCompanyView>(),
        AppPage.community => getIt<CommunityView>(),
        AppPage.profile => getIt<ProfileView>(),
        AppPage.console => getIt<ConsoleView>(),
        AppPage.settings => getIt<SettingsView>(),
      };

  @override
  Widget build(BuildContext context) {
    return BaseWidget<BaseWindowViewModelContract, BaseWindowState>(
        model: viewModel,
        builder: (context, viewModel, child) {
          final pages = vmState.pages;
          return Scaffold(
            body: Row(
              children: [
                Sidebar(
                    items: [for (final page in pages) _item(page)],
                    headerAction: _buildBell(),
                    trailing: vmState.currentUser != null
                        ? _buildUserCard(context)
                        : null,
                    onItemSelected: (index) =>
                        viewModel.onChangePage(pages[index]),
                    index: pages.indexOf(vmState.page)),
                Expanded(
                  child: Stack(
                    children: [
                      IndexedStack(
                        index: pages.indexOf(vmState.page),
                        children: [
                          for (final page in pages)
                            KeyedSubtree(
                                key: ValueKey(page), child: _page(page)),
                        ],
                      ),
                      // Hidden title bar: keep a strip to drag the window.
                      if (WindowChrome.hasHiddenTitleBar)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: WindowChrome.topInset,
                          child: const WindowDragArea(child: SizedBox.expand()),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildBell() {
    final unread = vmState.unreadCount;
    return IconButton(
      tooltip: context.l10n.notificationsOpen,
      onPressed: _openNotifications,
      icon: Badge(
        isLabelVisible: unread > 0,
        label: Text(unread > 9 ? '9+' : '$unread'),
        child: Icon(unread > 0
            ? Icons.notifications_rounded
            : Icons.notifications_none_rounded),
      ),
    );
  }

  void _openNotifications() {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black26,
      builder: (dialogContext) => Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.fromLTRB(244, 16 + WindowChrome.topInset, 0, 16),
          // Rebuilds as notifications get read.
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (_, __) => NotificationsPanel(
              notifications: vmState.notifications,
              onTap: (notification) {
                Navigator.of(dialogContext).pop();
                viewModel.onTapNotification(notification);
              },
              onMarkAllRead: viewModel.onMarkAllNotificationsRead,
            ),
          ),
        ),
      ),
    );
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
        onTap: () => viewModel.onChangePage(AppPage.profile),
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
