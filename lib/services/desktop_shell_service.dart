import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:scoreboard/core/app_navigation.dart';
import 'package:scoreboard/generated/l10n.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:multiview_desktop/multiview_desktop.dart';

/// Tray (menu bar) icon and window lifecycle.
///
/// On macOS and Windows closing the window hides it and the app keeps
/// running in the tray. Linux keeps the regular close: its tray needs a
/// StatusNotifierItem host (GNOME only with an extension), and without one
/// a hidden window could not be reopened.
class DesktopShellService implements WindowListenerCallbacks {
  final AppNavigation _navigation;
  bool _initialized = false;

  /// The main window, known once `runMultiApp` has created it.
  int? _mainWindowId;

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
    try {
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

  /// Called with the main window's id from the `runMultiApp` home builder,
  /// which can run more than once.
  void attachMainWindow(int windowId) {
    if (_mainWindowId == windowId) return;
    _mainWindowId = windowId;
    // After the frame being built: the window's state isn't touched mid-build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MultiViewDesktop.addListenerForView(windowId, this);
      // Closing then reaches onWindowClose instead of closing the window.
      if (closesToTray) {
        MultiViewDesktop.fromId(windowId).setPreventClose(true);
      }
    });
  }

  MultiViewDesktop? get _mainWindow {
    final id = _mainWindowId;
    return id == null ? null : MultiViewDesktop.fromId(id);
  }

  Future<void> showWindow() async {
    _mainWindow
      ?..show()
      ..focus();
  }

  /// Lets the window close for real and removes the tray icon. Also runs
  /// before ⌘Q on macOS, see `main`.
  void prepareToQuit() {
    _mainWindow?.setPreventClose(false);
    _trayIcon?.dispose();
    _trayIcon = null;
  }

  Future<void> quit() async {
    prepareToQuit();
    await MultiViewDesktop.closeApp(closeMode: CloseMode.destroy);
  }

  /// The close button hides the window to the tray. Returns false so a
  /// cascade close stops here: the window was only hidden.
  @override
  FutureOr<bool> onWindowClose() {
    if (!closesToTray) return true;
    _mainWindow?.hide();
    return false;
  }

  @override
  void onWindowFocus() {}

  @override
  void onWindowBlur() {}

  @override
  void onWindowMaximize() {}

  @override
  void onWindowUnmaximize() {}

  @override
  void onWindowMinimize() {}

  @override
  void onWindowRestore() {}

  @override
  void onWindowResize() {}

  @override
  void onWindowResized() {}

  @override
  void onWindowMove() {}

  @override
  void onWindowMoved() {}

  @override
  void onWindowEnterFullScreen() {}

  @override
  void onWindowLeaveFullScreen() {}

  @override
  void onWindowEvent(String eventName) {}
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
