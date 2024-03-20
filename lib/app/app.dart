import 'package:scoreboard/core/routing/dynamic_routes.dart';
import 'package:scoreboard/core/routing/route_names.dart';
import 'package:scoreboard/core/routing/static_routes.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CompanyAchievements extends StatelessWidget {
  const CompanyAchievements({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D Interactive Gold Cards',
      theme: WelcomeDeployerTheme.themeDataDark,
      initialRoute: RouteNames.baseWindow,
      routes: staticRoutes,
      onGenerateRoute: onGenerateRoute,
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalization.delegate.supportedLocales,
    );
  }
}
