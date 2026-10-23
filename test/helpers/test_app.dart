import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:scoreboard/app/app.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/generated/l10n.dart';
import 'package:scoreboard/model/release.dart';
import 'package:scoreboard/services/mock_scoreboard_repository.dart';
import 'package:scoreboard/services/system_notification_service.dart';
import 'package:scoreboard/services/update_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String demoUserId = MockScoreboardRepository.demoUserId;
const String demoEmail = MockScoreboardRepository.demoEmail;
const String demoPassword = MockScoreboardRepository.demoPassword;

/// Records system notifications instead of showing them.
class FakeSystemNotifications extends SystemNotificationService {
  final List<({String title, String body})> shown = [];

  @override
  Future<void> show(String title, String body) async =>
      shown.add((title: title, body: body));
}

/// Answers with [release] (or throws [error]) instead of calling GitHub.
class FakeUpdateService extends UpdateService {
  ReleaseInfo? release;
  Object? error;
  int calls = 0;

  @override
  Future<ReleaseInfo?> latestRelease(String repository) async {
    calls++;
    if (error != null) throw error!;
    return release;
  }
}

/// Starting preferences: English, onboarding already seen.
Map<String, Object> basePrefs({bool signedIn = true}) => {
      'language_code': 'en',
      'onboarding_done_$demoUserId': true,
      if (signedIn) 'session_user_id': demoUserId,
    };

/// Builds the service locator as `main` does, on in-memory preferences,
/// a mock backend without latency and fake platform services.
///
/// Calling it again with the preferences of a previous run simulates an
/// app restart.
Future<void> setUpApp(
    {Map<String, Object>? prefs, String version = '1.0.0'}) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  SharedPreferences.setMockInitialValues(prefs ?? basePrefs());
  PackageInfo.setMockInitialValues(
      appName: 'Scoreboard',
      packageName: 'dev.scoreboard',
      version: version,
      buildNumber: '1',
      buildSignature: '');
  await getIt.reset();
  setupLocator(isTesting: true);
  await getIt.allReady();
  getIt.unregister<SystemNotificationService>();
  getIt.registerSingleton<SystemNotificationService>(FakeSystemNotifications());
  getIt.unregister<UpdateService>();
  getIt.registerSingleton<UpdateService>(FakeUpdateService());
  await AppLocalization.load(const Locale('en'));
}

/// Current preferences, to restart the app on the same data.
Future<Map<String, Object>> savedPrefs() async {
  final preferences = await SharedPreferences.getInstance();
  return {
    for (final key in preferences.getKeys()) key: preferences.get(key)!,
  };
}

FakeSystemNotifications get systemNotifications =>
    getIt<SystemNotificationService>() as FakeSystemNotifications;

FakeUpdateService get updateService =>
    getIt<UpdateService>() as FakeUpdateService;

/// English strings, matching what the app shows in widget tests.
AppLocalization get l10n => AppLocalization.current;

/// Pumps the whole app in a desktop-sized window.
Future<void> pumpApp(WidgetTester tester, {Map<String, Object>? prefs}) async {
  await tester.runAsync(() => setUpApp(prefs: prefs));
  tester.view.physicalSize = const Size(1400, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const CompanyAchievements());
  await settle(tester);
}

/// Lets the mock backend answer and animations finish. Unlike
/// `pumpAndSettle`, it doesn't wait forever on repeating animations.
Future<void> settle(WidgetTester tester, {int frames = 12}) async {
  for (var i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Pumps [child] alone in a localized English app, for component tests.
Future<void> pumpInApp(WidgetTester tester, Widget child) async {
  await initializeDateFormatting();
  await AppLocalization.load(const Locale('en'));
  tester.view.physicalSize = const Size(1400, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(MaterialApp(
    localizationsDelegates: const [
      AppLocalization.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalization.delegate.supportedLocales,
    locale: const Locale('en'),
    home: Scaffold(body: Center(child: child)),
  ));
}
