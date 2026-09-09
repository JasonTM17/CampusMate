import 'package:campusmate_client/campusmate_client.dart';
import 'package:campusmate_shared/campusmate_shared.dart' show CampusClock;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../application/academic_controller.dart';
import '../domain/academic_repository.dart';

class AcademicScreen extends ConsumerStatefulWidget {
  const AcademicScreen({super.key});

  @override
  ConsumerState<AcademicScreen> createState() => _AcademicScreenState();
}

class _AcademicScreenState extends ConsumerState<AcademicScreen> {
  late DateTime _selectedWeekStart = _startOfWeekUtc(CampusClock.nowUtc());
  late DateTime _selectedDay = _startOfDayUtc(CampusClock.nowUtc());
  bool _showDay = false;
  int? _selectedSemesterId;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(academicControllerProvider);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Học tập'),
          actions: [
            IconButton(
              tooltip: 'Làm mới',
              onPressed: state.isLoading ? null : () => _loadSelection(),
              icon: const Icon(Icons.refresh),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Tổng quan'),
              Tab(text: 'Lịch học'),
              Tab(text: 'Điểm'),
              Tab(text: 'Thi'),
            ],
          ),
        ),
        body: state.when(
          loading: () => const _AcademicSkeleton(),
          error: (error, stackTrace) => AppEmptyState(
            icon: Icons.cloud_off_outlined,
            title: 'Không tải được dữ liệu học tập',
            message: 'Kiểm tra kết nối rồi thử lại.',
            actionLabel: 'Thử lại',
            onAction: () => ref.invalidate(academicControllerProvider),
          ),
          data: (snapshot) => TabBarView(
            children: [
              _OverviewTab(snapshot: snapshot, onRefresh: _loadSelection),
              _TimetableTab(
                snapshot: snapshot,
                selectedWeekStart: _selectedWeekStart,
                selectedDay: _selectedDay,
                showDay: _showDay,
                onModeChanged: (showDay) => setState(() => _showDay = showDay),
                onDayChanged: (day) => setState(() => _selectedDay = day),
                onPreviousWeek: () => _moveWeek(-1),
                onNextWeek: () => _moveWeek(1),
                onToday: _goToToday,
                onRefresh: _loadSelection,
              ),
              _GradesTab(
                snapshot: snapshot,
                selectedSemesterId:
                    _selectedSemesterId ?? snapshot.overview.currentSemester.id,
                onSemesterChanged: (semesterId) {
                  _selectedSemesterId = semesterId;
                  _loadSelection();
                },
                onRefresh: _loadSelection,
              ),
              _ExamsTab(snapshot: snapshot, onRefresh: _loadSelection),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadSelection() => ref
      .read(academicControllerProvider.notifier)
      .loadFor(weekStart: _selectedWeekStart, semesterId: _selectedSemesterId);

  Future<void> _moveWeek(int delta) async {
    setState(() {
      _selectedWeekStart = _selectedWeekStart.add(Duration(days: delta * 7));
      _selectedDay = _selectedWeekStart;
    });
    await _loadSelection();
  }

  Future<void> _goToToday() async {
    setState(() {
      final now = CampusClock.nowUtc();
      _selectedWeekStart = _startOfWeekUtc(now);
      _selectedDay = _startOfDayUtc(now);
    });
    await _loadSelection();
  }
}

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({required this.snapshot, required this.onRefresh});

  final AcademicSnapshot snapshot;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final overview = snapshot.overview;
    return _AcademicList(
      snapshot: snapshot,
      onRefresh: onRefresh,
      children: [
        _MetricGrid(
          metrics: [
            _Metric('GPA kỳ', overview.semesterGpa.toStringAsFixed(2)),
            _Metric('GPA tích lũy', overview.cumulativeGpa.toStringAsFixed(2)),
            _Metric(
              'Tín chỉ',
              '${overview.creditsEarned}/${overview.creditsRequired}',
            ),
            _Metric('Môn đang học', '${overview.courses.length}'),
          ],
        ),
        const _SectionHeading('Môn học hiện tại'),
        if (overview.courses.isEmpty)
          const AppEmptyState(
            icon: Icons.menu_book_outlined,
            title: 'Chưa có môn học',
            message: 'Dữ liệu sẽ xuất hiện sau khi phòng đào tạo đồng bộ.',
          )
        else
          for (final course in overview.courses)
            _CourseCard(
              course: course,
              onTap: () => _showCourseDetail(context, course.offeringId),
            ),
        const _SectionHeading('Tiến độ chương trình'),
        _ProgressSummary(progress: overview.progress),
      ],
    );
  }
}

