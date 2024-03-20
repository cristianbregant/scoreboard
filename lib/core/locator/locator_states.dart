import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/views/view_contracts.dart';

void setupLocatorStates() {
  getIt.registerFactory<AchievementsState>(() => AchievementsState());
  getIt.registerFactory<BaseWindowState>(() => BaseWindowState());
  getIt.registerFactory<SettingsState>(() => SettingsState());
  getIt.registerFactory<AchievementState>(() => AchievementState());
  getIt.registerFactory<ProfileState>(() => ProfileState());
  getIt.registerFactory<CommunityState>(() => CommunityState());
  getIt.registerFactory<YourCompanyState>(() => YourCompanyState());
}
