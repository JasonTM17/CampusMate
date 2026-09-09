import 'dart:async';

import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../auth/application/auth_controller.dart';
import '../../auth/domain/auth_user.dart';
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
              if (_canManageLibrary(ref)) ...[
                const SizedBox(height: AppSpacing.l),
                _LibrarianPanel(book: book),
              ],
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

  bool _canManageLibrary(WidgetRef ref) {
    final role = ref.watch(authControllerProvider).user?.role;
    return role != null && canAccessPrivilegedArea(role);
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

class _ActionPanel extends ConsumerStatefulWidget {
  const _ActionPanel({required this.book});

  final BookDetail book;

  @override
  ConsumerState<_ActionPanel> createState() => _ActionPanelState();
}

class _ActionPanelState extends ConsumerState<_ActionPanel> {
  bool _isMutating = false;

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final theme = Theme.of(context);
    final activeLoan = book.activeLoan;
    final actions = <Widget>[
      if (book.access.canRead)
        FilledButton.icon(
          onPressed: () {
            final format = book.availableFormats.firstOrNull ?? 'pdf';
            final encodedTitle = Uri.encodeComponent(book.title);
            context.push(
              '/library/books/${book.id}/read?format=$format&title=$encodedTitle',
            );
          },
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
          onPressed: _isMutating || book.availableCopies == 0
              ? null
              : () => _borrow(context),
          icon: _isMutating
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.assignment_return_outlined),
          label: Text(book.availableCopies == 0 ? 'Hết bản sao' : 'Mượn sách'),
        ),
      if (activeLoan != null &&
          activeLoan.status != BookLoanStatus.returned &&
          !book.access.canBorrow)
        OutlinedButton.icon(
          onPressed: _isMutating
              ? null
              : () => _returnLoan(context, activeLoan),
          icon: _isMutating
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.assignment_turned_in_outlined),
          label: const Text('Trả sách'),
        ),
      OutlinedButton.icon(
        key: const Key('ask-ai-book-button'),
        onPressed: () {
          final encodedTitle = Uri.encodeComponent(book.title);
          context.push('/ai?bookId=${book.id}&title=$encodedTitle');
        },
        icon: const Icon(Icons.auto_awesome_outlined),
        label: const Text('Hỏi AI về sách'),
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
            const SizedBox(height: AppSpacing.s),
            Text(
              activeLoan == null
                  ? 'Bản sẵn sàng: ${book.availableCopies}'
                  : _loanStatusText(activeLoan),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
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

  Future<void> _borrow(BuildContext context) async {
    await _mutate(
      context,
      () => ref
          .read(libraryRepositoryProvider)
          .borrowBook(bookId: widget.book.id),
      (loan) => 'Đã mượn đến ${_dateText(loan.dueAt)}.',
    );
  }

  Future<void> _returnLoan(BuildContext context, BookLoanSummary loan) async {
    await _mutate(
      context,
      () => ref.read(libraryRepositoryProvider).returnLoan(loanId: loan.id),
      (_) => 'Đã trả sách.',
    );
  }

  Future<void> _mutate(
    BuildContext context,
    Future<BookLoanSummary> Function() run,
    String Function(BookLoanSummary loan) successMessage,
  ) async {
    setState(() => _isMutating = true);
    try {
      final loan = await run();
      if (!context.mounted) return;
      ref.invalidate(bookDetailProvider(widget.book.id));
      ref.invalidate(myLoansProvider);
      await ref.read(libraryControllerProvider.notifier).refresh();
      if (!mounted || !context.mounted) return;
      _showAction(context, successMessage(loan));
    } on ServerpodClientException catch (e) {
      if (!context.mounted) return;
      _showAction(context, e.message);
    } on Object {
      if (!context.mounted) return;
      _showAction(context, 'Không thực hiện được. Vui lòng thử lại.');
    } finally {
      if (mounted) setState(() => _isMutating = false);
    }
  }

  void _showAction(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _LibrarianPanel extends ConsumerStatefulWidget {
  const _LibrarianPanel({required this.book});

  final BookDetail book;

  @override
  ConsumerState<_LibrarianPanel> createState() => _LibrarianPanelState();
}

class _LibrarianPanelState extends ConsumerState<_LibrarianPanel> {
  late BookAccessType _selectedAccessType = widget.book.accessType;
  bool _isSaving = false;

  @override
  void didUpdateWidget(covariant _LibrarianPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.book.accessType != widget.book.accessType) {
      _selectedAccessType = widget.book.accessType;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeLoans = ref.watch(activeBookLoansProvider(widget.book.id));
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
            Text('Quản lý thư viện', style: theme.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.m),
            DropdownButtonFormField<BookAccessType>(
              initialValue: _selectedAccessType,
              decoration: const InputDecoration(
                labelText: 'Quyền truy cập',
                prefixIcon: Icon(Icons.policy_outlined),
              ),
              items: [
                for (final accessType in BookAccessType.values)
                  DropdownMenuItem(
                    value: accessType,
                    child: Text(accessTypeLabel(accessType)),
                  ),
              ],
              onChanged: _isSaving
                  ? null
                  : (value) => setState(
                      () => _selectedAccessType = value ?? _selectedAccessType,
                    ),
            ),
            const SizedBox(height: AppSpacing.s),
            Align(
              alignment: Alignment.centerLeft,
              child: FilledButton.icon(
                onPressed:
                    _isSaving || _selectedAccessType == widget.book.accessType
                    ? null
                    : () => _saveAccessPolicy(context),
                icon: _isSaving
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save_outlined),
                label: const Text('Lưu quyền truy cập'),
              ),
            ),
            const SizedBox(height: AppSpacing.m),
            Text('Đang mượn', style: theme.textTheme.titleSmall),
            const SizedBox(height: AppSpacing.s),
            activeLoans.when(
              loading: () => const LinearProgressIndicator(),
              error: (error, stackTrace) => Text(
                'Không tải được danh sách mượn.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
              data: (loans) => loans.isEmpty
                  ? Text(
                      'Chưa có loan active.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    )
                  : Column(
                      children: [
                        for (final loan in loans)
                          _LoanCompactRow(loan: loan, showTitle: false),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveAccessPolicy(BuildContext context) async {
    setState(() => _isSaving = true);
    try {
      await ref
          .read(libraryRepositoryProvider)
          .updateAccessPolicy(
            bookId: widget.book.id,
            accessType: _selectedAccessType,
          );
      if (!context.mounted) return;
      ref.invalidate(bookDetailProvider(widget.book.id));
      await ref.read(libraryControllerProvider.notifier).refresh();
      if (!mounted || !context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đã lưu quyền truy cập.')));
    } on Object {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không lưu được quyền truy cập.')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}

class _LoanCompactRow extends StatelessWidget {
  const _LoanCompactRow({required this.loan, required this.showTitle});

  final BookLoanSummary loan;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s),
      child: Row(
        children: [
          Icon(
            loan.isOverdue
                ? Icons.warning_amber_outlined
                : Icons.schedule_outlined,
            color: loan.isOverdue
                ? theme.colorScheme.error
                : theme.colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Text(
              showTitle
                  ? '${loan.title} • ${_loanStatusText(loan)}'
                  : _loanStatusText(loan),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
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

String _loanStatusText(BookLoanSummary loan) {
  if (loan.status == BookLoanStatus.returned) {
    return 'Đã trả ngày ${_dateText(loan.returnedAt ?? loan.dueAt)}';
  }
  if (loan.isOverdue) return 'Đã quá hạn từ ${_dateText(loan.dueAt)}';
  return 'Còn ${loan.daysRemaining} ngày, hạn ${_dateText(loan.dueAt)}';
}