class _TimetableTab extends StatelessWidget {
  const _TimetableTab({
    required this.snapshot,
    required this.selectedWeekStart,
    required this.selectedDay,
    required this.showDay,
    required this.onModeChanged,
    required this.onDayChanged,
    required this.onPreviousWeek,
    required this.onNextWeek,
    required this.onToday,
    required this.onRefresh,
  });

  final AcademicSnapshot snapshot;
  final DateTime selectedWeekStart;
  final DateTime selectedDay;
  final bool showDay;
  final ValueChanged<bool> onModeChanged;
  final ValueChanged<DateTime> onDayChanged;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;
  final VoidCallback onToday;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final entries = showDay
        ? snapshot.weeklyTimetable
              .where(
                (row) => row.weekday == CampusClock.campusWeekday(selectedDay),
              )
              .toList()
        : snapshot.weeklyTimetable;
    final conflicts = <String, int>{};
    for (final entry in entries) {
      final key = '${entry.weekday}-${entry.startMinute}';
      conflicts.update(key, (count) => count + 1, ifAbsent: () => 1);
    }

    return _AcademicList(
      snapshot: snapshot,
      onRefresh: onRefresh,
      children: [
        _TimetableToolbar(
          selectedWeekStart: selectedWeekStart,
          selectedDay: selectedDay,
          showDay: showDay,
          onModeChanged: onModeChanged,
          onDayChanged: onDayChanged,
          onPreviousWeek: onPreviousWeek,
          onNextWeek: onNextWeek,
          onToday: onToday,
        ),
        if (entries.isEmpty)
          const AppEmptyState(
            icon: Icons.event_busy_outlined,
            title: 'Tuần này chưa có lịch',
            message: 'Khi có lớp học, lịch tuần sẽ hiển thị tại đây.',
          )
        else
          for (final entry in entries)
            _TimetableCard(
              entry: entry,
              hasConflict:
                  (conflicts['${entry.weekday}-${entry.startMinute}'] ?? 0) > 1,
            ),
      ],
    );
  }
}

class _GradesTab extends StatelessWidget {
  const _GradesTab({
    required this.snapshot,
    required this.selectedSemesterId,
    required this.onSemesterChanged,
    required this.onRefresh,
  });

  final AcademicSnapshot snapshot;
  final int selectedSemesterId;
  final ValueChanged<int> onSemesterChanged;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final grades = snapshot.grades;
    return _AcademicList(
      snapshot: snapshot,
      onRefresh: onRefresh,
      children: [
        DropdownButtonFormField<int>(
          initialValue: selectedSemesterId,
          decoration: const InputDecoration(labelText: 'Học kỳ'),
          items: [
            for (final semester in snapshot.overview.availableSemesters)
              DropdownMenuItem(value: semester.id, child: Text(semester.name)),
          ],
          onChanged: (value) {
            if (value != null) onSemesterChanged(value);
          },
        ),
        const SizedBox(height: AppSpacing.m),
        _MetricGrid(
          metrics: [
            _Metric('GPA kỳ', grades.semesterGpa.toStringAsFixed(2)),
            _Metric('Tích lũy', grades.cumulativeGpa.toStringAsFixed(2)),
            _Metric('Đạt', '${grades.creditsEarned} tín chỉ'),
            _Metric('Đăng ký', '${grades.creditsAttempted} tín chỉ'),
          ],
        ),
        if (grades.courses.isEmpty)
          const AppEmptyState(
            icon: Icons.grade_outlined,
            title: 'Chưa có điểm',
            message: 'Điểm thành phần sẽ xuất hiện sau khi giảng viên nhập.',
          )
        else
          for (final course in grades.courses) _CourseCard(course: course),
      ],
    );
  }
}

class _ExamsTab extends StatelessWidget {
  const _ExamsTab({required this.snapshot, required this.onRefresh});

  final AcademicSnapshot snapshot;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final exams = snapshot.overview.upcomingExams;
    return _AcademicList(
      snapshot: snapshot,
      onRefresh: onRefresh,
      children: [
        if (exams.isEmpty)
          const AppEmptyState(
            icon: Icons.event_available_outlined,
            title: 'Chưa có lịch thi',
            message: 'Lịch thi sắp tới sẽ được đồng bộ khi có dữ liệu.',
          )
        else
          for (final exam in exams) _ExamCard(exam: exam),
      ],
    );
  }
}

