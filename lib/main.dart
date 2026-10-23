import 'package:scoreboard/app/app.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/core/window_chrome.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  setupLocator();
  await getIt.allReady();
  runApp(const CompanyAchievements());
}
