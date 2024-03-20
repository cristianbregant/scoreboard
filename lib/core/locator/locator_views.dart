import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/views/views.dart';

void setupLocatorViews() {
  getIt.registerFactory<AchievementsView>(() => AchievementsView());
  getIt.registerFactory<BaseWindowView>(() => BaseWindowView());
  getIt.registerFactory<SettingsView>(() => SettingsView());
  getIt.registerFactory<ProfileView>(() => ProfileView());
  getIt.registerFactory<CommunityView>(() => CommunityView());
  getIt.registerFactory<YourCompanyView>(() => YourCompanyView());
  getIt.registerFactoryParam<AchievementView, Achievement, void>(
      (item, _) => AchievementView(
            achievement: item,
          ));
}
