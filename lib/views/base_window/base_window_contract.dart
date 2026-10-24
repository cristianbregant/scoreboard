import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/core/app_navigation.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:scoreboard/model/release.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';

export 'package:scoreboard/core/app_navigation.dart'
    show AppPage, ConsoleSection;

abstract class BaseWindowViewContract extends SendAchievementViewContract {
  void openAchievement(Achievement achievement);
  void bringToFront();
  void openNotificationsPanel();
  Future<void> showOnboarding();
  void showUpdateAvailable(ReleaseInfo release);
}

abstract class BaseWindowViewModelContract
    extends BaseViewModelContract<BaseWindowState, BaseWindowViewContract>
    implements SendAchievementActions {
  /// Leaves admin mode for any page but the console.
  void onChangePage(AppPage page);

  /// Opens a console section, entering admin mode.
  void onChangeConsoleSection(ConsoleSection section);
  void onToggleAdminMode(bool enabled);
  void loadCurrentUser();
  void onTapNotification(AppNotification notification);
  void onMarkAllNotificationsRead();
}

class BaseWindowState extends BaseVMState {
  AppPage page = AppPage.achievements;
  UserProfile? currentUser;
  int currentUserPoints = 0;
  List<AppNotification> notifications = [];

  /// Admins switch between the app and the console with admin mode: the
  /// sidebar then lists the console sections only, in the admin accent.
  String? companyName;
  bool adminMode = false;
  ConsoleSection consoleSection = ConsoleSection.catalog;

  /// Requests waiting for an admin, shown on the sidebar.
  int pendingRequests = 0;

  bool get isAdmin => currentUser?.isCompanyAdmin ?? false;

  /// Leads a team, so has the team page.
  bool isManager = false;

  /// The sidebar pages outside admin mode.
  List<AppPage> get pages => [
        for (final page in AppPage.values)
          if (page != AppPage.console && (page != AppPage.team || isManager))
            page
      ];

  /// Every page kept alive in the window, the console for admins only.
  List<AppPage> get stackPages => [...pages, if (isAdmin) AppPage.console];

  /// What the sidebar lists, in order, also for the ⌘1…8 shortcuts.
  int get destinationCount =>
      adminMode ? ConsoleSection.values.length : pages.length;

  int get unreadCount => notifications.where((n) => !n.read).length;
}
