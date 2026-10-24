import 'package:scoreboard/core/app_navigation.dart';
import 'package:scoreboard/core/constants.dart';
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
      getIt<UpdateInteractor>(),
      getIt<AdminInteractor>(),
      getIt<TeamInteractor>(),
      refreshInterval:
          Constants.apiUrl.isEmpty ? null : const Duration(seconds: 30)));

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
      YourCompanyViewModel(getIt<ScoreboardInteractor>(),
          getIt<AdminInteractor>(), getIt<SeasonInteractor>()));

  getIt.registerFactory<BaseAchievementsViewModelContract>(
      () => BaseAchievementsViewModel(getIt<ScoreboardInteractor>()));

  getIt.registerFactory<AuthViewModelContract>(
      () => AuthViewModel(getIt<AuthInteractor>()));
  getIt.registerFactory<FeedViewModelContract>(() =>
      FeedViewModel(getIt<FeedInteractor>(), getIt<ScoreboardInteractor>()));
  getIt.registerFactory<ConsoleViewModelContract>(() => ConsoleViewModel(
      getIt<AdminInteractor>(),
      getIt<ScoreboardInteractor>(),
      getIt<AppNavigation>()));
  getIt.registerFactory<TeamViewModelContract>(() => TeamViewModel(
      getIt<TeamInteractor>(),
      getIt<AdminInteractor>(),
      getIt<ScoreboardInteractor>()));
  getIt.registerFactory<MembersAdminViewModelContract>(() =>
      MembersAdminViewModel(
          getIt<MemberInteractor>(), getIt<ScoreboardInteractor>()));
  getIt.registerFactory<TeamsAdminViewModelContract>(() => TeamsAdminViewModel(
      getIt<TeamInteractor>(), getIt<ScoreboardInteractor>()));
  getIt.registerFactory<SeasonsAdminViewModelContract>(() =>
      SeasonsAdminViewModel(
          getIt<SeasonInteractor>(), getIt<ScoreboardInteractor>()));
  getIt.registerFactory<ReportsViewModelContract>(() => ReportsViewModel(
      getIt<ReportInteractor>(), getIt<ScoreboardInteractor>()));
  getIt.registerFactory<ActivityViewModelContract>(() => ActivityViewModel(
      getIt<ActivityInteractor>(), getIt<ScoreboardInteractor>()));
  getIt.registerFactory<CompanySettingsViewModelContract>(() =>
      CompanySettingsViewModel(
          getIt<CompanySettingsInteractor>(), getIt<ScoreboardInteractor>()));
}
