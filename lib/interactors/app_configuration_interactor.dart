import 'package:flutter/material.dart';
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

  String get appName => _packageInfo.appName;
  String get appVersion =>
      '${_packageInfo.version} (${_packageInfo.buildNumber})';
}
