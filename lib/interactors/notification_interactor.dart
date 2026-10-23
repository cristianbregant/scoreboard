import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';
import 'package:scoreboard/services/system_notification_service.dart';

class NotificationInteractor {
  final ScoreboardRepository _repository;
  final ScoreboardInteractor _scoreboard;
  final SystemNotificationService _system;

  NotificationInteractor(this._repository, this._scoreboard, this._system);

  Future<List<AppNotification>> getNotifications() async {
    final user = await _scoreboard.getCurrentUser();
    return _repository.getNotifications(user.id);
  }

  Future<void> markRead(Iterable<AppNotification> notifications) async {
    final unread = notifications.where((n) => !n.read).toList();
    if (unread.isEmpty) return;
    await _repository
        .updateNotifications([for (final n in unread) n.copyWith(read: true)]);
    _scoreboard.dataChanged();
  }

  /// Shows the notifications not shown yet as system notifications.
  /// [describe] words them in the current language.
  Future<void> deliverPending(
      ({String title, String body}) Function(AppNotification) describe) async {
    final pending =
        (await getNotifications()).where((n) => !n.delivered).toList();
    if (pending.isEmpty) return;
    await _repository.updateNotifications(
        [for (final n in pending) n.copyWith(delivered: true)]);
    for (final notification in pending.reversed) {
      final text = describe(notification);
      await _system.show(text.title, text.body);
    }
  }

  set onSystemNotificationOpened(void Function() callback) =>
      _system.onOpen = callback;
}
