import 'package:flutter/material.dart';

/// Spacing scale for the whole app (§41 design tokens).
/// Only these values are allowed for layout paddings and gaps.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double s = 8;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 24;
  static const double xxl = 32;

  static const EdgeInsets screenPadding = EdgeInsets.all(l);
}
