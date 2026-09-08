import 'dart:async';

import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../application/library_controller.dart';
import 'book_cover.dart';
import 'library_screen.dart';

class BookDetailScreen extends ConsumerWidget {
  const BookDetailScreen({super.key, required this.bookId});

  final int bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookDetailProvider(bookId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết tài liệu'),
        actions: [
          state.maybeWhen(
            data: (book) => IconButton(
              tooltip: book.isFavorite ? 'Bỏ yêu thích' : 'Yêu thích',
              onPressed: () => unawaited(_toggleFavorite(context, ref, book)),
              icon: Icon(
                book.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => AppEmptyState(
          icon: Icons.cloud_off_outlined,
          title: 'Không tải được tài liệu',
          message: 'Kiểm tra kết nối rồi thử lại.',
          actionLabel: 'Thử lại',
          onAction: () => ref.invalidate(bookDetailProvider(bookId)),
        ),
        data: (book) => RefreshIndicator(
          onRefresh: () async => ref.invalidate(bookDetailProvider(bookId)),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.cardPadding,
              AppSpacing.m,
              AppSpacing.cardPadding,
              AppSpacing.xl,
            ),
            children: [
              _BookHero(book: book),
              const SizedBox(height: AppSpacing.l),
              _ActionPanel(book: book),
              const SizedBox(height: AppSpacing.l),
              _DetailSection(title: 'Mô tả', child: Text(book.description)),
              const SizedBox(height: AppSpacing.m),
              _DetailSection(
                title: 'Thông tin xuất bản',
                child: Column(
                  children: [
                    _MetadataRow(label: 'Nhà xuất bản', value: book.publisher),
                    _MetadataRow(
                      label: 'Năm xuất bản',
                      value: book.publishedYear.toString(),
                    ),
                    _MetadataRow(
                      label: 'Ngôn ngữ',
                      value: _languageLabel(book.language),
                    ),
                    if (book.isbn != null)
                      _MetadataRow(label: 'ISBN', value: book.isbn!),
                    _MetadataRow(label: 'Giấy phép', value: book.license),
                    if (book.licenseExpiresAt != null)
                      _MetadataRow(
                        label: 'Hết hạn',
                        value: _dateText(book.licenseExpiresAt!),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.m),
              _DetailSection(
                title: 'Liên kết học tập',
                child: Wrap(
                  spacing: AppSpacing.s,
                  runSpacing: AppSpacing.s,
                  children: [
                    for (final category in book.categories)
                      Chip(label: Text(category)),
                    for (final course in book.courseCodes)
                      Chip(
                        avatar: const Icon(Icons.school_outlined, size: 18),
                        label: Text(course),
                      ),
                  ],
                ),
              ),
              if (book.keywords.trim().isNotEmpty) ...[
                const SizedBox(height: AppSpacing.m),
                _DetailSection(title: 'Từ khóa', child: Text(book.keywords)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggleFavorite(
    BuildContext context,
    WidgetRef ref,
    BookDetail book,
  ) async {
    final status = await ref
        .read(libraryRepositoryProvider)
        .toggleFavorite(bookId: book.id);
    ref.read(libraryControllerProvider.notifier).updateFavoriteStatus(status);
    ref.invalidate(bookDetailProvider(book.id));
  }
}

class _BookHero extends StatelessWidget {
  const _BookHero({required this.book});

  final BookDetail book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookCover(coverUrl: book.coverUrl, width: 112, height: 160),
        const SizedBox(width: AppSpacing.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(book.title, style: theme.textTheme.headlineSmall),
              if (book.subtitle != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  book.subtitle!,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.s),
              Text(book.authors.join(', '), style: theme.textTheme.bodyLarge),
              const SizedBox(height: AppSpacing.s),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  Chip(label: Text(accessTypeLabel(book.accessType))),
                  for (final format in book.availableFormats)
                    Chip(label: Text(format)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionPanel extends StatelessWidget {
  const _ActionPanel({required this.book});

  final BookDetail book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final actions = <Widget>[
      if (book.access.canRead)
        FilledButton.icon(
          onPressed: () => _showAction(context, 'Đang chuẩn bị trình đọc.'),
          icon: const Icon(Icons.chrome_reader_mode_outlined),
          label: const Text('Đọc'),
        ),
      if (book.access.canDownload)
        OutlinedButton.icon(
          onPressed: () => _showAction(context, 'Đang chuẩn bị tệp tải xuống.'),
          icon: const Icon(Icons.download_outlined),
          label: const Text('Tải xuống'),
        ),
      if (book.access.canBorrow)
        OutlinedButton.icon(
          onPressed: () => _showAction(context, 'Đã ghi nhận yêu cầu mượn.'),
          icon: const Icon(Icons.assignment_return_outlined),
          label: const Text('Mượn sách'),
        ),
    ];
    final message =
        book.access.reason ??
        (book.accessType == BookAccessType.metadataOnly
            ? 'Tài liệu này hiện chỉ có thông tin tham khảo.'
            : null);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: AppRadius.sRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quyền sử dụng', style: theme.textTheme.titleMedium),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.s),
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (actions.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.m),
              Wrap(
                spacing: AppSpacing.s,
                runSpacing: AppSpacing.s,
                children: actions,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showAction(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.s),
        child,
      ],
    );
  }
}

class _MetadataRow extends StatelessWidget {
  const _MetadataRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 112,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

String _languageLabel(String language) => switch (language.toLowerCase()) {
  'vi' => 'Tiếng Việt',
  'en' => 'English',
  _ => language.toUpperCase(),
};

String _dateText(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
