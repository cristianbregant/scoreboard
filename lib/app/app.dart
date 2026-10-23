import 'package:provider/provider.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/core/providers.dart';
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
    return MultiProvider(
      providers: providers,
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp(
          title: 'Scoreboard',
          theme: AppTheme.themeDataLight,
          darkTheme: AppTheme.themeDataDark,
          themeMode: themeProvider.darkTheme ? ThemeMode.dark : ThemeMode.light,
          initialRoute: getIt<AuthInteractor>().isSignedIn
              ? RouteNames.baseWindow
              : RouteNames.auth,
          routes: staticRoutes,
          onGenerateRoute: onGenerateRoute,
          localizationsDelegates: const [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalization.delegate.supportedLocales,
        ),
      ),
    );
  }
}
