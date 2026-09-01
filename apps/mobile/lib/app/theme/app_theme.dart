import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

/// Builds the Material 3 light/dark themes from design tokens so both modes
/// stay in sync. No widget may hard-code colors that belong here (DESIGN.md
/// "Theme Configuration").
abstract final class AppTheme {
  /// Light theme — default mode (DESIGN.md "Color Mode").
  static final ThemeData lightTheme = _build(Brightness.light);

  /// Dark theme — follows the system setting via `ThemeMode.system`.
  static final ThemeData darkTheme = _build(Brightness.dark);

  /// Builds one `ThemeData` variant from the shared token set.
  ///
  /// Everything theme-dependent (surfaces, text, buttons, cards, navigation
  /// bar, text fields) is derived here so light and dark can never drift.
  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: isLight
          ? AppColors.background
          : AppColors.backgroundDark,
      textTheme: _textTheme(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          padding: AppSpacing.mAll,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mRadius),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: AppSpacing.mAll,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mRadius),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: AppSpacing.sAll,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.sRadius),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.lRadius),
        color: isLight ? AppColors.surface : AppColors.surfaceDark,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isLight ? AppColors.surface : AppColors.surfaceDark,
        foregroundColor: isLight
            ? AppColors.textPrimary
            : AppColors.textPrimaryDark,
        elevation: 0,
        centerTitle: true,
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: isLight ? AppColors.surface : AppColors.surfaceDark,
        indicatorColor: colorScheme.primaryContainer,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: AppRadius.mRadius),
      ),
    );
  }

  /// Type scale from DESIGN.md "Typography" (Inter, display → label).
  ///
  /// Only sizes and weights are fixed here; text colors inherit from the
  /// `ColorScheme` so the same scale serves both modes.
  static TextTheme _textTheme() {
    return const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
    );
  }
}
