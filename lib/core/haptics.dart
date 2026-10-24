import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// The feedback patterns macOS offers (`NSHapticFeedbackManager`).
enum HapticPattern {
  /// A plain tick, e.g. a reaction toggled.
  generic,

  /// Something snapping into place, e.g. a card landing on its other side.
  alignment,

  /// A step up, e.g. an achievement sent or approved.
  levelChange,
}

/// Haptic feedback, where the hardware has it.
///
/// On macOS it plays on a Force Touch trackpad, and is felt only while a
/// finger rests on it, which is the case right after a click. Flutter
/// doesn't bridge it there, so the runner answers [_channel]
/// (MainFlutterWindow.swift). On iOS and Android it maps to
/// [HapticFeedback]. Windows and Linux have no equivalent: nothing happens.
class Haptics {
  static const MethodChannel _channel = MethodChannel('scoreboard/haptics');

  /// The user's choice in Settings, loaded at startup.
  static bool enabled = true;

  static bool get isSupported => switch (defaultTargetPlatform) {
        TargetPlatform.macOS ||
        TargetPlatform.iOS ||
        TargetPlatform.android =>
          true,
        _ => false,
      };

  static Future<void> tap() => perform(HapticPattern.generic);

  static Future<void> snap() => perform(HapticPattern.alignment);

  static Future<void> success() => perform(HapticPattern.levelChange);

  /// Never throws: feedback is a nicety, and a missing handler (tests,
  /// unsupported hardware) must not break the action it accompanies.
  static Future<void> perform(HapticPattern pattern) async {
    if (!enabled || !isSupported) return;
    try {
      switch (defaultTargetPlatform) {
        case TargetPlatform.macOS:
          await _channel.invokeMethod<void>('perform', pattern.name);
        default:
          await switch (pattern) {
            HapticPattern.generic => HapticFeedback.selectionClick(),
            HapticPattern.alignment => HapticFeedback.lightImpact(),
            HapticPattern.levelChange => HapticFeedback.mediumImpact(),
          };
      }
    } on PlatformException catch (_) {
    } on MissingPluginException catch (_) {}
  }
}
