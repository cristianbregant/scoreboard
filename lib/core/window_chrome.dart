import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:window_manager/window_manager.dart';

/// Per-platform window frame.
///
/// On macOS the title bar is hidden and the content extends under it, next
/// to the traffic lights. Windows and Linux keep the native title bar, which
/// holds the minimize/maximize/close buttons, so no inset is needed there.
class WindowChrome {
  static bool get hasHiddenTitleBar =>
      defaultTargetPlatform == TargetPlatform.macOS;

  static TitleBarStyle get titleBarStyle =>
      hasHiddenTitleBar ? TitleBarStyle.hidden : TitleBarStyle.normal;

  /// Height covered by the macOS traffic lights.
  static double get topInset => hasHiddenTitleBar ? 28 : 0;

  /// Width covered by the macOS traffic lights.
  static double get leadingInset => hasHiddenTitleBar ? 68 : 0;
}

/// Lets the user move the window by dragging [child] when there is no
/// title bar to drag; elsewhere it just shows [child].
class WindowDragArea extends StatelessWidget {
  final Widget child;

  const WindowDragArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) =>
      WindowChrome.hasHiddenTitleBar ? DragToMoveArea(child: child) : child;
}
