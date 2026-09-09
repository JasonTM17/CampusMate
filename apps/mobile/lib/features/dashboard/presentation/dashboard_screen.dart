import 'package:campusmate_client/campusmate_client.dart';
import 'package:campusmate_shared/campusmate_shared.dart' show CampusClock;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_spacing.dart';
import '../../chat/application/ai_preferences_controller.dart';
import '../../notifications/application/notification_controller.dart';
import '../application/dashboard_controller.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greeting = ref.watch(dashboardGreetingProvider);
    final summary = ref.watch(dashboardAcademicSummaryProvider);
    final todayClasses = ref.watch(dashboardTodayClassesProvider);
    final nextClass = ref.watch(dashboardNextClassProvider);
    final upcomingExam = ref.watch(dashboardUpcomingExamProvider);
    final announcements = ref.watch(dashboardAnnouncementsProvider);
    final unreadCount = ref.watch(notificationUnreadCountProvider);
    final studySuggestion = ref.watch(studySuggestionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        actions: [
          IconButton(
            tooltip: 'Thông báo',
            onPressed: () => context.push('/notifications'),
            icon: unreadCount.maybeWhen(
              data: (count) => count > 0
                  ? Badge.count(
                      count: count,
                      child: const Icon(Icons.notifications_outlined),
                    )
                  : const Icon(Icons.notifications_outlined),
              orElse: () => const Icon(Icons.notifications_outlined),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refresh(ref),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.cardPadding,
            AppSpacing.m,
            AppSpacing.cardPadding,
            AppSpacing.xl,
          ),
          children: [
            _GreetingSection(
              value: greeting,
              onRetry: () => ref.invalidate(dashboardGreetingProvider),
            ),
            _AsyncSection<DashboardAcademicSummary>(
              title: 'Tổng quan học tập',
              icon: Icons.school_outlined,
              value: summary,
              onRetry: () => ref.invalidate(dashboardAcademicSummaryProvider),
              builder: (context, data) => _AcademicSummaryCard(summary: data),
            ),
            _AsyncSection<TimetableEntry?>(
              title: 'Lớp kế tiếp',
              icon: Icons.next_plan_outlined,
              value: nextClass,
              onRetry: () => ref.invalidate(dashboardNextClassProvider),
              builder: (context, entry) => entry == null
                  ? const _EmptyCard(
                      icon: Icons.event_available_outlined,
                      title: 'Không còn lớp học gần nhất',
                      message:
                          'Khi lịch mới được đồng bộ, lớp kế tiếp sẽ hiện ở đây.',
                    )
                  : _TimetableCard(entry: entry),
            ),
            _AsyncSection<List<TimetableEntry>>(
              title: 'Lớp hôm nay',
              icon: Icons.today_outlined,
              value: todayClasses,
              onRetry: () => ref.invalidate(dashboardTodayClassesProvider),
              builder: (context, rows) => rows.isEmpty
                  ? const _EmptyCard(
                      icon: Icons.event_busy_outlined,
                      title: 'Hôm nay chưa có lớp',
                      message:
                          'Bạn có thể dùng thời gian này để đọc tài liệu hoặc ôn bài.',
                    )
                  : Column(
                      children: [
                        for (final entry in rows) _TimetableCard(entry: entry),
                      ],
                    ),
            ),
            _AsyncSection<ExamSummary?>(
              title: 'Sắp thi',
              icon: Icons.assignment_outlined,
              value: upcomingExam,
              onRetry: () => ref.invalidate(dashboardUpcomingExamProvider),
              builder: (context, exam) => exam == null
                  ? const _EmptyCard(
                      icon: Icons.event_available_outlined,
                      title: 'Chưa có lịch thi sắp tới',
                      message:
                          'Lịch thi mới sẽ xuất hiện sau khi được phòng đào tạo đồng bộ.',
                    )
                  : _ExamCountdownCard(exam: exam),
            ),
            _AsyncSection<List<AnnouncementSummary>>(
              title: 'Thông báo chung',
              icon: Icons.campaign_outlined,
              value: announcements,
              onRetry: () => ref.invalidate(dashboardAnnouncementsProvider),
              builder: (context, rows) => rows.isEmpty
                  ? const _EmptyCard(
                      icon: Icons.mark_email_read_outlined,
                      title: 'Chưa có thông báo',
                      message: 'Các thông báo đã phát hành sẽ nằm tại đây.',
                    )
                  : Column(
                      children: [
                        for (final row in rows)
                          _AnnouncementCard(announcement: row),
                      ],
                    ),
            ),
            const SizedBox(height: AppSpacing.s),
            const _DeferredFeatureCard(
              icon: Icons.menu_book_outlined,
              title: 'Đọc tiếp',
              message:
                  'Kệ sách đang đọc sẽ mở khi phase e-library có dữ liệu thật.',
            ),
            _AsyncSection<StudySuggestion?>(
              title: 'Gợi ý AI',
              icon: Icons.auto_awesome_outlined,
              value: studySuggestion,
              onRetry: () => ref.invalidate(studySuggestionProvider),
              builder: (context, suggestion) => suggestion == null
                  ? const _EmptyCard(
                      icon: Icons.lightbulb_outline,
                      title: 'Chưa có gợi ý mới',
                      message:
                          'Khi có lịch thi, lớp học hoặc sách đến hạn, trợ lý AI sẽ tự động gợi ý tại đây.',
                    )
                  : _AiSuggestionCard(suggestion: suggestion),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _refresh(WidgetRef ref) async {
  refreshDashboardSections(ref);
  ref.invalidate(notificationUnreadCountProvider);
  ref.invalidate(studySuggestionProvider);
  try {
    await Future.wait<Object?>([
      ref.read(dashboardGreetingProvider.future),
      ref.read(dashboardAcademicSummaryProvider.future),
      ref.read(dashboardTodayClassesProvider.future),
      ref.read(dashboardNextClassProvider.future),
      ref.read(dashboardUpcomingExamProvider.future),
      ref.read(dashboardAnnouncementsProvider.future),
      ref.read(notificationUnreadCountProvider.future),
    ], eagerError: false);
  } on Object {
    // Section widgets keep their own error and retry affordances visible.
  }
}

class _GreetingSection extends StatelessWidget {
  const _GreetingSection({required this.value, required this.onRetry});

  final AsyncValue<DashboardGreeting> value;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () => const _LoadingCard(height: 132),
      error: (error, stackTrace) =>
          _ErrorCard(title: 'Không tải được lời chào', onRetry: onRetry),
      data: (greeting) {
        final theme = Theme.of(context);
        final name = greeting.studentName?.trim();
        return Card(
          color: theme.colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting.message,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                if (name != null && name.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.s),
                Text(
                  'Hôm nay ${_dateText(greeting.generatedAt)}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AsyncSection<T> extends StatelessWidget {
  const _AsyncSection({
    required this.title,
    required this.icon,
    required this.value,
    required this.onRetry,
    required this.builder,
  });

  final String title;
  final IconData icon;
  final AsyncValue<T> value;
  final VoidCallback onRetry;
  final Widget Function(BuildContext context, T data) builder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeading(icon: icon, title: title),
          value.when(
            loading: () => const _LoadingCard(height: 96),
            error: (error, stackTrace) =>
                _ErrorCard(title: 'Không tải được $title', onRetry: onRetry),
            data: (data) => builder(context, data),
          ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: AppSpacing.s),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _AcademicSummaryCard extends StatelessWidget {
  const _AcademicSummaryCard({required this.summary});

  final DashboardAcademicSummary summary;

  @override
  Widget build(BuildContext context) {
    final progress = (summary.percentComplete / 100).clamp(0, 1).toDouble();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              summary.semesterName,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppSpacing.m),
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.s,
              crossAxisSpacing: AppSpacing.s,
              childAspectRatio: 2.3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _Metric(
                  label: 'GPA kỳ',
                  value: summary.semesterGpa.toStringAsFixed(2),
                ),
                _Metric(
                  label: 'GPA tích lũy',
                  value: summary.cumulativeGpa.toStringAsFixed(2),
                ),
                _Metric(
                  label: 'Tín chỉ kỳ này',
                  value: '${summary.semesterCredits}',
                ),
                _Metric(
                  label: 'Tín chỉ tích lũy',
                  value: '${summary.creditsEarned}/${summary.creditsRequired}',
                ),
                _Metric(
                  label: 'Môn đang học',
                  value: '${summary.activeCourses}',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.m),
            LinearProgressIndicator(value: progress),
            const SizedBox(height: AppSpacing.s),
            Text('${summary.percentComplete.toStringAsFixed(0)}% chương trình'),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s,
          vertical: AppSpacing.xs,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: theme.textTheme.labelMedium),
            Text(value, style: theme.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}

class _TimetableCard extends StatelessWidget {
  const _TimetableCard({required this.entry});

  final TimetableEntry entry;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.schedule),
        title: Text('${entry.courseCode} · ${entry.title}'),
        subtitle: Text(
          '${_weekdayText(entry.weekday)} · ${_minuteText(entry.startMinute)}-${_minuteText(entry.endMinute)} · ${entry.room}',
        ),
        trailing: entry.isCurrent
            ? const Chip(
                label: Text('Đang học'),
                visualDensity: VisualDensity.compact,
              )
            : null,
      ),
    );
  }
}

class _ExamCountdownCard extends StatelessWidget {
  const _ExamCountdownCard({required this.exam});

  final ExamSummary exam;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => context.go('/academic/exams/${exam.examId}'),
        leading: const Icon(Icons.assignment_outlined),
        title: Text('${exam.courseCode} · ${exam.examType}'),
        subtitle: Text(
          '${_dateText(exam.startsAt)} · ${_minuteText(CampusClock.campusMinuteOfDay(exam.startsAt))} · ${exam.room}',
        ),
        trailing: Text('${exam.daysUntil} ngày'),
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  const _AnnouncementCard({required this.announcement});

  final AnnouncementSummary announcement;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.campaign_outlined),
        title: Text(announcement.title),
        subtitle: Text(announcement.body),
      ),
    );
  }
}

class _DeferredFeatureCard extends StatelessWidget {
  const _DeferredFeatureCard({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.s),
      child: _EmptyCard(icon: icon, title: title, message: message),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: theme.colorScheme.outline),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleSmall),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.title, required this.onRetry});

  final String title;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Row(
          children: [
            Icon(Icons.cloud_off_outlined, color: theme.colorScheme.error),
            const SizedBox(width: AppSpacing.m),
            Expanded(child: Text(title)),
            IconButton(
              tooltip: 'Thử lại',
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: height,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

String _weekdayText(int weekday) => switch (weekday) {
  1 => 'Thứ 2',
  2 => 'Thứ 3',
  3 => 'Thứ 4',
  4 => 'Thứ 5',
  5 => 'Thứ 6',
  6 => 'Thứ 7',
  _ => 'Chủ nhật',
};

String _minuteText(int minuteOfDay) {
  final hour = (minuteOfDay ~/ 60).toString().padLeft(2, '0');
  final minute = (minuteOfDay % 60).toString().padLeft(2, '0');
  return '$hour:$minute';
}

String _dateText(DateTime value) {
  final local = value.toLocal();
  final day = local.day.toString().padLeft(2, '0');
  final month = local.month.toString().padLeft(2, '0');
  return '$day/$month/${local.year}';
}

class _AiSuggestionCard extends StatelessWidget {
  const _AiSuggestionCard({required this.suggestion});

  final StudySuggestion suggestion;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHigh = suggestion.priority == 'high';

    return Card(
      key: const Key('dashboard-ai-suggestion-card'),
      color: isHigh
          ? theme.colorScheme.errorContainer.withValues(alpha: 0.3)
          : theme.colorScheme.primaryContainer.withValues(alpha: 0.25),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  size: 20,
                  color: isHigh
                      ? theme.colorScheme.error
                      : theme.colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.s),
                Expanded(
                  child: Text(
                    suggestion.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isHigh)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Ưu tiên',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onError,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.s),
            Text(suggestion.message, style: theme.textTheme.bodyMedium),
            if (suggestion.actionLabel != null &&
                suggestion.actionRoute != null) ...[
              const SizedBox(height: AppSpacing.s),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.tonal(
                  key: const Key('suggestion-action-button'),
                  onPressed: () => context.push(suggestion.actionRoute!),
                  child: Text(suggestion.actionLabel!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
