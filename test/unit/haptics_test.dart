import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/haptics.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/app_configuration_interactor.dart';

import '../helpers/test_app.dart';

const _channel = MethodChannel('scoreboard/haptics');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  late List<String?> played;

  setUp(() {
    played = [];
    Haptics.enabled = true;
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    messenger.setMockMethodCallHandler(_channel, (call) async {
      played.add(call.arguments as String?);
      return null;
    });
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    messenger.setMockMethodCallHandler(_channel, null);
  });

  test('on macOS each kind maps to its trackpad pattern', () async {
    await Haptics.tap();
    await Haptics.snap();
    await Haptics.success();
    expect(played, ['generic', 'alignment', 'levelChange']);
  });

  test('nothing plays when turned off', () async {
    Haptics.enabled = false;
    await Haptics.snap();
    expect(played, isEmpty);
  });

  test('Windows and Linux have no haptics', () async {
    for (final platform in [TargetPlatform.windows, TargetPlatform.linux]) {
      debugDefaultTargetPlatformOverride = platform;
      expect(Haptics.isSupported, isFalse);
      await Haptics.snap();
    }
    expect(played, isEmpty);
  });

  test('a missing native handler never breaks the caller', () async {
    messenger.setMockMethodCallHandler(_channel, null);
    await expectLater(Haptics.success(), completes);
    messenger.setMockMethodCallHandler(
        _channel, (_) async => throw PlatformException(code: 'nope'));
    await expectLater(Haptics.success(), completes);
  });

  test('the choice is stored and applied at startup', () async {
    await setUpApp();
    final configuration = getIt<AppConfigurationInteractor>();
    expect(configuration.isHapticsEnabled, isTrue);

    await configuration.setHapticsEnabled(false);
    expect(Haptics.enabled, isFalse);

    Haptics.enabled = true;
    await setUpApp(prefs: await savedPrefs());
    getIt<AppConfigurationInteractor>().loadHaptics();
    expect(Haptics.enabled, isFalse);
  });
}
