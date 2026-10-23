import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/core/app_navigation.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:scoreboard/model/release.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';

export 'package:scoreboard/core/app_navigation.dart' show AppPage;

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
