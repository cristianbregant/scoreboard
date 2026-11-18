import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:scoreboard/app/app.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/app_configuration_interactor.dart';
import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/services/sso_service_web.dart';

/// The browser version of Scoreboard: the same app, without the desktop
/// window, tray and local files. Build it with
/// `flutter build web -t lib/main_web.dart --dart-define=SCOREBOARD_API_URL=…`.
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
  await initializeDateFormatting();
  setupLocator();
  await getIt.allReady();
  getIt<AppConfigurationInteractor>().loadHaptics();

  // Back from single sign-on: sign in before the first screen is chosen.
  if (consumeRedirect() case final result?) {
    await getIt<AuthInteractor>().finishSsoRedirect(result);
  }
  runApp(const CompanyAchievements());
}
