import 'package:flutter/material.dart';

import '../../../app/theme/app_radius.dart';

class BookCover extends StatelessWidget {
  const BookCover({
    super.key,
    required this.coverUrl,
    this.width = 72,
    this.height = 104,
    this.heroTag,
  });

  final String? coverUrl;
  final double width;
  final double height;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    final url = coverUrl?.trim();
    if (url == null || url.isEmpty) {
      final placeholder = _CoverPlaceholder(width: width, height: height);
      if (heroTag != null) {
        return Hero(tag: heroTag!, child: placeholder);
      }
      return placeholder;
    }

    final coverWidget = ClipRRect(
      borderRadius: AppRadius.sRadius,
      child: SizedBox(
        width: width,
        height: height,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _CoverPlaceholder(
            key: const Key('library-cover-error-placeholder'),
            width: width,
            height: height,
          ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const DecoratedBox(
              decoration: BoxDecoration(color: Color(0xFFE8EEF2)),
              child: Center(
                child: SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          },
        ),
      ),
    );

    if (heroTag != null) {
      return Hero(tag: heroTag!, child: coverWidget);
    }
    return coverWidget;
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      key: key == null ? const Key('library-cover-placeholder') : null,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: AppRadius.sRadius,
      ),
      child: Icon(
        Icons.menu_book_outlined,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
