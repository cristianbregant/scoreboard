import 'package:package_info_plus/package_info_plus.dart';
import 'package:scoreboard/core/app_navigation.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/services/desktop_shell_service.dart';
import 'package:scoreboard/services/file_picker_service.dart';
import 'package:scoreboard/services/image_storage_service.dart';
import 'package:scoreboard/services/mock_scoreboard_repository.dart';
import 'package:scoreboard/services/package_info_service.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';
import 'package:scoreboard/services/share_service.dart';
import 'package:scoreboard/services/system_notification_service.dart';
import 'package:scoreboard/services/update_service.dart';
import 'package:scoreboard/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setupLocatorObjects() {
  getIt.registerSingletonAsync<SharedPreference>(
      () async => SharedPreference(await SharedPreferences.getInstance()));
  getIt.registerSingletonAsync<PackageInfoService>(
      () async => PackageInfoService(await PackageInfo.fromPlatform()));
  getIt.registerSingletonWithDependencies<ScoreboardRepository>(
      () => MockScoreboardRepository(getIt<SharedPreference>()),
      dependsOn: [SharedPreference]);
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
