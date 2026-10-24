import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/window_chrome.dart';

import '../helpers/test_app.dart';

void main() {
  const channel = MethodChannel('scoreboard/window');
  late List<String> calls;
  late int pressed;

  Future<void> pump(WidgetTester tester) async {
    calls = [];
    pressed = 0;
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel,
        (call) async {
      calls.add(call.method);
      return null;
    });
    addTearDown(() {
      debugDefaultTargetPlatformOverride = null;
      tester.binding.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });
    await pumpInApp(
        tester,
        SizedBox(
          width: 600,
          height: 60,
          child: WindowDragArea(
            child: Row(
              children: [
                IconButton(
                  tooltip: 'Back',
                  onPressed: () => pressed++,
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),
          ),
        ));
  }

  testWidgets('a click that wiggles on a button presses it, never drags',
      (tester) async {
    await pump(tester);
    // A physical trackpad click often moves a few pixels.
    final gesture = await tester.startGesture(
        tester.getCenter(find.byTooltip('Back')),
        kind: PointerDeviceKind.mouse);
    await gesture.moveBy(const Offset(4, 2));
    await gesture.up();
    await tester.pump(const Duration(milliseconds: 400));
    expect(pressed, 1);
    expect(calls, isEmpty);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('dragging the empty space moves the window', (tester) async {
    await pump(tester);
    final empty =
        tester.getTopRight(find.byType(WindowDragArea)) + const Offset(-40, 30);
    await tester.dragFrom(empty, const Offset(80, 0),
        kind: PointerDeviceKind.mouse);
    await tester.pump(const Duration(milliseconds: 400));
    expect(calls, ['startDragging']);
    expect(pressed, 0);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('double-clicking the empty space zooms the window',
      (tester) async {
    await pump(tester);
    final empty =
        tester.getTopRight(find.byType(WindowDragArea)) + const Offset(-40, 30);
    await tester.tapAt(empty, kind: PointerDeviceKind.mouse);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tapAt(empty, kind: PointerDeviceKind.mouse);
    await tester.pump(const Duration(milliseconds: 400));
    expect(calls, ['zoom']);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('without a hidden title bar there is nothing to drag',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
    await pumpInApp(tester, const WindowDragArea(child: Text('Title')));
    expect(find.byType(GestureDetector), findsNothing);
    debugDefaultTargetPlatformOverride = null;
  });
}
