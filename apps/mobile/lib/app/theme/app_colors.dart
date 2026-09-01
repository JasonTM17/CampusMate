import 'package:flutter/material.dart';

/// CampusMate color tokens (DESIGN.md "Color System").
///
/// Static palette shared by light and dark themes. Theme-dependent aliases
/// (`background`, `surface`, `text*`, `icon*`) exist in light and dark pairs;
/// widgets should pick the pair matching their `ThemeData.brightness` instead
/// of hard-coding hex values.
abstract final class AppColors {
  // ── Primary (blue 600) ─────────────────────────────────────────────────
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryContainer = Color(0xFFDBEAFE);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF1E3A8A);

  // ── Secondary (violet 600) ─────────────────────────────────────────────
  static const Color secondary = Color(0xFF7C3AED);
  static const Color secondaryContainer = Color(0xFFEDE9FE);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF4C1D95);

  // ── Tertiary (cyan 600) ────────────────────────────────────────────────
  static const Color tertiary = Color(0xFF0891B2);
  static const Color tertiaryContainer = Color(0xFFA5F3FC);
  static const Color onTertiary = Color(0xFF0F172A);
  static const Color onTertiaryContainer = Color(0xFF164E63);

  // ── Neutral scale (Tailwind slate ramp, DESIGN.md "Neutral Palette") ───
  static const Color neutral1 = Color(0xFFF8FAFC);
  static const Color neutral2 = Color(0xFFE2E8F0);
  static const Color neutral3 = Color(0xFFCBD5E1);
  static const Color neutral4 = Color(0xFF94A3B8);
  static const Color neutral5 = Color(0xFF64748B);
  static const Color neutral6 = Color(0xFF475569);
  static const Color neutral7 = Color(0xFF334155);
  static const Color neutral8 = Color(0xFF1E293B);
  static const Color neutral9 = Color(0xFF0F172A);

  // ── Error (red 500) ────────────────────────────────────────────────────
  static const Color error = Color(0xFFEF4444);
  static const Color errorContainer = Color(0xFFFEE2E2);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFF991B1B);

  // ── Light-theme aliases ────────────────────────────────────────────────
  static const Color background = neutral1;
  static const Color surface = neutral1;
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  // ── Light-theme text/icon aliases ──────────────────────────────────────
  static const Color textPrimary = neutral9;
  static const Color textSecondary = neutral7;
  static const Color textTertiary = neutral5;
  static const Color textDisabled = neutral4;
  static const Color iconPrimary = neutral9;
  static const Color iconSecondary = neutral7;
  static const Color iconDisabled = neutral4;

  // ── Dark-theme aliases (DESIGN.md "Color Mode: Dark") ──────────────────
  /// Elevated surfaces lighten within the same hue ramp instead of stacking
  /// shadows: background < surface < surfaceVariant.
  static const Color backgroundDark = neutral9;
  static const Color surfaceDark = neutral8;
  static const Color surfaceVariantDark = neutral7;

  // ── Dark-theme text/icon aliases ───────────────────────────────────────
  static const Color textPrimaryDark = neutral1;
  static const Color textSecondaryDark = neutral3;
  static const Color textTertiaryDark = neutral4;
  static const Color textDisabledDark = neutral5;
  static const Color iconPrimaryDark = neutral1;
  static const Color iconSecondaryDark = neutral3;
  static const Color iconDisabledDark = neutral5;

  // ── Dark error container (M3 tonal: red-900 container / red-100 text) ──
  static const Color errorContainerDark = Color(0xFF7F1D1D);
  static const Color onErrorContainerDark = Color(0xFFFECACA);
}
