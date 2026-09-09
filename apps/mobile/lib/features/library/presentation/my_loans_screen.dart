import 'dart:async';

import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../application/library_controller.dart';
import 'book_cover.dart';

class MyLoansScreen extends ConsumerWidget {
  const MyLoansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myLoansProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sách của tôi'),
        actions: [
          IconButton(
            tooltip: 'Làm mới',
            onPressed: () => ref.invalidate(myLoansProvider),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => AppEmptyState(
          icon: Icons.cloud_off_outlined,
          title: 'Không tải được sách đang mượn',
          message: 'Kiểm tra kết nối rồi thử lại.',
          actionLabel: 'Thử lại',
          onAction: () => ref.invalidate(myLoansProvider),
        ),
        data: (page) => RefreshIndicator(
          onRefresh: () async => ref.invalidate(myLoansProvider),
          child: page.items.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(AppSpacing.cardPadding),
                  children: [
                    AppEmptyState(
                      icon: Icons.local_library_outlined,
                      title: 'Chưa mượn tài liệu',
                      message: 'Các sách đang mượn sẽ xuất hiện ở đây.',
                      actionLabel: 'Khám phá thư viện',
                      onAction: () => context.go('/library'),
                    ),
                  ],
                )
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.cardPadding,
                    AppSpacing.m,
                    AppSpacing.cardPadding,
                    AppSpacing.xl,
                  ),
                  itemCount: page.items.length,
                  itemBuilder: (context, index) =>
                      _LoanCard(loan: page.items[index]),
                ),
        ),
      ),
    );
  }
}

class _LoanCard extends ConsumerStatefulWidget {
  const _LoanCard({required this.loan});

  final BookLoanSummary loan;

  @override
  ConsumerState<_LoanCard> createState() => _LoanCardState();
}

class _LoanCardState extends ConsumerState<_LoanCard> {
  bool _isReturning = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loan = widget.loan;
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.s),
      child: InkWell(
        borderRadius: AppRadius.cardRadius,
        onTap: () => context.push('/library/books/${loan.bookId}'),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookCover(coverUrl: loan.coverUrl),
              const SizedBox(width: AppSpacing.s),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loan.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _loanStatusText(loan),
                      key: const Key('loan-days-remaining'),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: loan.isOverdue
                            ? theme.colorScheme.error
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s),
                    Wrap(
                      spacing: AppSpacing.s,
                      runSpacing: AppSpacing.s,
                      children: [
                        Chip(
                          avatar: Icon(_statusIcon(loan), size: 18),
                          label: Text(_statusLabel(loan.status)),
                        ),
                        if (loan.status != BookLoanStatus.returned)
                          OutlinedButton.icon(
                            onPressed: _isReturning ? null : _returnLoan,
                            icon: _isReturning
                                ? const SizedBox.square(
                                    dimension: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(
                                    Icons.assignment_turned_in_outlined,
                                  ),
                            label: const Text('Trả sách'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _returnLoan() async {
    setState(() => _isReturning = true);
    try {
      await ref
          .read(libraryRepositoryProvider)
          .returnLoan(loanId: widget.loan.id);
      if (!mounted) return;
      ref.invalidate(myLoansProvider);
      ref.invalidate(bookDetailProvider(widget.loan.bookId));
      unawaited(ref.read(libraryControllerProvider.notifier).refresh());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đã trả sách.')));
    } on ServerpodClientException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } on Object {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Không trả được sách.')));
    } finally {
      if (mounted) setState(() => _isReturning = false);
    }
  }
}

String _loanStatusText(BookLoanSummary loan) {
  if (loan.status == BookLoanStatus.returned) {
    return 'Đã trả ngày ${_dateText(loan.returnedAt ?? loan.dueAt)}';
  }
  if (loan.isOverdue) return 'Đã quá hạn từ ${_dateText(loan.dueAt)}';
  return 'Còn ${loan.daysRemaining} ngày, hạn ${_dateText(loan.dueAt)}';
}

String _statusLabel(BookLoanStatus status) => switch (status) {
  BookLoanStatus.borrowed => 'Đang mượn',
  BookLoanStatus.overdue => 'Quá hạn',
  BookLoanStatus.returned => 'Đã trả',
};

IconData _statusIcon(BookLoanSummary loan) {
  if (loan.isOverdue) return Icons.warning_amber_outlined;
  return switch (loan.status) {
    BookLoanStatus.borrowed => Icons.schedule_outlined,
    BookLoanStatus.overdue => Icons.warning_amber_outlined,
    BookLoanStatus.returned => Icons.assignment_turned_in_outlined,
  };
}

String _dateText(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
