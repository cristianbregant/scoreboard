import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/core/routing/route_names.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/views/achievement/achievement_view.dart';
import 'package:flutter/material.dart';

RouteFactory onGenerateRoute = (settings) {
  if (settings.arguments == null) return null;

  final NavigatorArguments navigatorArguments =
      settings.arguments as NavigatorArguments;

  switch (settings.name) {
    case RouteNames.achievement:
      final Achievement item = navigatorArguments.nativeArgument;

      return MaterialPageRoute(
        fullscreenDialog: navigatorArguments.showAsFullScreenDialog,
        builder: (_) {
          return getIt<AchievementView>(param1: item);
        },
      );
  }

  return null;
};

class NavigatorArguments {
  final dynamic nativeArgument;
  final dynamic nativeArgument2;
  final bool showAsFullScreenDialog;

  const NavigatorArguments(
      {this.nativeArgument,
      this.nativeArgument2,
      this.showAsFullScreenDialog = false});
}
