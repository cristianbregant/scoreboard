import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:multiview_desktop/multiview_desktop.dart';

/// Per-platform window frame.
///
/// On macOS the title bar is hidden and the content extends under it, next
/// to the traffic lights. Windows and Linux keep the native title bar, which
/// holds the minimize/maximize/close buttons, so no inset is needed there.
class WindowChrome {
  /// Answered by MainFlutterWindow.swift.
  static const MethodChannel _channel = MethodChannel('scoreboard/window');

  static bool get hasHiddenTitleBar =>
      defaultTargetPlatform == TargetPlatform.macOS;

  static TitleBarStyle get titleBarStyle =>
      hasHiddenTitleBar ? TitleBarStyle.hidden : TitleBarStyle.normal;

  /// Height covered by the macOS traffic lights.
  static double get topInset => hasHiddenTitleBar ? 28 : 0;

  /// Width covered by the macOS traffic lights.
  static double get leadingInset => hasHiddenTitleBar ? 68 : 0;

  /// Moves the window with the mouse, until the button is released.
  static Future<void> startDragging() => _invoke('startDragging');

  /// Zooms the window, like double-clicking a title bar.
  static Future<void> zoom() => _invoke('zoom');

  static Future<void> _invoke(String method) async {
    try {
      await _channel.invokeMethod<void>(method);
    } on PlatformException catch (_) {
    } on MissingPluginException catch (_) {}
  }
}

/// Lets the user move the window by dragging the empty parts of [child]
/// when there is no title bar to drag; elsewhere it just shows [child].
///
/// The drag surface sits behind [child] rather than around it, so buttons
/// and cards inside keep every click: a click that moves a couple of pixels
/// on a trackpad would otherwise start a window drag instead.
class WindowDragArea extends StatelessWidget {
  final Widget child;

  const WindowDragArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (!WindowChrome.hasHiddenTitleBar) return child;
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanStart: (_) => WindowChrome.startDragging(),
            onDoubleTap: WindowChrome.zoom,
          ),
        ),
        child,
      ],
    );
  }
}
