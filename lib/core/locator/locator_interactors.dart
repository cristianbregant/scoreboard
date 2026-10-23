import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/interactors.dart';
import 'package:scoreboard/services/file_picker_service.dart';
import 'package:scoreboard/services/image_storage_service.dart';
import 'package:scoreboard/services/package_info_service.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';
import 'package:scoreboard/services/share_service.dart';
import 'package:scoreboard/services/shared_preferences.dart';

void setupLocatorInteractors() {
  getIt.registerFactory<AppConfigurationInteractor>(() =>
      AppConfigurationInteractor(
          getIt<SharedPreference>(), getIt<PackageInfoService>()));
  getIt.registerLazySingleton<ScoreboardInteractor>(() => ScoreboardInteractor(
      getIt<ScoreboardRepository>(),
      getIt<FilePickerService>(),
      getIt<ImageStorageService>()));
  getIt.registerFactory<AuthInteractor>(
      () => AuthInteractor(getIt<ScoreboardRepository>()));
  getIt.registerFactory<ShareInteractor>(
      () => ShareInteractor(getIt<ShareService>()));
}
