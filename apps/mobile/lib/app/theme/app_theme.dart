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
          shape: RoundedRectangleBorder(borderRadius: AppRadius.buttonRadius),
          elevation: 2,
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: AppSpacing.mAll,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mRadius),
          side: BorderSide(color: AppColors.primary.withValues(alpha: 0.6)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: AppSpacing.sAll,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.sRadius),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.cardRadius,
          side: BorderSide(
            color: isLight
                ? AppColors.borderLight.withValues(alpha: 0.8)
                : AppColors.borderDark.withValues(alpha: 0.8),
          ),
        ),
        color: isLight ? AppColors.surface : AppColors.surfaceDark,
        shadowColor: Colors.black.withValues(alpha: isLight ? 0.08 : 0.3),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isLight ? AppColors.surface : AppColors.surfaceDark,
        foregroundColor: isLight
            ? AppColors.textPrimary
            : AppColors.textPrimaryDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: isLight ? AppColors.textPrimary : AppColors.textPrimaryDark,
        ),
        titleSpacing: 16,
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: isLight ? AppColors.surface : AppColors.surfaceDark,
        indicatorColor: colorScheme.primaryContainer,
        height: 70,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: AppRadius.mRadius,
          borderSide: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mRadius,
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        filled: true,
        fillColor: isLight
            ? AppColors.inputBackground.withValues(alpha: 0.6)
            : AppColors.inputBackgroundDark.withValues(alpha: 0.6),
        contentPadding: AppSpacing.mAll,
        hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 16),
      ),
      iconTheme: IconThemeData(
        color: isLight ? AppColors.textPrimary : AppColors.textPrimaryDark,
        size: 24,
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