class _AcademicList extends ConsumerWidget {
  const _AcademicList({
    required this.snapshot,
    required this.children,
    required this.onRefresh,
  });

  final AcademicSnapshot snapshot;
  final List<Widget> children;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.cardPadding,
          AppSpacing.m,
          AppSpacing.cardPadding,
          AppSpacing.xl,
        ),
        children: [
          if (snapshot.isFromCache) _OfflineBanner(cachedAt: snapshot.cachedAt),
          ...children,
        ],
      ),
    );
  }
}

class _TimetableToolbar extends StatelessWidget {
  const _TimetableToolbar({
    required this.selectedWeekStart,
    required this.selectedDay,
    required this.showDay,
    required this.onModeChanged,
    required this.onDayChanged,
    required this.onPreviousWeek,
    required this.onNextWeek,
    required this.onToday,
  });

  final DateTime selectedWeekStart;
  final DateTime selectedDay;
  final bool showDay;
  final ValueChanged<bool> onModeChanged;
  final ValueChanged<DateTime> onDayChanged;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;
  final VoidCallback onToday;

  @override
  Widget build(BuildContext context) {
    final days = [
      for (var i = 0; i < 5; i++) selectedWeekStart.add(Duration(days: i)),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedButton<bool>(
          segments: const [
            ButtonSegment(
              value: false,
              icon: Icon(Icons.view_week_outlined),
              label: Text('Tuần'),
            ),
            ButtonSegment(
              value: true,
              icon: Icon(Icons.today_outlined),
              label: Text('Ngày'),
            ),
          ],
          selected: {showDay},
          onSelectionChanged: (value) => onModeChanged(value.single),
        ),
        const SizedBox(height: AppSpacing.s),
        Row(
          children: [
            IconButton(
              tooltip: 'Tuần trước',
              onPressed: onPreviousWeek,
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: Center(
                child: Text(
                  '${_dateText(selectedWeekStart)} - ${_dateText(selectedWeekStart.add(const Duration(days: 6)))}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            IconButton(
              tooltip: 'Tuần sau',
              onPressed: onNextWeek,
              icon: const Icon(Icons.chevron_right),
            ),
            TextButton(onPressed: onToday, child: const Text('Hôm nay')),
          ],
        ),
        if (showDay)
          Wrap(
            spacing: AppSpacing.xs,
            children: [
              for (final day in days)
                ChoiceChip(
                  label: Text(_weekdayText(CampusClock.campusWeekday(day))),
                  selected: _sameDay(day, selectedDay),
                  onSelected: (_) => onDayChanged(day),
                ),
            ],
          ),
        const SizedBox(height: AppSpacing.s),
      ],
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.metrics});

  final List<_Metric> metrics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: metrics.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 104,
        crossAxisSpacing: AppSpacing.s,
        mainAxisSpacing: AppSpacing.s,
      ),
      itemBuilder: (context, index) {
        final metric = metrics[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  metric.label,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  metric.value,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.course, this.onTap});

  final CourseSummary course;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(child: Text(course.courseCode.characters.first)),
        title: Text('${course.courseCode} · ${course.title}'),
        subtitle: Text(
          '${course.lecturerName} · ${course.credits} tín chỉ · ${course.section}',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              course.finalScore?.toStringAsFixed(1) ?? '--',
              style: theme.textTheme.titleMedium,
            ),
            Text(course.letter ?? 'Đang học', style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _TimetableCard extends StatelessWidget {
  const _TimetableCard({required this.entry, required this.hasConflict});

  final TimetableEntry entry;
  final bool hasConflict;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      color: entry.isCurrent ? colorScheme.primaryContainer : null,
      child: ListTile(
        leading: const Icon(Icons.schedule),
        title: Text('${_weekdayText(entry.weekday)} · ${entry.courseCode}'),
        subtitle: Text(
          '${_minuteText(entry.startMinute)}-${_minuteText(entry.endMinute)} · ${entry.room} · ${entry.campus}',
        ),
        trailing: Wrap(
          spacing: AppSpacing.xs,
          children: [
            if (entry.isCurrent) const _SmallChip(label: 'Đang học'),
            if (hasConflict) const _SmallChip(label: 'Trùng lịch'),
          ],
        ),
      ),
    );
  }
}

