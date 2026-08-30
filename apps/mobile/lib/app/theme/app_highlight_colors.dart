import 'package:flutter/material.dart';

/// Semantic highlight/note colors for the reader (§23). Reader features
/// must reference these tokens, never arbitrary hex values.
abstract final class AppHighlightColors {
  static const Color yellow = Color(0xFFFFF59D);
  static const Color green = Color(0xFFC8E6C9);
  static const Color blue = Color(0xFFBBDEFB);
  static const Color pink = Color(0xFFF8BBD0);
}
