import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/notification_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/base_window/base_window_contract.dart';

class BaseWindowViewModel
    extends BaseViewModel<BaseWindowViewContract, BaseWindowState>
    implements BaseWindowViewModelContract {
  final ScoreboardInteractor _interactor;
  final NotificationInteractor _notifications;

  BaseWindowViewModel(this._interactor, this._notifications);

  @override
  void onInitState() {
    _notifications.onSystemNotificationOpened = () => sourceView.bringToFront();
    _interactor.addListener(loadCurrentUser);
    loadCurrentUser();
  }

  @override
  void onDispose() => _interactor.removeListener(loadCurrentUser);

  @override
  void onChangePage(AppPage page) {
    vmState.page = page;
    notifyListeners();
  }

  @override
  Future<void> loadCurrentUser() async {
    try {
      final user = await _interactor.getCurrentUser();
      final achievements = await _interactor.getAchievementsOf(user.id);
      vmState.currentUser = user;
      vmState.currentUserPoints =
          achievements.fold(0, (sum, a) => sum + (a.points ?? 0));
      if (!vmState.pages.contains(vmState.page)) {
        vmState.page = AppPage.achievements;
      }
      await _notifications
          .deliverPending((n) => (title: n.title(l10n), body: n.body(l10n)));
      vmState.notifications = await _notifications.getNotifications();
      notifyListeners();
    } catch (_) {
      // The sidebar footer and the bell simply stay empty.
    }
  }

  @override
  Future<void> onTapNotification(AppNotification notification) async {
    await _notifications.markRead([notification]);
    final achievementId = notification.achievementId;
    switch (notification.type) {
      case NotificationType.feedReaction:
      case NotificationType.feedComment:
        onChangePage(AppPage.feed);
      case NotificationType.newRequest:
        onChangePage(vmState.pages.contains(AppPage.console)
            ? AppPage.console
            : AppPage.yourCompany);
      case NotificationType.requestApproved:
      case NotificationType.requestRejected:
        onChangePage(AppPage.yourCompany);
      case NotificationType.levelUp:
      case NotificationType.weeklyRecap:
        onChangePage(AppPage.profile);
      case NotificationType.peerAchievementReceived:
      case NotificationType.verifiedAchievementReceived:
        final user = vmState.currentUser;
        final achievement = user == null || achievementId == null
            ? null
            : (await _interactor.getAchievementsOf(user.id))
                .where((a) => a.id == achievementId)
                .firstOrNull;
        if (achievement != null) {
          sourceView.openAchievement(achievement);
        } else {
          onChangePage(AppPage.achievements);
        }
    }
  }

  @override
  Future<void> onMarkAllNotificationsRead() =>
      _notifications.markRead(vmState.notifications);
}
