import 'package:scoreboard/app/app.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  const size = Size(1000, 600);
  WindowOptions windowOptions = const WindowOptions(
    size: size,
    minimumSize: size,
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  setupLocator();
  runApp(const CompanyAchievements());
}
