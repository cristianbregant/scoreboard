import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_base/base_contract.dart';

/// Pages of the main window, in sidebar order.
enum AppPage {
  achievements,
  baseAchievements,
  feed,
  yourCompany,
  community,
  profile,

  /// Company admins only.
  console,
  settings,
}

abstract class BaseWindowViewContract extends BaseViewContract {
  void openAchievement(Achievement achievement);
  void bringToFront();
}

abstract class BaseWindowViewModelContract
    extends BaseViewModelContract<BaseWindowState, BaseWindowViewContract> {
  void onChangePage(AppPage page);
  void loadCurrentUser();
  void onTapNotification(AppNotification notification);
  void onMarkAllNotificationsRead();
}

class BaseWindowState extends BaseVMState {
  AppPage page = AppPage.achievements;
  UserProfile? currentUser;
  int currentUserPoints = 0;
  List<AppNotification> notifications = [];

  List<AppPage> get pages => [
        for (final page in AppPage.values)
          if (page != AppPage.console || (currentUser?.isCompanyAdmin ?? false))
            page
      ];

  int get unreadCount => notifications.where((n) => !n.read).length;
}