class _ExamCard extends StatelessWidget {
  const _ExamCard({required this.exam});

  final ExamSummary exam;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
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

class _ProgressSummary extends StatelessWidget {
  const _ProgressSummary({required this.progress});

  final CurriculumProgress progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: (progress.percentComplete / 100).clamp(0, 1).toDouble(),
        ),
        const SizedBox(height: AppSpacing.s),
        for (final block in progress.blocks)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(block.name),
            trailing: Text(
              '${block.creditsEarned}/${block.creditsRequired} tín chỉ',
            ),
          ),
      ],
    );
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner({required this.cachedAt});

  final DateTime cachedAt;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: ListTile(
        leading: const Icon(Icons.offline_bolt_outlined),
        title: const Text('Đang xem dữ liệu offline'),
        subtitle: Text('Đồng bộ lần cuối: ${_dateText(cachedAt)}'),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.l, bottom: AppSpacing.s),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class _SmallChip extends StatelessWidget {
  const _SmallChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label), visualDensity: VisualDensity.compact);
  }
}

class _AcademicSkeleton extends StatelessWidget {
  const _AcademicSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      itemCount: 5,
      itemBuilder: (context, index) => const Card(child: SizedBox(height: 86)),
    );
  }
}

class _CourseDetailSheet extends ConsumerWidget {
  const _CourseDetailSheet({required this.offeringId});

  final int offeringId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailFuture = ref
        .read(academicRepositoryProvider)
        .loadCourseDetail(offeringId: offeringId);
    return FutureBuilder<CourseDetail>(
      future: detailFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.cardPadding),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.cardPadding),
            child: AppEmptyState(
              icon: Icons.error_outline,
              title: 'Không tải được chi tiết môn',
              message: 'Kiểm tra kết nối rồi thử lại.',
            ),
          );
        }
        final detail = snapshot.data!;
        return ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.cardPadding,
            AppSpacing.m,
            AppSpacing.cardPadding,
            AppSpacing.xl,
          ),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${detail.summary.courseCode} · ${detail.summary.title}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  tooltip: 'Đóng',
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s),
            Text(detail.description),
            const _SectionHeading('Lịch học'),
            for (final schedule in detail.schedules)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.schedule),
                title: Text(_weekdayText(schedule.weekday)),
                subtitle: Text(
                  '${_minuteText(schedule.startMinute)}-${_minuteText(schedule.endMinute)} · ${schedule.room}',
                ),
              ),
            const _SectionHeading('Điểm thành phần'),
            if (detail.grades.isEmpty)
              const Text('Chưa có điểm thành phần.')
            else
              for (final grade in detail.grades)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(grade.name),
                  subtitle: Text('Trọng số ${(grade.weight * 100).round()}%'),
                  trailing: Text(grade.score.toStringAsFixed(1)),
                ),
            const _SectionHeading('Liên kết học tập & AI'),
            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.primaryContainer.withValues(
                alpha: 0.35,
              ),
              child: ListTile(
                leading: Icon(
                  Icons.auto_awesome,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Hỏi trợ lý AI về môn học này'),
                subtitle: Text(detail.askAiPlaceholder),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.of(context).pop();
                  final encodedTitle = Uri.encodeComponent(
                    '${detail.summary.courseCode} - ${detail.summary.title}',
                  );
                  context.push('/ai?title=$encodedTitle');
                },
              ),
            ),
            const SizedBox(height: AppSpacing.s),
            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: ListTile(
                leading: const Icon(Icons.menu_book_outlined),
                title: const Text('Tìm sách & giáo trình liên quan'),
                subtitle: Text(detail.relatedBooksPlaceholder),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.of(context).pop();
                  context.go('/library');
                },
              ),
            ),
            if (detail.documentsPlaceholder.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.s),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  detail.documentsPlaceholder,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _Metric {
  const _Metric(this.label, this.value);

  final String label;
  final String value;
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

DateTime _startOfWeekUtc(DateTime value) {
  return CampusClock.startOfCampusWeekUtc(value);
}

DateTime _startOfDayUtc(DateTime value) {
  return CampusClock.startOfCampusDayUtc(value);
}

bool _sameDay(DateTime left, DateTime right) {
  return CampusClock.isSameCampusDay(left, right);
}

void _showCourseDetail(BuildContext context, int offeringId) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (context) => _CourseDetailSheet(offeringId: offeringId),
  );
}
