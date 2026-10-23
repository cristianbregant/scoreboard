import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/views/views.dart';

void setupLocatorViews() {
  getIt.registerFactory<AchievementsView>(() => AchievementsView());
  getIt.registerFactory<BaseWindowView>(() => BaseWindowView());
  getIt.registerFactory<AuthView>(() => AuthView());
  getIt.registerFactory<FeedView>(() => FeedView());
  getIt.registerFactory<ConsoleView>(() => ConsoleView());
  getIt.registerFactory<SettingsView>(() => SettingsView());
  getIt.registerFactory<ProfileView>(() => ProfileView());
  getIt.registerFactory<CommunityView>(() => CommunityView());
  getIt.registerFactory<YourCompanyView>(() => YourCompanyView());
  getIt.registerFactory<BaseAchievementsView>(() => BaseAchievementsView());
  getIt.registerFactoryParam<AchievementView, Achievement, Object?>(
      (item, heroTag) => AchievementView(
            achievement: item,
            heroTag: heroTag,
          ));
}
