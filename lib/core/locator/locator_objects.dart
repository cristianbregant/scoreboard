import 'package:package_info_plus/package_info_plus.dart';
import 'package:scoreboard/api/api_client.dart';
import 'package:scoreboard/core/constants.dart';
import 'package:scoreboard/core/app_navigation.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/services/desktop_shell_service.dart';
import 'package:scoreboard/services/file_picker_service.dart';
import 'package:scoreboard/services/image_storage_service.dart';
import 'package:scoreboard/services/mock_scoreboard_repository.dart';
import 'package:scoreboard/services/package_info_service.dart';
import 'package:scoreboard/services/rest_scoreboard_repository.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';
import 'package:scoreboard/services/share_service.dart';
import 'package:scoreboard/services/system_notification_service.dart';
import 'package:scoreboard/services/update_service.dart';
import 'package:scoreboard/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setupLocatorObjects({bool isTesting = false}) {
  getIt.registerSingletonAsync<SharedPreference>(
      () async => SharedPreference(await SharedPreferences.getInstance()));
  getIt.registerSingletonAsync<PackageInfoService>(
      () async => PackageInfoService(await PackageInfo.fromPlatform()));
  // The real backend when the app is started with SCOREBOARD_API_URL,
  // otherwise the local mock (always in tests).
  getIt.registerSingletonWithDependencies<ScoreboardRepository>(() {
    final preferences = getIt<SharedPreference>();
    if (Constants.apiUrl.isNotEmpty && !isTesting) {
      return RestScoreboardRepository(
          ApiClient(
              baseUrl: Constants.apiUrl, token: () => preferences.sessionToken),
          preferences);
    }
    return MockScoreboardRepository(preferences,
        latency: isTesting ? Duration.zero : const Duration(milliseconds: 300));
  }, dependsOn: [SharedPreference]);
  getIt.registerSingleton<FilePickerService>(FilePickerService());
  getIt.registerSingleton<ImageStorageService>(ImageStorageService());
  getIt.registerSingleton<ShareService>(ShareService());
  getIt.registerSingleton<SystemNotificationService>(
      SystemNotificationService());
  getIt.registerSingleton<AppNavigation>(AppNavigation());
  getIt.registerSingleton<DesktopShellService>(
      DesktopShellService(getIt<AppNavigation>()));
  getIt.registerSingleton<UpdateService>(UpdateService());
}
