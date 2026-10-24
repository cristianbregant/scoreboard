import 'package:scoreboard/core/app_navigation.dart';
import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/admin_interactor.dart';
import 'package:scoreboard/interactors/app_configuration_interactor.dart';
import 'package:scoreboard/interactors/team_interactor.dart';
import 'package:scoreboard/interactors/notification_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/interactors/update_interactor.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';
import 'package:scoreboard/views/base_window/base_window_contract.dart';

class BaseWindowViewModel
    extends BaseViewModel<BaseWindowViewContract, BaseWindowState>
    with SendAchievementFlow<BaseWindowViewContract, BaseWindowState>
    implements BaseWindowViewModelContract {
  @override
  final ScoreboardInteractor interactor;
  final NotificationInteractor _notifications;
  final AppNavigation _navigation;
  final AppConfigurationInteractor _configuration;
  final UpdateInteractor _updates;
  final AdminInteractor _admin;
  final TeamInteractor _teams;
  bool _startupChecksDone = false;

  /// Where the sidebar returns when admin mode is turned off.
  AppPage _lastPage = AppPage.achievements;

  BaseWindowViewModel(this.interactor, this._notifications, this._navigation,
      this._configuration, this._updates, this._admin, this._teams);

  @override
  void onInitState() {
    _notifications.onSystemNotificationOpened = () => sourceView.bringToFront();
    interactor.addListener(loadCurrentUser);
    _navigation.addListener(_onNavigationRequest);
    loadCurrentUser();
  }

  @override
  void onDispose() {
    interactor.removeListener(loadCurrentUser);
    _navigation.removeListener(_onNavigationRequest);
  }

  void _onNavigationRequest() {
    final request = _navigation.takeRequest();
    if (request == null) return;
    switch (request) {
      case (NavigationRequest.openPage, final AppPage page):
        if (vmState.stackPages.contains(page)) onChangePage(page);
      case (NavigationRequest.quickSend, _):
        onTapSendAchievement();
      case (NavigationRequest.openNotifications, _):
        sourceView.openNotificationsPanel();
      default:
        break;
    }
  }

  /// Once per session: the introduction for new users, then the daily
  /// update check.
  Future<void> _runStartupChecks(String userId) async {
    if (_startupChecksDone) return;
    _startupChecksDone = true;
    if (!_configuration.isOnboardingDone(userId)) {
      await sourceView.showOnboarding();
      await _configuration.setOnboardingDone(userId);
    }
    final release = await _updates.checkDaily();
    if (release != null) sourceView.showUpdateAvailable(release);
  }

  @override
  void onChangePage(AppPage page) {
    if (page == AppPage.console) {
      onChangeConsoleSection(vmState.consoleSection);
      return;
    }
    vmState.adminMode = false;
    vmState.page = page;
    _lastPage = page;
    notifyListeners();
  }

  @override
  void onChangeConsoleSection(ConsoleSection section) {
    if (!vmState.isAdmin) return;
    vmState.adminMode = true;
    vmState.page = AppPage.console;
    vmState.consoleSection = section;
    _navigation.consoleSection.value = section;
    notifyListeners();
  }

  @override
  void onToggleAdminMode(bool enabled) => enabled
      ? onChangeConsoleSection(vmState.consoleSection)
      : onChangePage(_lastPage);

  @override
  Future<void> loadCurrentUser() async {
    try {
      final user = await interactor.getCurrentUser();
      final achievements = await interactor.getAchievementsOf(user.id);
      vmState.currentUser = user;
      vmState.currentUserPoints =
          achievements.fold(0, (sum, a) => sum + (a.points ?? 0));
      vmState.companyName = (await interactor.getCompany(user.companyId)).name;
      vmState.isManager = await _teams.managedTeam() != null;
      vmState.pendingRequests = user.isCompanyAdmin
          ? (await _admin.getRequests())
              .where((r) => r.status == RequestStatus.pending)
              .length
          : 0;
      if (!vmState.stackPages.contains(vmState.page)) {
        vmState.adminMode = false;
        vmState.page = AppPage.achievements;
      }
      await _notifications
          .deliverPending((n) => (title: n.title(l10n), body: n.body(l10n)));
      vmState.notifications = await _notifications.getNotifications();
      notifyListeners();
      _runStartupChecks(user.id);
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
      case NotificationType.newNomination:
        vmState.isAdmin
            ? onChangeConsoleSection(ConsoleSection.requests)
            : onChangePage(AppPage.yourCompany);
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
            : (await interactor.getAchievementsOf(user.id))
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
