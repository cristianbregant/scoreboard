import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Desktop notifications (macOS Notification Center, Windows toasts,
/// Linux desktop notifications).
class SystemNotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  int _nextId = 0;

  /// Called when the user clicks a notification.
  void Function()? onOpen;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    _initialized = true;
    await _plugin.initialize(
      settings: const InitializationSettings(
        macOS: DarwinInitializationSettings(),
        linux: LinuxInitializationSettings(defaultActionName: 'Open'),
        windows: WindowsInitializationSettings(
          appName: 'Scoreboard',
          appUserModelId: 'com.example.scoreboard',
          guid: '6f3b2c1e-8a4d-4f5b-9c7e-2d1a0b3c4e5f',
        ),
      ),
      onDidReceiveNotificationResponse: (_) => onOpen?.call(),
    );
  }

  Future<void> show(String title, String body) async {
    try {
      await _ensureInitialized();
      await _plugin.show(id: _nextId++, title: title, body: body);
    } catch (_) {
      // Notifications are a convenience: the in-app center still has them.
    }
  }
}
