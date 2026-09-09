import 'package:campusmate_client/campusmate_client.dart';
import 'package:campusmate_shared/campusmate_shared.dart' show CampusClock;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../application/academic_controller.dart';

final examDetailProvider = FutureProvider.autoDispose.family<ExamSummary, int>((
  ref,
  examId,
) {
  return ref.watch(academicRepositoryProvider).loadExamDetail(examId: examId);
});

class ExamDetailScreen extends ConsumerWidget {
  const ExamDetailScreen({super.key, required this.examId});

  final int examId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(examDetailProvider(examId));
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết lịch thi')),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => AppEmptyState(
          icon: Icons.assignment_late_outlined,
          title: 'Không mở được lịch thi',
          message:
              'Lịch thi này không tồn tại hoặc không thuộc tài khoản của bạn.',
          actionLabel: 'Thử lại',
          onAction: () => ref.invalidate(examDetailProvider(examId)),
        ),
        data: (exam) => ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.cardPadding,
            AppSpacing.m,
            AppSpacing.cardPadding,
            AppSpacing.xl,
          ),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.m),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${exam.courseCode} · ${exam.title}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      exam.examType,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.m),
                    _DetailRow(
                      icon: Icons.event_outlined,
                      label: 'Ngày thi',
                      value: _dateText(exam.startsAt),
                    ),
                    _DetailRow(
                      icon: Icons.schedule,
                      label: 'Thời gian',
                      value:
                          '${_minuteText(CampusClock.campusMinuteOfDay(exam.startsAt))}-${_minuteText(CampusClock.campusMinuteOfDay(exam.endsAt))}',
                    ),
                    _DetailRow(
                      icon: Icons.meeting_room_outlined,
                      label: 'Phòng',
                      value: exam.room,
                    ),
                    _DetailRow(
                      icon: Icons.hourglass_bottom_outlined,
                      label: 'Còn lại',
                      value: '${exam.daysUntil} ngày',
                    ),
                    if (exam.notes?.isNotEmpty == true)
                      _DetailRow(
                        icon: Icons.notes_outlined,
                        label: 'Ghi chú',
                        value: exam.notes!,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.m),
            FilledButton.icon(
              onPressed: () {
                final encodedTitle = Uri.encodeComponent(
                  'Ôn thi môn ${exam.courseCode} - ${exam.title}',
                );
                context.push('/ai?title=$encodedTitle');
              },
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Lập kế hoạch ôn thi với AI'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}

String _dateText(DateTime value) {
  final local = value.toLocal();
  final day = local.day.toString().padLeft(2, '0');
  final month = local.month.toString().padLeft(2, '0');
  return '$day/$month/${local.year}';
}

String _minuteText(int minuteOfDay) {
  final hour = (minuteOfDay ~/ 60).toString().padLeft(2, '0');
  final minute = (minuteOfDay % 60).toString().padLeft(2, '0');
  return '$hour:$minute';
}
