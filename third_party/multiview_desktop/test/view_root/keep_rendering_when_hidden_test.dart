import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multiview_desktop/src/view_root.dart';

/// Stands in for the root of the views: registered before the text fields,
/// it reacts to `hidden` with [react].
class _Root with WidgetsBindingObserver {
  _Root(this.react);

  final void Function(AppLifecycleState state) react;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) => react(state);
}

/// A lifecycle message from the engine. The framework fills in the steps
/// between the current state and [state], as it does in the app.
Future<void> engine(AppLifecycleState state) =>
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.handlePlatformMessage(
      SystemChannels.lifecycle.name,
      SystemChannels.lifecycle.codec.encodeMessage(state.toString()),
      (_) {},
    );

void main() {
  /// Hides the window, as closing it to the tray does, then shows it again.
  /// [react] is how the root answers `hidden`. Returns what the listener saw,
  /// and the state while the window was hidden.
  Future<(List<String>, AppLifecycleState?)> hideAndShow(
    WidgetTester tester,
    void Function(AppLifecycleState) react,
  ) async {
    final binding = tester.binding;
    binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    final root = _Root(react);
    binding.addObserver(root);
    final seen = <String>[];
    // Like the one of every TextField, registered after the root.
    final listener = AppLifecycleListener(onStateChange: (state) => seen.add(state.name));
    addTearDown(() {
      listener.dispose();
      binding.removeObserver(root);
    });

    await engine(AppLifecycleState.hidden);
    await tester.pump();
    final whileHidden = binding.lifecycleState;
    // Shown again.
    await engine(AppLifecycleState.resumed);
    return (seen, whileHidden);
  }

  testWidgets('re-emitting inactive right away breaks the listeners', (tester) async {
    // The original code: inactive emitted inside the dispatch of hidden.
    void original(AppLifecycleState state) {
      if (state != AppLifecycleState.hidden) return;
      // ignore: invalid_use_of_protected_member
      SchedulerBinding.instance.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    }

    final (seen, _) = await hideAndShow(tester, original);
    // The framework reports the failed assertion, as in the app's console,
    // and the listener never hears that the app resumed.
    final error = tester.takeException();
    expect(
      error,
      isA<AssertionError>().having(
        (e) => e.message,
        'message',
        contains('Invalid state transition from AppLifecycleState.hidden to AppLifecycleState.resumed'),
      ),
    );
    expect(seen, ['inactive', 'hidden']);
  });

  testWidgets('keepRenderingWhenHidden keeps every transition valid', (tester) async {
    final (seen, whileHidden) = await hideAndShow(
      tester,
      (state) => keepRenderingWhenHidden(state, hasWindows: () => true),
    );
    // Back to inactive while hidden, so the engine keeps drawing frames.
    expect(whileHidden, AppLifecycleState.inactive);
    expect(seen, ['inactive', 'hidden', 'inactive', 'resumed']);
    expect(tester.binding.lifecycleState, AppLifecycleState.resumed);
  });

  testWidgets('without windows left, hidden stays hidden', (tester) async {
    final (seen, whileHidden) = await hideAndShow(
      tester,
      (state) => keepRenderingWhenHidden(state, hasWindows: () => false),
    );
    expect(whileHidden, AppLifecycleState.hidden);
    expect(seen, ['inactive', 'hidden', 'inactive', 'resumed']);
  });
}
