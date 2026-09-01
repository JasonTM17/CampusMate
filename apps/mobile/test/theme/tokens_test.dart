import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campusmate/app/theme/app_radius.dart';
import 'package:campusmate/app/theme/app_spacing.dart';

/// Locks the design tokens to DESIGN.md ("Spacing — Material 3 Scale 8" and
/// "Radius") so a token drift shows up as a test failure, not a UI bug.
void main() {
  group('AppSpacing values match DESIGN.md', () {
    test('base scale-8 doubles', () {
      expect(AppSpacing.xs, 4.0);
      expect(AppSpacing.s, 8.0);
      expect(AppSpacing.m, 16.0);
      expect(AppSpacing.l, 24.0);
      expect(AppSpacing.xl, 32.0);
      expect(AppSpacing.xxl, 40.0);
      expect(AppSpacing.xxxl, 48.0);
    });

    test('all-side paddings wrap the matching token', () {
      expect(AppSpacing.sPadding, EdgeInsets.all(AppSpacing.s));
      expect(AppSpacing.mPadding, EdgeInsets.all(AppSpacing.m));
      expect(AppSpacing.xlPadding, EdgeInsets.all(AppSpacing.xl));
    });

    test('symmetric and edge helpers stay tied to the base tokens', () {
      expect(
        AppSpacing.mVertical,
        EdgeInsets.symmetric(vertical: AppSpacing.m),
      );
      expect(
        AppSpacing.lHorizontal,
        EdgeInsets.symmetric(horizontal: AppSpacing.l),
      );
      expect(AppSpacing.sTop, EdgeInsets.only(top: AppSpacing.s));
      expect(AppSpacing.sBottom, EdgeInsets.only(bottom: AppSpacing.s));
      expect(AppSpacing.sLeft, EdgeInsets.only(left: AppSpacing.s));
      expect(AppSpacing.sRight, EdgeInsets.only(right: AppSpacing.s));
    });
  });

  group('AppRadius values match DESIGN.md', () {
    test('base radius scale', () {
      expect(AppRadius.none, 0.0);
      expect(AppRadius.xs, 4.0);
      expect(AppRadius.s, 8.0);
      expect(AppRadius.m, 12.0);
      expect(AppRadius.l, 16.0);
      expect(AppRadius.xl, 20.0);
      expect(AppRadius.full, 9999.0);
    });

    test('helper BorderRadius objects wrap the matching token', () {
      expect(AppRadius.mRadius, BorderRadius.circular(AppRadius.m));
      expect(AppRadius.fullRadius, BorderRadius.circular(AppRadius.full));

      expect(
        AppRadius.lTop,
        BorderRadius.vertical(top: Radius.circular(AppRadius.l)),
      );
      expect(
        AppRadius.lBottom,
        BorderRadius.vertical(bottom: Radius.circular(AppRadius.l)),
      );
      expect(
        AppRadius.mTopLeft,
        BorderRadius.only(topLeft: Radius.circular(AppRadius.m)),
      );
      expect(
        AppRadius.mTopRight,
        BorderRadius.only(topRight: Radius.circular(AppRadius.m)),
      );
      expect(
        AppRadius.mBottomLeft,
        BorderRadius.only(bottomLeft: Radius.circular(AppRadius.m)),
      );
      expect(
        AppRadius.mBottomRight,
        BorderRadius.only(bottomRight: Radius.circular(AppRadius.m)),
      );
    });

    test('circle helper equals full rounding', () {
      expect(AppRadius.circle, BorderRadius.circular(AppRadius.full));
    });
  });
}
