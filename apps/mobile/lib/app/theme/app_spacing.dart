import 'package:flutter/material.dart';

/// CampusMate spacing tokens (DESIGN.md "Spacing — Material 3 Scale 8").
///
/// Base doubles (`xs`…`xxxl`) for raw gaps; precomputed `EdgeInsets` helpers
/// (`*Padding`, `*Vertical`, `*Horizontal`, `*Top/Bottom/Left/Right`, `*All`)
/// for common paddings. All constants are compile-time const so widgets can
/// stay const-constructible.
abstract final class AppSpacing {
  // Scale 8 (Material 3)
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 16.0;
  static const double l = 24.0;
  static const double xl = 32.0;
  static const double xxl = 40.0;
  static const double xxxl = 48.0;

  // All-side paddings
  static const EdgeInsets xsPadding = EdgeInsets.all(xs);
  static const EdgeInsets sPadding = EdgeInsets.all(s);
  static const EdgeInsets mPadding = EdgeInsets.all(m);
  static const EdgeInsets lPadding = EdgeInsets.all(l);
  static const EdgeInsets xlPadding = EdgeInsets.all(xl);
  static const EdgeInsets xxlPadding = EdgeInsets.all(xxl);
  static const EdgeInsets xxxlPadding = EdgeInsets.all(xxxl);

  // Symmetric vertical paddings
  static const EdgeInsets xsVertical = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets sVertical = EdgeInsets.symmetric(vertical: s);
  static const EdgeInsets mVertical = EdgeInsets.symmetric(vertical: m);
  static const EdgeInsets lVertical = EdgeInsets.symmetric(vertical: l);
  static const EdgeInsets xlVertical = EdgeInsets.symmetric(vertical: xl);
  static const EdgeInsets xxlVertical = EdgeInsets.symmetric(vertical: xxl);
  static const EdgeInsets xxxlVertical = EdgeInsets.symmetric(vertical: xxxl);

  // Symmetric horizontal paddings
  static const EdgeInsets xsHorizontal = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets sHorizontal = EdgeInsets.symmetric(horizontal: s);
  static const EdgeInsets mHorizontal = EdgeInsets.symmetric(horizontal: m);
  static const EdgeInsets lHorizontal = EdgeInsets.symmetric(horizontal: l);
  static const EdgeInsets xlHorizontal = EdgeInsets.symmetric(horizontal: xl);
  static const EdgeInsets xxlHorizontal = EdgeInsets.symmetric(horizontal: xxl);
  static const EdgeInsets xxxlHorizontal = EdgeInsets.symmetric(
    horizontal: xxxl,
  );

  // Top-only paddings
  static const EdgeInsets xsTop = EdgeInsets.only(top: xs);
  static const EdgeInsets sTop = EdgeInsets.only(top: s);
  static const EdgeInsets mTop = EdgeInsets.only(top: m);
  static const EdgeInsets lTop = EdgeInsets.only(top: l);
  static const EdgeInsets xlTop = EdgeInsets.only(top: xl);
  static const EdgeInsets xxlTop = EdgeInsets.only(top: xxl);
  static const EdgeInsets xxxlTop = EdgeInsets.only(top: xxxl);

  // Bottom-only paddings
  static const EdgeInsets xsBottom = EdgeInsets.only(bottom: xs);
  static const EdgeInsets sBottom = EdgeInsets.only(bottom: s);
  static const EdgeInsets mBottom = EdgeInsets.only(bottom: m);
  static const EdgeInsets lBottom = EdgeInsets.only(bottom: l);
  static const EdgeInsets xlBottom = EdgeInsets.only(bottom: xl);
  static const EdgeInsets xxlBottom = EdgeInsets.only(bottom: xxl);
  static const EdgeInsets xxxlBottom = EdgeInsets.only(bottom: xxxl);

  // Left-only paddings
  static const EdgeInsets xsLeft = EdgeInsets.only(left: xs);
  static const EdgeInsets sLeft = EdgeInsets.only(left: s);
  static const EdgeInsets mLeft = EdgeInsets.only(left: m);
  static const EdgeInsets lLeft = EdgeInsets.only(left: l);
  static const EdgeInsets xlLeft = EdgeInsets.only(left: xl);
  static const EdgeInsets xxlLeft = EdgeInsets.only(left: xxl);
  static const EdgeInsets xxxlLeft = EdgeInsets.only(left: xxxl);

  // Right-only paddings
  static const EdgeInsets xsRight = EdgeInsets.only(right: xs);
  static const EdgeInsets sRight = EdgeInsets.only(right: s);
  static const EdgeInsets mRight = EdgeInsets.only(right: m);
  static const EdgeInsets lRight = EdgeInsets.only(right: l);
  static const EdgeInsets xlRight = EdgeInsets.only(right: xl);
  static const EdgeInsets xxlRight = EdgeInsets.only(right: xxl);
  static const EdgeInsets xxxlRight = EdgeInsets.only(right: xxxl);

  // Symmetric all-side insets (edge-to-edge helpers)
  static const EdgeInsets xsAll = EdgeInsets.all(xs);
  static const EdgeInsets sAll = EdgeInsets.all(s);
  static const EdgeInsets mAll = EdgeInsets.all(m);
  static const EdgeInsets lAll = EdgeInsets.all(l);
  static const EdgeInsets xlAll = EdgeInsets.all(xl);
  static const EdgeInsets xxlAll = EdgeInsets.all(xxl);
  static const EdgeInsets xxxlAll = EdgeInsets.all(xxxl);
}
