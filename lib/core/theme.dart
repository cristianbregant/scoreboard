import 'package:flutter/material.dart';

class AppColors {
  /// Accent: a warm gold that reads as "trophy". The light theme uses a
  /// darker shade so text and icons keep enough contrast on white.
  static const Color accentDark = Color(0xFFE9B949);
  static const Color accentLight = Color(0xFF9A6A12);
  static const Color success = Color(0xFF4CA36A);
  static const Color verified = Color(0xFF4A9FD8);

  // Dark palette: neutral graphite.
  static const Color darkBackground = Color(0xFF0E0F11);
  static const Color darkSidebar = Color(0xFF131417);
  static const Color darkSurface = Color(0xFF18191D);
  static const Color darkSurfaceHigh = Color(0xFF212328);
  static const Color darkBorder = Color(0xFF2A2C32);
  static const Color darkMuted = Color(0xFF8C9099);

  // Light palette: warm paper.
  static const Color lightBackground = Color(0xFFF6F5F2);
  static const Color lightSidebar = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceHigh = Color(0xFFEFEDE8);
  static const Color lightBorder = Color(0xFFE3E0D9);
  static const Color lightMuted = Color(0xFF6E6B65);
}

class AppTheme {
  static const double radius = 16;

  static ThemeData themeDataLight = _build(
    brightness: Brightness.light,
    primary: AppColors.accentLight,
    onPrimary: Colors.white,
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    surfaceHigh: AppColors.lightSurfaceHigh,
    sidebar: AppColors.lightSidebar,
    border: AppColors.lightBorder,
    onSurface: const Color(0xFF1A1A19),
    muted: AppColors.lightMuted,
  );

  static ThemeData themeDataDark = _build(
    brightness: Brightness.dark,
    primary: AppColors.accentDark,
    onPrimary: const Color(0xFF1C1505),
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    surfaceHigh: AppColors.darkSurfaceHigh,
    sidebar: AppColors.darkSidebar,
    border: AppColors.darkBorder,
    onSurface: const Color(0xFFECEDEF),
    muted: AppColors.darkMuted,
  );

  /// Color roles used across the app:
  /// - surface: page background
  /// - surfaceContainerLow: sidebar
  /// - surfaceContainer: cards and panels
  /// - surfaceContainerHighest: inputs, chips, nested elements
  /// - outlineVariant: hairline borders
  /// - onSurfaceVariant: secondary text
  static ThemeData _build({
    required Brightness brightness,
    required Color primary,
    required Color onPrimary,
    required Color background,
    required Color surface,
    required Color surfaceHigh,
    required Color sidebar,
    required Color border,
    required Color onSurface,
    required Color muted,
  }) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primary.withValues(alpha: 0.16),
      onPrimaryContainer: primary,
      secondary: primary,
      onSecondary: onPrimary,
      // Tonal buttons and selected chips: a tint of the brand color.
      secondaryContainer:
          Color.alphaBlend(primary.withValues(alpha: 0.16), surface),
      onSecondaryContainer: primary,
      error: const Color(0xFFEF4444),
      onError: Colors.white,
      surface: background,
      onSurface: onSurface,
      onSurfaceVariant: muted,
      surfaceContainerLow: sidebar,
      surfaceContainer: surface,
      surfaceContainerHighest: surfaceHigh,
      outline: muted,
      outlineVariant: border,
    );
    final rounded = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius * 0.75));
    final baseTextTheme = ThemeData(brightness: brightness).textTheme;

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      fontFamily: 'Inter',
      textTheme: baseTextTheme.apply(
          fontFamily: 'Inter', bodyColor: onSurface, displayColor: onSurface),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      splashFactory: InkSparkle.splashFactory,
      dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: border),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: rounded,
        iconColor: muted,
        selectedColor: primary,
        selectedTileColor: primary.withValues(alpha: 0.12),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceHigh,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius * 0.75),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius * 0.75),
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
        prefixIconColor: muted,
        hintStyle: TextStyle(color: muted),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: rounded,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          shape: rounded,
          side: BorderSide(color: border),
          selectedBackgroundColor: primary.withValues(alpha: 0.16),
          selectedForegroundColor: primary,
        ),
      ),
      chipTheme: ChipThemeData(
        shape: StadiumBorder(side: BorderSide(color: border)),
        backgroundColor: surface,
        selectedColor: primary.withValues(alpha: 0.16),
        side: BorderSide(color: border),
        showCheckmark: false,
        secondaryLabelStyle:
            TextStyle(color: primary, fontWeight: FontWeight.w600),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? Colors.white : muted),
        trackColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? primary : surfaceHigh),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: rounded,
        width: 360,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: onSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(color: background, fontSize: 12),
      ),
    );
  }
}
