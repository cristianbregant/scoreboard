import 'package:scoreboard/views/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/core/routing/route_names.dart';
import 'package:scoreboard/views/base_window/base_window_view.dart';
import 'package:scoreboard/views/achievements/achievements_view.dart';

Map<String, WidgetBuilder> staticRoutes = {
  RouteNames.baseWindow: (context) => getIt<BaseWindowView>(),
  RouteNames.home: (context) => getIt<AchievementsView>(),
  RouteNames.settings: (context) => getIt<SettingsView>(),
};
