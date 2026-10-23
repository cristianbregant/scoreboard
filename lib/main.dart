import 'package:scoreboard/app/app.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/core/window_chrome.dart';
import 'package:scoreboard/services/desktop_shell_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['Inter'], license);
  });
  // Must add this line.
  await windowManager.ensureInitialized();

  const size = Size(1000, 600);
  WindowOptions windowOptions = WindowOptions(
    size: size,
    minimumSize: size,
    center: true,
    // Transparent only where the content draws under the title bar.
    backgroundColor: WindowChrome.hasHiddenTitleBar ? Colors.transparent : null,
    skipTaskbar: false,
    title: 'Scoreboard',
    titleBarStyle: WindowChrome.titleBarStyle,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  // Date formats for every locale, also outside widgets (e.g. PDFs).
  await initializeDateFormatting();
  setupLocator();
  await getIt.allReady();
  await getIt<DesktopShellService>().init();
  runApp(const CompanyAchievements());
}
