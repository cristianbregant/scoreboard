import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Keyboard shortcuts use ⌘ on macOS and Ctrl elsewhere.
class AppShortcuts {
  static bool get _isMac => defaultTargetPlatform == TargetPlatform.macOS;

  static SingleActivator primary(LogicalKeyboardKey key,
          {bool shift = false}) =>
      SingleActivator(key, meta: _isMac, control: !_isMac, shift: shift);

  static String label(String key, {bool shift = false}) =>
      _isMac ? '⌘${shift ? '⇧' : ''}$key' : 'Ctrl+${shift ? 'Shift+' : ''}$key';

  static final quickSend = primary(LogicalKeyboardKey.keyK);
  static final notifications = primary(LogicalKeyboardKey.keyN, shift: true);
  static final settings = primary(LogicalKeyboardKey.comma);

  static const List<LogicalKeyboardKey> pageKeys = [
    LogicalKeyboardKey.digit1,
    LogicalKeyboardKey.digit2,
    LogicalKeyboardKey.digit3,
    LogicalKeyboardKey.digit4,
    LogicalKeyboardKey.digit5,
    LogicalKeyboardKey.digit6,
    LogicalKeyboardKey.digit7,
    LogicalKeyboardKey.digit8,
  ];

  static String get quickSendLabel => label('K');
  static String get notificationsLabel => label('N', shift: true);
  static String get settingsLabel => label(',');
  static String get pagesLabel => label('1…8');
}
