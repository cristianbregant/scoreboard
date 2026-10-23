import 'package:scoreboard/core/app_navigation.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/interactors.dart';
import 'package:scoreboard/views/view_contracts.dart';
import 'package:scoreboard/views/view_models.dart';

void setupLocatorViewModels() {
  getIt.registerFactory<AchievementsViewModelContract>(() =>
      AchievementsViewModel(
          getIt<ScoreboardInteractor>(), getIt<AppNavigation>()));

  getIt.registerFactory<BaseWindowViewModelContract>(() => BaseWindowViewModel(
      getIt<ScoreboardInteractor>(),
      getIt<NotificationInteractor>(),
      getIt<AppNavigation>(),
      getIt<AppConfigurationInteractor>(),
      getIt<UpdateInteractor>()));

  getIt.registerFactory<SettingsViewModelContract>(() => SettingsViewModel(
      getIt<ScoreboardInteractor>(),
      getIt<AuthInteractor>(),
      getIt<AppConfigurationInteractor>(),
      getIt<UpdateInteractor>()));

  getIt.registerFactory<AchievementViewModelContract>(() =>
      AchievementViewModel(getIt<ShareInteractor>(),
          getIt<CredentialInteractor>(), getIt<ScoreboardInteractor>()));

  getIt.registerFactory<ProfileViewModelContract>(
      () => ProfileViewModel(getIt<ScoreboardInteractor>()));

  getIt.registerFactory<CommunityViewModelContract>(
      () => CommunityViewModel(getIt<ScoreboardInteractor>()));

  getIt.registerFactory<YourCompanyViewModelContract>(() =>
      YourCompanyViewModel(
          getIt<ScoreboardInteractor>(), getIt<AdminInteractor>()));

  getIt.registerFactory<BaseAchievementsViewModelContract>(
      () => BaseAchievementsViewModel(getIt<ScoreboardInteractor>()));

  getIt.registerFactory<AuthViewModelContract>(
      () => AuthViewModel(getIt<AuthInteractor>()));
  getIt.registerFactory<FeedViewModelContract>(() =>
      FeedViewModel(getIt<FeedInteractor>(), getIt<ScoreboardInteractor>()));
  getIt.registerFactory<ConsoleViewModelContract>(() => ConsoleViewModel(
      getIt<AdminInteractor>(), getIt<ScoreboardInteractor>()));
}
