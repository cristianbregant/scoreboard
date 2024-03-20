import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
// import 'package:scoreboard/core/locator/locator.dart';
// import 'package:scoreboard/interactors/app_configuration_interactor.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => UploadStatusProvider()),
  ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
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
    // final interactor = getIt<AppConfigurationInteractor>();
    // final storedTheme = interactor.getAppTheme();

    // if (storedTheme == ThemeMode.dark) {
    //   _darkTheme = true;
    // } else {
    //   _darkTheme = false;
    // }
    notifyListeners();
  }

  DarkThemeProvider() {
    getThemeAtInit();
  }
  bool get darkTheme => _darkTheme;
  set darkTheme(bool value) {
    _darkTheme = value;
    notifyListeners();
  }
}
