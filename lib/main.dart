import 'package:multiview_desktop/multiview_desktop.dart';
import 'package:scoreboard/app/app.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/core/window_chrome.dart';
import 'package:scoreboard/interactors/app_configuration_interactor.dart';
import 'package:scoreboard/services/desktop_shell_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['Inter'], license);
  });
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/Geist-OFL.txt');
    yield LicenseEntryWithLineBreaks(['Geist'], license);
  });
  // Date formats for every locale, also outside widgets (e.g. PDFs).
  await initializeDateFormatting();
  setupLocator();
  await getIt.allReady();
  getIt<AppConfigurationInteractor>().loadHaptics();
  final shell = getIt<DesktopShellService>();
  await shell.init();

  // multiview_desktop counts the hidden title bar in the height, so the
  // window opens larger than the minimum to show every page at once.
  const size = Size(1100, 720);
  const minimumSize = Size(1000, 600);
  // One engine for every OS window (multiview_desktop); the app has one.
  runMultiApp(
    home: (context, windowId) {
      shell.attachMainWindow(windowId);
      return const CompanyAchievements();
    },
    config: MultiAppConfig(
      mainWindowOptions: WindowOptions(
        size: size,
        minimumSize: minimumSize,
        alignment: Alignment.center,
        // Transparent only where the content draws under the title bar.
        backgroundColor:
            WindowChrome.hasHiddenTitleBar ? Colors.transparent : null,
        title: 'Scoreboard',
        titleBarStyle: WindowChrome.titleBarStyle,
        // Required with titleBarStyle: multiview_desktop 2.0.2 null-checks it.
        windowButtonVisibility: true,
      ),
      macosParams: MacosPlatformParams(
        // ⌘Q and Quit in the app menu: the window stops hiding to the tray.
        onTerminate: () async {
          shell.prepareToQuit();
          return true;
        },
      ),
    ),
  );
}
