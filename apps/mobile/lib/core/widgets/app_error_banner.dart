import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_spacing.dart';

/// Inline form-flow failure banner.
///
/// Wraps the message in a tonal error surface (≥4.5:1 in both modes) and
/// announces it to screen readers as a live region, so an async failure is
/// spoken instead of only recolored.
class AppErrorBanner extends StatelessWidget {
  const AppErrorBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      width: double.infinity,
      padding: AppSpacing.sPadding,
      decoration: BoxDecoration(
        color: isLight
            ? AppColors.errorContainer
            : AppColors.errorContainerDark,
        borderRadius: AppRadius.sRadius,
      ),
      child: Semantics(
        liveRegion: true,
        child: Text(
          message,
          style: TextStyle(
            color: isLight
                ? AppColors.onErrorContainer
                : AppColors.onErrorContainerDark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
