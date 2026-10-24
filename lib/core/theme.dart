import 'dart:math' as math;

import 'package:flutter/material.dart';

class AppColors {
  /// Accent: a warm gold that reads as "trophy". The light theme uses a
  /// darker shade so text keeps a 4.5:1 contrast (WCAG AA) even on the
  /// gold-tinted backgrounds of selected items.
  static const Color accentDark = Color(0xFFE9B949);
  static const Color accentLight = Color(0xFF805509);

  /// Admin mode: steel blue instead of gold, so managing the company never
  /// looks like using the app. Validated like the gold, above 4.5:1 on tints.
  static const Color adminLight = Color(0xFF2B5C8A);
  static const Color adminDark = Color(0xFF7FB0E0);
  static const Color onAdminDark = Color(0xFF0B1622);
  static const Color success = Color(0xFF4CA36A);
  static const Color verified = Color(0xFF4A9FD8);

  // Chart series, validated for contrast and color-vision separation on the
  // card surfaces of each theme (dataviz palette: blue and green slots).
  static const Color chartVerifiedLight = Color(0xFF2A78D6);
  static const Color chartVerifiedDark = Color(0xFF3987E5);
  static const Color chartPeer = Color(0xFF008300);

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

  // Errors: white text on the light one, dark text on the dark one, both
  // above 4.5:1 (e.g. the unread count on the notifications badge).
  static const Color errorLight = Color(0xFFC62828);
  static const Color errorDark = Color(0xFFF87171);
  static const Color onErrorDark = Color(0xFF2B0B0B);

  /// WCAG contrast ratio between two colors, from 1 to 21.
  static double contrast(Color a, Color b) {
    final la = a.computeLuminance();
    final lb = b.computeLuminance();
    return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
  }

  /// [color], darkened over light [backgrounds] or lightened over dark
  /// ones, until text in it reaches [minContrast] on all of them. Keeps
  /// the hue, so brand and tier colors stay recognizable.
  static Color legible(Color color, List<Color> backgrounds,
      {double minContrast = 4.5}) {
    final lighten = backgrounds.first.computeLuminance() < 0.5;
    var hsl = HSLColor.fromColor(color);
    var result = color;
    while (backgrounds.any((b) => contrast(result, b) < minContrast)) {
      final lightness = hsl.lightness + (lighten ? 0.02 : -0.02);
      if (lightness < 0 || lightness > 1) break;
      hsl = hsl.withLightness(lightness);
      result = hsl.toColor();
    }
    return result;
  }
}

class AppTheme {
  static const double radius = 16;

  static ThemeData themeDataLight = _light(AppColors.accentLight, Colors.white);
  static ThemeData themeDataDark =
      _dark(AppColors.accentDark, const Color(0xFF1C1505));

  /// The same themes with the admin accent, for admin mode.
  static ThemeData adminThemeDataLight =
      _light(AppColors.adminLight, Colors.white);
  static ThemeData adminThemeDataDark =
      _dark(AppColors.adminDark, AppColors.onAdminDark);

  static final Map<int, (ThemeData, ThemeData)> _branded = {};

  /// Light and dark themes with a company's [accent] instead of the gold.
  /// The accent is darkened (light) or lightened (dark) until text in it
  /// stays readable on the app's backgrounds and on its own tints.
  static (ThemeData light, ThemeData dark) branded(Color accent) =>
      _branded.putIfAbsent(accent.toARGB32(), () {
        final light = _readableAccent(accent, const [
          AppColors.lightBackground,
          AppColors.lightSurface,
          AppColors.lightSurfaceHigh,
        ]);
        final dark = _readableAccent(accent, const [
          AppColors.darkBackground,
          AppColors.darkSurface,
          AppColors.darkSurfaceHigh,
        ]);
        return (
          _light(light, _onAccent(light)),
          _dark(dark, _onAccent(dark)),
        );
      });

  static Color _readableAccent(Color accent, List<Color> backgrounds) {
    var color = accent;
    // Tints follow the color, so adjust until both agree.
    for (var i = 0; i < 3; i++) {
      color = AppColors.legible(color, [
        for (final background in backgrounds) ...[
          background,
          Color.alphaBlend(color.withValues(alpha: 0.16), background),
        ]
      ]);
    }
    return color;
  }

  /// White or near-black, whichever reads better on [accent].
  static Color _onAccent(Color accent) {
    const dark = Color(0xFF111214);
    return AppColors.contrast(Colors.white, accent) >=
            AppColors.contrast(dark, accent)
        ? Colors.white
        : dark;
  }

  static ThemeData _light(Color primary, Color onPrimary) => _build(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        error: AppColors.errorLight,
        onError: Colors.white,
        background: AppColors.lightBackground,
        surface: AppColors.lightSurface,
        surfaceHigh: AppColors.lightSurfaceHigh,
        sidebar: AppColors.lightSidebar,
        border: AppColors.lightBorder,
        onSurface: const Color(0xFF1A1A19),
        muted: AppColors.lightMuted,
      );

  static ThemeData _dark(Color primary, Color onPrimary) => _build(
        brightness: Brightness.dark,
        primary: primary,
        onPrimary: onPrimary,
        error: AppColors.errorDark,
        onError: AppColors.onErrorDark,
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
    required Color error,
    required Color onError,
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
      error: error,
      onError: onError,
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

extension LegibleColors on ColorScheme {
  /// [color] adjusted so it stays readable as text on the page and card
  /// backgrounds, also when they are tinted with [tint] of it. Use
  /// [minContrast] 3 for icons and other non-text marks.
  Color legible(Color color, {double tint = 0, double minContrast = 4.5}) =>
      AppColors.legible(
          color,
          [
            for (final background in [
              surface,
              surfaceContainer,
              surfaceContainerHighest
            ])
              Color.alphaBlend(color.withValues(alpha: tint), background)
          ],
          minContrast: minContrast);
}
