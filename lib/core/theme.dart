import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeDeployerColors {
  static const Color sidebarBackgroundColor = Color(0xFF1e293b);
  static const Color primaryColor = Color(0xFF2563eb);
  static const Color secondaryColor = Color(0xFF598EF3);
  static const Color tertiaryColor = Color(0xFF475569);
  static const Color backgroundColor = Color(0xFF334155);
}

class WelcomeDeployerTheme {
  static ThemeData themeDataLight = ThemeData(
    fontFamily: GoogleFonts.ptSansCaption().fontFamily,
    colorScheme: const ColorScheme.light(
      primary: WelcomeDeployerColors.primaryColor,
      secondary: WelcomeDeployerColors.secondaryColor,
      background: WelcomeDeployerColors.backgroundColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData themeDataDark = ThemeData(
    fontFamily: GoogleFonts.ptSansCaption().fontFamily,
    colorScheme: const ColorScheme.dark(
        primary: WelcomeDeployerColors.primaryColor,
        secondary: WelcomeDeployerColors.secondaryColor,
        background: WelcomeDeployerColors.backgroundColor),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
