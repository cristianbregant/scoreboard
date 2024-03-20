import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/views/view_contracts.dart';
import 'package:scoreboard/views/view_models.dart';

void setupLocatorViewModels() {
  getIt.registerFactory<AchievementsViewModelContract>(
      () => AchievementsViewModel(
          // getIt<CommandsInteractor>(),
          // getIt<ProjectsInteractors>(),
          // getIt<DocumentationInteractor>(),
          ));

  getIt.registerFactory<BaseWindowViewModelContract>(
      () => BaseWindowViewModel());

  getIt.registerFactory<SettingsViewModelContract>(() => SettingsViewModel());

  getIt.registerFactory<AchievementViewModelContract>(
      () => AchievementViewModel());

  getIt.registerFactory<ProfileViewModelContract>(() => ProfileViewModel());

  getIt.registerFactory<CommunityViewModelContract>(() => CommunityViewModel());

  getIt.registerFactory<YourCompanyViewModelContract>(
      () => YourCompanyViewModel());
}
