import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/app_configuration_interactor.dart';
import 'package:scoreboard/interactors/company_settings_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => UploadStatusProvider()),
  ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
  ChangeNotifierProvider(create: (_) => LocaleProvider()),
  ChangeNotifierProvider(create: (_) => BrandProvider()),
];

enum UploadStatus {
  notStarted,
  loading,
  completed,
  failed,
}

class UploadStatusProvider extends ChangeNotifier {
  UploadStatus commitAndroid = UploadStatus.notStarted;
  UploadStatus commitIOS = UploadStatus.notStarted;
  UploadStatus tagAndroid = UploadStatus.notStarted;
  UploadStatus tagIOS = UploadStatus.notStarted;
  String? androidTag;
  String? iosTag;
  UploadStatusProvider();

  void updateStatus({
    UploadStatus? commitAndroid,
    UploadStatus? commitIOS,
    UploadStatus? tagAndroid,
    UploadStatus? tagIOS,
  }) {
    this.commitAndroid = commitAndroid ?? this.commitAndroid;
    this.commitIOS = commitIOS ?? this.commitIOS;
    this.tagAndroid = tagAndroid ?? this.tagAndroid;
    this.tagIOS = tagIOS ?? this.tagIOS;
    notifyListeners();
  }

  void updateTags({String? androidTag, String? iosTag}) {
    this.androidTag = androidTag ?? this.androidTag;
    this.iosTag = iosTag ?? this.iosTag;
    notifyListeners();
  }

  void reset() {
    commitAndroid = UploadStatus.notStarted;
    commitIOS = UploadStatus.notStarted;
    tagAndroid = UploadStatus.notStarted;
    tagIOS = UploadStatus.notStarted;
    androidTag = null;
    iosTag = null;
    notifyListeners();
  }
}

class DarkThemeProvider extends ChangeNotifier {
  bool _darkTheme = true;

  getThemeAtInit() async {
    final interactor = getIt<AppConfigurationInteractor>();
    _darkTheme = interactor.getAppTheme() == ThemeMode.dark;
    notifyListeners();
  }

  DarkThemeProvider() {
    getThemeAtInit();
  }
  bool get darkTheme => _darkTheme;
  set darkTheme(bool value) {
    _darkTheme = value;
    getIt<AppConfigurationInteractor>()
        .setAppTheme(value ? ThemeMode.dark : ThemeMode.light);
    notifyListeners();
  }
}

/// Language chosen in the settings; null follows the system.
class LocaleProvider extends ChangeNotifier {
  Locale? _locale = getIt<AppConfigurationInteractor>().getAppLocale();

  Locale? get locale => _locale;
  set locale(Locale? value) {
    _locale = value;
    getIt<AppConfigurationInteractor>().setAppLocale(value);
    notifyListeners();
  }
}

/// The signed-in user's company look: its accent and logo, or Scoreboard's
/// own when it set none. Reloaded whenever the data or the session change.
class BrandProvider extends ChangeNotifier {
  final ScoreboardInteractor _scoreboard = getIt<ScoreboardInteractor>();
  int? _accentColor;
  String? _logoPath;

  BrandProvider() {
    _scoreboard.addListener(_load);
    _load();
  }

  int? get accentColor => _accentColor;
  String? get logoPath => _logoPath;

  Future<void> _load() async {
    try {
      final settings =
          await getIt<CompanySettingsInteractor>().currentSettings();
      if (settings?.accentColor == _accentColor &&
          settings?.logoPath == _logoPath) {
        return;
      }
      _accentColor = settings?.accentColor;
      _logoPath = settings?.logoPath;
      notifyListeners();
    } catch (_) {
      // Signed out mid-load: keep the current look.
    }
  }

  @override
  void dispose() {
    _scoreboard.removeListener(_load);
    super.dispose();
  }
}
