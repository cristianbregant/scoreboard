import 'package:scoreboard/core/app_navigation.dart';
import 'package:scoreboard/generated/l10n.dart';

/// In the browser there is no tray and no native window: the tab is the
/// window, and the browser owns it.
class DesktopShellService {
  // Kept for the same constructor as on the desktop.
  // ignore: unused_field
  final AppNavigation _navigation;

  DesktopShellService(this._navigation);

  static bool get closesToTray => false;

  Future<void> init() async {}

  void updateMenu(AppLocalization l10n) {}

  void attachMainWindow(int windowId) {}

  Future<void> showWindow() async {}

  void prepareToQuit() {}

  Future<void> quit() async {}
}
