import 'package:flutter/material.dart';

/// CampusMate corner-radius tokens (DESIGN.md "Radius").
///
/// Base doubles (`none`…`full`) for raw values; precomputed `BorderRadius`
/// helpers for full rounding (`*Radius`), corner pairs (`*Top`, `*Bottom` —
/// e.g. chat-bubble groups), and single corners (`*TopLeft`…`*BottomRight`).
/// All constants are compile-time const.
abstract final class AppRadius {
  // Radius values (Material 3)
  static const double none = 0.0;
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 12.0;
  static const double l = 16.0;
  static const double xl = 20.0;
  static const double full = 9999.0;

  // All four corners
  static const BorderRadius xsRadius = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius sRadius = BorderRadius.all(Radius.circular(s));
  static const BorderRadius mRadius = BorderRadius.all(Radius.circular(m));
  static const BorderRadius lRadius = BorderRadius.all(Radius.circular(l));
  static const BorderRadius xlRadius = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius fullRadius = BorderRadius.all(
    Radius.circular(full),
  );

  // Custom radii cho card & button
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(16));
  static const BorderRadius buttonRadius = BorderRadius.all(
    Radius.circular(12),
  );

  // Top corner pair (topLeft + topRight)
  static const BorderRadius xsTop = BorderRadius.vertical(
    top: Radius.circular(xs),
  );
  static const BorderRadius sTop = BorderRadius.vertical(
    top: Radius.circular(s),
  );
  static const BorderRadius mTop = BorderRadius.vertical(
    top: Radius.circular(m),
  );
  static const BorderRadius lTop = BorderRadius.vertical(
    top: Radius.circular(l),
  );
  static const BorderRadius xlTop = BorderRadius.vertical(
    top: Radius.circular(xl),
  );

  // Bottom corner pair (bottomLeft + bottomRight)
  static const BorderRadius xsBottom = BorderRadius.vertical(
    bottom: Radius.circular(xs),
  );
  static const BorderRadius sBottom = BorderRadius.vertical(
    bottom: Radius.circular(s),
  );
  static const BorderRadius mBottom = BorderRadius.vertical(
    bottom: Radius.circular(m),
  );
  static const BorderRadius lBottom = BorderRadius.vertical(
    bottom: Radius.circular(l),
  );
  static const BorderRadius xlBottom = BorderRadius.vertical(
    bottom: Radius.circular(xl),
  );

  // Single corners
  static const BorderRadius xsTopLeft = BorderRadius.only(
    topLeft: Radius.circular(xs),
  );
  static const BorderRadius sTopLeft = BorderRadius.only(
    topLeft: Radius.circular(s),
  );
  static const BorderRadius mTopLeft = BorderRadius.only(
    topLeft: Radius.circular(m),
  );
  static const BorderRadius lTopLeft = BorderRadius.only(
    topLeft: Radius.circular(l),
  );
  static const BorderRadius xlTopLeft = BorderRadius.only(
    topLeft: Radius.circular(xl),
  );
  static const BorderRadius xsTopRight = BorderRadius.only(
    topRight: Radius.circular(xs),
  );
  static const BorderRadius sTopRight = BorderRadius.only(
    topRight: Radius.circular(s),
  );
  static const BorderRadius mTopRight = BorderRadius.only(
    topRight: Radius.circular(m),
  );
  static const BorderRadius lTopRight = BorderRadius.only(
    topRight: Radius.circular(l),
  );
  static const BorderRadius xlTopRight = BorderRadius.only(
    topRight: Radius.circular(xl),
  );
  static const BorderRadius xsBottomLeft = BorderRadius.only(
    bottomLeft: Radius.circular(xs),
  );
  static const BorderRadius sBottomLeft = BorderRadius.only(
    bottomLeft: Radius.circular(s),
  );
  static const BorderRadius mBottomLeft = BorderRadius.only(
    bottomLeft: Radius.circular(m),
  );
  static const BorderRadius lBottomLeft = BorderRadius.only(
    bottomLeft: Radius.circular(l),
  );
  static const BorderRadius xlBottomLeft = BorderRadius.only(
    bottomLeft: Radius.circular(xl),
  );
  static const BorderRadius xsBottomRight = BorderRadius.only(
    bottomRight: Radius.circular(xs),
  );
  static const BorderRadius sBottomRight = BorderRadius.only(
    bottomRight: Radius.circular(s),
  );
  static const BorderRadius mBottomRight = BorderRadius.only(
    bottomRight: Radius.circular(m),
  );
  static const BorderRadius lBottomRight = BorderRadius.only(
    bottomRight: Radius.circular(l),
  );
  static const BorderRadius xlBottomRight = BorderRadius.only(
    bottomRight: Radius.circular(xl),
  );

  // Circle helpers (avatars, FABs)
  static const BorderRadius circle = BorderRadius.all(Radius.circular(full));
}
