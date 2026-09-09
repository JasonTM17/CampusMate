import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:serverpod/serverpod.dart';

import '../academic/academic_read_service.dart';
import '../auth/campusmate_auth.dart';
import '../generated/protocol.dart';
import '../lending/lending_service.dart';
import 'memory/ai_preference_service.dart';

class StudySuggestionService {
  StudySuggestionService({
    AiPreferenceService? preferences,
    AcademicReadService? academic,
    LendingService? lending,
  }) : _preferences = preferences ?? AiPreferenceService(),
       _academic = academic ?? AcademicReadService(),
       _lending = lending ?? LendingService();

  final AiPreferenceService _preferences;
  final AcademicReadService _academic;
  final LendingService _lending;

  /// Generates a personalized study suggestion for the student based on real
  /// academic schedule, upcoming exams, or library loans.
  Future<StudySuggestion?> getSuggestion(
    Session session, {
    DateTime? now,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    final reference = (now ?? CampusClock.nowUtc()).toUtc();

    final pref = await _preferences.getPreferences(session, userId: userId);
    if (!pref.personalizationEnabled) return null;

    // 1. Check upcoming exams (within 14 days)
    try {
      final exams = await _academic.getUpcomingExams(session, now: reference);
      if (exams.isNotEmpty) {
        final exam = exams.first;
        final diffDays = exam.startsAt.difference(reference).inDays;
        if (diffDays <= 14) {
          final dateStr =
              '${exam.startsAt.day.toString().padLeft(2, '0')}/${exam.startsAt.month.toString().padLeft(2, '0')}';
          final message = diffDays <= 0
              ? 'Bạn có lịch thi môn ${exam.title} hôm nay. Chúc bạn làm bài thật tốt!'
              : (diffDays == 1
                    ? 'Kỳ thi môn ${exam.title} diễn ra vào ngày mai. Hãy kiểm tra lại phòng thi và ôn lại kiến thức trọng tâm.'
                    : 'Kỳ thi môn ${exam.title} vào ngày $dateStr (còn $diffDays ngày). Lên kế hoạch ôn tập ngay hôm nay nhé!');
          return StudySuggestion(
            title: 'Ôn thi ${exam.title}',
            message: message,
            priority: 'high',
            actionLabel: 'Xem lịch thi',
            actionRoute: '/academic',
          );
        }
      }
    } catch (_) {}

    // 2. Check active loans (overdue or due within 2 days)
    try {
      final loanPage = await _lending.myLoans(
        session,
        limit: 5,
        activeOnly: true,
      );
      for (final loan in loanPage.items) {
        if (loan.isOverdue) {
          return StudySuggestion(
            title: 'Sách mượn đã quá hạn',
            message:
                'Sách "${loan.title}" đã quá hạn trả. Hãy hoàn trả tại thư viện để duy trì quyền mượn sách.',
            priority: 'high',
            actionLabel: 'Xem mượn sách',
            actionRoute: '/library/loans',
          );
        }
        final dueDiff = loan.dueAt.difference(reference).inDays;
        if (dueDiff <= 2) {
          final dueStr =
              '${loan.dueAt.day.toString().padLeft(2, '0')}/${loan.dueAt.month.toString().padLeft(2, '0')}';
          return StudySuggestion(
            title: 'Sắp đến hạn trả sách',
            message:
                'Sách "${loan.title}" sẽ hết hạn vào ngày $dueStr. Đừng quên gia hạn hoặc trả sách nhé.',
            priority: 'high',
            actionLabel: 'Xem mượn sách',
            actionRoute: '/library/loans',
          );
        }
      }
    } catch (_) {}

    // 3. Check today's classes
    try {
      final todayClasses = await _academic.getDailyTimetable(
        session,
        day: reference,
        now: reference,
      );
      if (todayClasses.isNotEmpty) {
        return StudySuggestion(
          title: 'Lịch học hôm nay',
          message:
              'Hôm nay bạn có ${todayClasses.length} môn học theo thời khóa biểu. Hãy chuẩn bị bài trước khi vào lớp nhé!',
          priority: 'normal',
          actionLabel: 'Thời khóa biểu',
          actionRoute: '/academic',
        );
      }
    } catch (_) {}

    // 4. Default study encouragement if student is enrolled in courses
    try {
      final overview = await _academic.getOverview(session);
      if (overview.courses.isNotEmpty) {
        return StudySuggestion(
          title: 'Gợi ý học tập AI',
          message:
              'Bạn có thắc mắc bài học hoặc cần tóm tắt kiến thức? Trợ lý AI CampusMate luôn sẵn sàng hỗ trợ.',
          priority: 'low',
          actionLabel: 'Hỏi trợ lý AI',
          actionRoute: '/ai',
        );
      }
    } catch (_) {}

    return null;
  }
}
