import 'dart:async';

import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_shimmer.dart';
import '../../../core/widgets/bouncing_widget.dart';
import '../application/notification_controller.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreNearEnd);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_loadMoreNearEnd)
      ..dispose();
    super.dispose();
  }

  void _loadMoreNearEnd() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.extentAfter > 240) return;
    final current = ref.read(notificationControllerProvider).value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;
    unawaited(ref.read(notificationControllerProvider.notifier).loadMore());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationControllerProvider);
    final unread = state.value?.unreadCount ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
        actions: [
          IconButton(
            tooltip: 'Làm mới',
            onPressed: state.isLoading
                ? null
                : () {
                    unawaited(HapticFeedback.lightImpact());
                    ref.read(notificationControllerProvider.notifier).refresh();
                  },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            tooltip: 'Đánh dấu tất cả đã đọc',
            onPressed: unread == 0 || state.isLoading
                ? null
                : () {
                    unawaited(HapticFeedback.lightImpact());
                    ref
                        .read(notificationControllerProvider.notifier)
                        .markAllRead();
                  },
            icon: const Icon(Icons.mark_email_read_outlined),
          ),
        ],
      ),
      body: state.when(
        loading: () => const _NotificationSkeleton(),
        error: (error, stackTrace) => AppEmptyState(
          icon: Icons.cloud_off_outlined,
          title: 'Không tải được thông báo',
          message: 'Kiểm tra kết nối rồi thử lại.',
          actionLabel: 'Thử lại',
          onAction: () =>
              ref.read(notificationControllerProvider.notifier).refresh(),
        ),
        data: (data) => RefreshIndicator(
          onRefresh: () async {
            unawaited(HapticFeedback.lightImpact());
            await ref.read(notificationControllerProvider.notifier).refresh();
          },
          child: ListView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.cardPadding,
              AppSpacing.m,
              AppSpacing.cardPadding,
              AppSpacing.xl,
            ),
            children: [
              _CategoryFilter(selected: data.category),
              const SizedBox(height: AppSpacing.m),
              if (data.items.isEmpty)
                const AppEmptyState(
                  icon: Icons.notifications_none_outlined,
                  title: 'Không có thông báo',
                  message: 'Thông báo theo bộ lọc hiện tại sẽ xuất hiện ở đây.',
                )
              else ...[
                Text(
                  data.unreadCount == 0
                      ? 'Tất cả đã đọc'
                      : '${data.unreadCount} chưa đọc',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: AppSpacing.s),
                for (final item in data.items)
                  _NotificationTile(notification: item),
                if (data.hasMore) ...[
                  const SizedBox(height: AppSpacing.s),
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: data.isLoadingMore
                          ? null
                          : () => ref
                                .read(notificationControllerProvider.notifier)
                                .loadMore(),
                      icon: data.isLoadingMore
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.expand_more),
                      label: const Text('Tải thêm'),
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryFilter extends ConsumerWidget {
  const _CategoryFilter({required this.selected});

  final String? selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.xs),
            child: ChoiceChip(
              label: const Text('Tất cả'),
              selected: selected == null,
              onSelected: (_) => ref
                  .read(notificationControllerProvider.notifier)
                  .setCategory(null),
            ),
          ),
          for (final category in notificationCategories)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.xs),
              child: ChoiceChip(
                avatar: Icon(_iconFor(category), size: 18),
                label: Text(_labelFor(category)),
                selected: selected == category,
                onSelected: (_) => ref
                    .read(notificationControllerProvider.notifier)
                    .setCategory(category),
              ),
            ),
        ],
      ),
    );
  }
}

class _NotificationTile extends ConsumerWidget {
  const _NotificationTile({required this.notification});

  final CampusNotificationSummary notification;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = notification.readAt == null;
    final theme = Theme.of(context);
    return BouncingWidget(
      onTap: () => _open(context, ref),
      enableHaptic: true,
      child: Card(
        child: ListTile(
          onTap: () => _open(context, ref),
          leading: Badge(
            isLabelVisible: unread,
            smallSize: 9,
            child: CircleAvatar(
              backgroundColor: unread
                  ? theme.colorScheme.primaryContainer
                  : theme.colorScheme.surfaceContainerHighest,
              child: Icon(
                _iconFor(notification.category),
                color: unread
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          title: Text(
            notification.title,
            style: unread
                ? theme.textTheme.titleMedium
                : theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
          ),
          subtitle: Text(notification.body),
          trailing: Text(_labelFor(notification.category)),
        ),
      ),
    );
  }

  Future<void> _open(BuildContext context, WidgetRef ref) async {
    await ref
        .read(notificationControllerProvider.notifier)
        .markRead(notification);
    if (!context.mounted) return;
    final targetType = notification.targetType?.toLowerCase();
    final targetId = notification.targetId;
    if (targetType == 'exam' && targetId != null) {
      context.go('/academic/exams/$targetId');
    } else if (targetType == 'book' && targetId != null) {
      context.go('/library/books/$targetId');
    } else if (targetType == 'loan' || targetType == 'library') {
      context.go('/library/loans');
    } else if (targetType == 'announcement') {
      context.go('/home');
    } else if (targetType == 'academic' || targetType == 'course') {
      context.go('/academic');
    }
  }
}

IconData _iconFor(String category) => switch (category) {
  'academic' => Icons.school_outlined,
  'library' => Icons.local_library_outlined,
  'system' => Icons.settings_outlined,
  'ai' => Icons.auto_awesome_outlined,
  'course' => Icons.menu_book_outlined,
  'exam' => Icons.assignment_outlined,
  _ => Icons.notifications_outlined,
};

String _labelFor(String category) => switch (category) {
  'academic' => 'Học vụ',
  'library' => 'Thư viện',
  'system' => 'Hệ thống',
  'ai' => 'AI',
  'course' => 'Môn học',
  'exam' => 'Lịch thi',
  _ => 'Khác',
};

class _NotificationSkeleton extends StatelessWidget {
  const _NotificationSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.cardPadding,
        AppSpacing.m,
        AppSpacing.cardPadding,
        AppSpacing.xl,
      ),
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            children: List.generate(
              5,
              (_) => const Padding(
                padding: EdgeInsets.only(right: AppSpacing.xs),
                child: AppShimmer(width: 80, height: 32),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.m),
        const AppShimmer(width: 100, height: 18),
        const SizedBox(height: AppSpacing.s),
        for (var i = 0; i < 4; i++)
          const Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.s),
            child: AppShimmer(width: double.infinity, height: 80),
          ),
      ],
    );
  }
}
