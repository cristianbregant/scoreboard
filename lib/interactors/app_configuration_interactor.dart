import 'package:flutter/material.dart';
import 'package:scoreboard/core/haptics.dart';
import 'package:scoreboard/services/package_info_service.dart';
import 'package:scoreboard/services/shared_preferences.dart';

class AppConfigurationInteractor {
  final SharedPreference _preferences;
  final PackageInfoService _packageInfo;

  AppConfigurationInteractor(this._preferences, this._packageInfo);

  ThemeMode getAppTheme() =>
      (_preferences.darkTheme ?? true) ? ThemeMode.dark : ThemeMode.light;

  Future<void> setAppTheme(ThemeMode mode) =>
      _preferences.setDarkTheme(mode == ThemeMode.dark);

  /// Chosen language, null to follow the system.
  Locale? getAppLocale() {
    final code = _preferences.languageCode;
    return code == null ? null : Locale(code);
  }

  Future<void> setAppLocale(Locale? locale) =>
      _preferences.setLanguageCode(locale?.languageCode);

  bool get isHapticsEnabled => _preferences.hapticsEnabled;

  /// Applies the stored choice; called once at startup.
  void loadHaptics() => Haptics.enabled = _preferences.hapticsEnabled;

  Future<void> setHapticsEnabled(bool enabled) {
    Haptics.enabled = enabled;
    return _preferences.setHapticsEnabled(enabled);
  }

  bool isOnboardingDone(String userId) => _preferences.onboardingDone(userId);

  Future<void> setOnboardingDone(String userId) =>
      _preferences.setOnboardingDone(userId);

  String get appName => _packageInfo.appName;
  String get appVersion =>
      '${_packageInfo.version} (${_packageInfo.buildNumber})';
}
