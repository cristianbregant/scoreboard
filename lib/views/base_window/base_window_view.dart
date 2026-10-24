import 'package:provider/provider.dart';
import 'package:scoreboard/core/providers.dart';
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
import 'package:multiview_desktop/multiview_desktop.dart';
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
import 'package:scoreboard/core/theme.dart';
import 'package:lucide_icons_flutter/lucide_icons_300.dart';
import 'package:lucide_icons_flutter/lucide_icons_500.dart';

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
    final actions = <ShortcutActivator, VoidCallback>{
      AppShortcuts.quickSend: () => viewModel.onTapSendAchievement(),
      AppShortcuts.notifications: _openNotifications,
      AppShortcuts.settings: () => viewModel.onChangePage(AppPage.settings),
      for (var i = 0;
          i < vmState.destinationCount && i < AppShortcuts.pageKeys.length;
          i++)
        AppShortcuts.primary(AppShortcuts.pageKeys[i]): () =>
            _selectDestination(i),
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
    MultiViewDesktop.of(context)
      ..show()
      ..focus();
  }

  /// The sidebar's [index]-th entry: a page, or a console section in admin
  /// mode.
  void _selectDestination(int index) => vmState.adminMode
      ? viewModel.onChangeConsoleSection(ConsoleSection.values[index])
      : viewModel.onChangePage(vmState.pages[index]);

  SidebarItem _item(AppPage page) {
    final l10n = context.l10n;
    final (label, icon, selectedIcon) = switch (page) {
      AppPage.achievements => (
          l10n.navAchievements,
          LucideIcons300.trophy,
          LucideIcons500.trophy
        ),
      AppPage.baseAchievements => (
          l10n.navBaseAchievements,
          LucideIcons300.heartHandshake,
          LucideIcons500.heartHandshake
        ),
      AppPage.feed => (
          l10n.navFeed,
          LucideIcons300.newspaper,
          LucideIcons500.newspaper
        ),
      AppPage.yourCompany => (
          l10n.navYourCompany,
          LucideIcons300.building2,
          LucideIcons500.building2
        ),
      AppPage.team => (
          l10n.navTeam,
          LucideIcons300.usersRound,
          LucideIcons500.usersRound
        ),
      AppPage.community => (
          l10n.navCommunity,
          LucideIcons300.globe,
          LucideIcons500.globe
        ),
      AppPage.profile => (
          l10n.navProfile,
          LucideIcons300.circleUser,
          LucideIcons500.circleUser
        ),
      AppPage.console => (
          l10n.navConsole,
          LucideIcons300.shieldCheck,
          LucideIcons500.shieldCheck
        ),
      AppPage.settings => (
          l10n.navSettings,
          LucideIcons300.settings2,
          LucideIcons500.settings2
        ),
    };
    return SidebarItem(label: label, icon: icon, selectedIcon: selectedIcon);
  }

  SidebarItem _sectionItem(ConsoleSection section) {
    final l10n = context.l10n;
    return switch (section) {
      ConsoleSection.catalog => SidebarItem(
          header: l10n.adminGroupRecognition,
          label: l10n.consoleCatalog,
          icon: LucideIcons300.library,
          selectedIcon: LucideIcons500.library),
      ConsoleSection.assign => SidebarItem(
          label: l10n.consoleAssign,
          icon: LucideIcons300.badgeCheck,
          selectedIcon: LucideIcons500.badgeCheck),
      ConsoleSection.requests => SidebarItem(
          label: l10n.navRequests,
          icon: LucideIcons300.inbox,
          selectedIcon: LucideIcons500.inbox,
          badge: vmState.pendingRequests),
      ConsoleSection.teams => SidebarItem(
          header: l10n.adminGroupPeople,
          label: l10n.consoleTeams,
          icon: LucideIcons300.usersRound,
          selectedIcon: LucideIcons500.usersRound),
      ConsoleSection.seasons => SidebarItem(
          label: l10n.consoleSeasons,
          icon: LucideIcons300.flag,
          selectedIcon: LucideIcons500.flag),
      ConsoleSection.insights => SidebarItem(
          header: l10n.adminGroupData,
          label: l10n.consoleStats,
          icon: LucideIcons300.chartColumn,
          selectedIcon: LucideIcons500.chartColumn),
      ConsoleSection.reports => SidebarItem(
          label: l10n.consoleReports,
          icon: LucideIcons300.fileSpreadsheet,
          selectedIcon: LucideIcons500.fileSpreadsheet),
      ConsoleSection.activity => SidebarItem(
          label: l10n.consoleActivity,
          icon: LucideIcons300.history,
          selectedIcon: LucideIcons500.history),
      ConsoleSection.company => SidebarItem(
          header: l10n.adminGroupCompany,
          label: l10n.consoleCompany,
          icon: LucideIcons300.palette,
          selectedIcon: LucideIcons500.palette),
    };
  }

  Widget _page(AppPage page) => switch (page) {
        AppPage.achievements => getIt<AchievementsView>(),
        AppPage.baseAchievements => getIt<BaseAchievementsView>(),
        AppPage.feed => getIt<FeedView>(),
        AppPage.yourCompany => getIt<YourCompanyView>(),
        AppPage.team => getIt<TeamView>(),
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
          final adminMode = vmState.adminMode;
          final stackPages = vmState.stackPages;
          final dark = Theme.of(context).brightness == Brightness.dark;
          final content = Scaffold(
            body: Row(
              children: [
                Sidebar(
                    logoPath: context.watch<BrandProvider>().logoPath,
                    adminMode: adminMode,
                    sectionLabel: adminMode ? null : context.l10n.menuLabel,
                    items: adminMode
                        ? [
                            for (final s in ConsoleSection.values)
                              _sectionItem(s)
                          ]
                        : [for (final page in vmState.pages) _item(page)],
                    headerAction: _buildBell(),
                    banner: adminMode && vmState.companyName != null
                        ? AdminBanner(
                            label:
                                context.l10n.adminBadge(vmState.companyName!))
                        : null,
                    trailing: vmState.currentUser != null
                        ? Column(
                            children: [
                              if (vmState.isAdmin)
                                AdminModeSwitch(
                                  value: adminMode,
                                  onChanged: viewModel.onToggleAdminMode,
                                ),
                              // Room for the console sections in admin mode.
                              if (!adminMode) ...[
                                if (vmState.isAdmin) const SizedBox(height: 10),
                                _buildUserCard(context),
                              ],
                            ],
                          )
                        : null,
                    onItemSelected: _selectDestination,
                    index: adminMode
                        ? vmState.consoleSection.index
                        : vmState.pages.indexOf(vmState.page)),
                Expanded(
                  child: Stack(
                    children: [
                      IndexedStack(
                        index: stackPages.indexOf(vmState.page),
                        children: [
                          for (final page in stackPages)
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
          // Admin mode recolors the whole window, so it is never mistaken
          // for the regular app. The Theme is always there and only its
          // data changes: adding or removing it would rebuild every page
          // from scratch, disposing their view models mid-load.
          return Theme(
            data: !adminMode
                ? Theme.of(context)
                : dark
                    ? AppTheme.adminThemeDataDark
                    : AppTheme.adminThemeDataLight,
            child: content,
          );
        });
  }

  Widget _buildBell() {
    final unread = vmState.unreadCount;
    return IconButton(
      tooltip: context.l10n.notificationsOpen,
      onPressed: _openNotifications,
      // Read as "Open notifications, 4 unread notifications", not "4".
      icon: Semantics(
        label: context.l10n.notificationsUnread(unread),
        excludeSemantics: true,
        child: Badge(
          isLabelVisible: unread > 0,
          label: Text(unread > 9 ? '9+' : '$unread'),
          child: Icon(unread > 0 ? LucideIcons500.bellDot : LucideIcons300.bell,
              size: 19),
        ),
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
