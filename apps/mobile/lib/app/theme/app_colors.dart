import 'package:flutter/material.dart';

/// Base palette: technical-university blue with a restrained red accent
/// (§40). Never copy any real university branding.
abstract final class AppColors {
  static const Color primarySeed = Color(0xFF1565C0);
  static const Color accentRed = Color(0xFFD32F2F);

  static const Color surfaceLight = Color(0xFFFAFCFF);
  static const Color surfaceDark = Color(0xFF101418);

  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);
}
