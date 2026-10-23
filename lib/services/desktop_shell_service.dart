import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:scoreboard/core/app_navigation.dart';
import 'package:scoreboard/generated/l10n.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

/// Tray (menu bar) icon and window lifecycle.
///
/// On macOS and Windows closing the window hides it and the app keeps
/// running in the tray. Linux keeps the regular close: its tray needs a
/// StatusNotifierItem host (GNOME only with an extension), and without one
/// a hidden window could not be reopened.
class DesktopShellService with WindowListener {
  final AppNavigation _navigation;
  bool _initialized = false;

  /// Kept for the app's lifetime: a collected icon disappears from the tray.
  TrayIcon? _trayIcon;

  DesktopShellService(this._navigation);

  static bool get _isMac => defaultTargetPlatform == TargetPlatform.macOS;
  static bool get closesToTray =>
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    windowManager.addListener(this);
    try {
      if (closesToTray) await windowManager.setPreventClose(true);
      final icon = TrayIcon.create();
      if (icon == null) return;
      icon.icon = ImageAsset.fromAsset(_isMac
          ? 'assets/tray/tray_icon_template.png'
          : 'assets/tray/tray_icon.png');
      icon.isIconTemplate = _isMac;
      icon.setTooltip('Scoreboard');
      // On Windows a left click opens the app, as users expect there.
      icon.addListener((event) {
        if (event is TrayIconClickedEvent &&
            defaultTargetPlatform == TargetPlatform.windows) {
          showWindow();
        }
      });
      icon.setVisible(true);
      _trayIcon = icon;
    } catch (_) {
      // No tray on this desktop: the window still works on its own.
    }
  }

  /// Rebuilt when the language changes.
  void updateMenu(AppLocalization l10n) {
    final icon = _trayIcon;
    if (icon == null) return;
    try {
      final menu = Menu.create();
      if (menu == null) return;
      void add(String label, VoidCallback onClick) {
        final item =
            MenuItem.createWithLabelAndType(label, MenuItemType.normal);
        if (item == null) return;
        item.addListener((event) {
          if (event is MenuItemClickedEvent) onClick();
        });
        menu.addItem(item);
      }

      add(l10n.trayOpen, showWindow);
      add(l10n.sendAnAchievement,
          () => showWindow().then((_) => _navigation.quickSend()));
      menu.addSeparator();
      add(l10n.trayQuit, quit);
      icon.setContextMenu(menu);
    } catch (_) {}
  }

  Future<void> showWindow() async {
    await windowManager.show();
    await windowManager.focus();
  }

  Future<void> quit() async {
    await windowManager.setPreventClose(false);
    _trayIcon?.dispose();
    _trayIcon = null;
    await windowManager.destroy();
  }

  @override
  void onWindowClose() {
    if (closesToTray) windowManager.hide();
  }
}

/// Keeps the tray menu in the app's current language.
class DesktopShellMenu extends StatefulWidget {
  final DesktopShellService shell;
  final Widget child;

  const DesktopShellMenu({super.key, required this.shell, required this.child});

  @override
  State<DesktopShellMenu> createState() => _DesktopShellMenuState();
}

class _DesktopShellMenuState extends State<DesktopShellMenu> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.shell.updateMenu(AppLocalization.of(context));
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
