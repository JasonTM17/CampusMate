import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:serverpod/serverpod.dart';

import '../../academic/academic_read_service.dart';
import '../../auth/campusmate_auth.dart';
import '../../generated/protocol.dart';
import '../../lending/lending_service.dart';
import '../memory/ai_memory_service.dart';
import '../memory/ai_preference_service.dart';

/// Builds a personalized, budget-constrained context for the student (§27).
///
/// Follows the least-data principle:
/// - Only includes relevant layers.
/// - Hard token/character budget per layer so prompt size never explodes.
/// - Strictly scoped to caller identity (tenant isolation).
/// - If personalization is disabled, emits minimal prompt context.
class StudentContextBuilder {
  StudentContextBuilder({
    AiPreferenceService? preferences,
    AiMemoryService? memories,
    AcademicReadService? academic,
    LendingService? lending,
  }) : _preferences = preferences ?? AiPreferenceService(),
       _memories = memories ?? AiMemoryService(preferences: preferences),
       _academic = academic ?? AcademicReadService(),
       _lending = lending ?? LendingService();

  final AiPreferenceService _preferences;
  final AiMemoryService _memories;
  final AcademicReadService _academic;
  final LendingService _lending;

  /// Builds prompt context for the authenticated caller.
  Future<String?> buildContext(
    Session session, {
    int? bookId,
    String? selectedText,
    DateTime? now,
  }) async {
    final userId = CampusMateAuth.requireUserId(session);
    final reference = (now ?? CampusClock.nowUtc()).toUtc();

    final pref = await _preferences.getPreferences(session, userId: userId);

    // If personalization is disabled, emit minimal instructions (only style, no student records)
    if (!pref.personalizationEnabled) {
      if (pref.explanationStyle != 'standard') {
        return _formatExplanationStyle(pref.explanationStyle);
      }
      return null;
    }

    final buffer = StringBuffer();

    // 1. Identity layer (max ~150 chars)
    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
    );
    if (profile != null) {
      final name = profile.fullName?.trim();
      final code = profile.studentCode?.trim();
      final faculty = profile.faculty?.trim() ?? profile.major?.trim();
      final className = profile.className?.trim();
      final parts = <String>[];
      if (name != null && name.isNotEmpty) parts.add('Họ tên: $name');
      if (code != null && code.isNotEmpty) parts.add('MSSV: $code');
      if (faculty != null && faculty.isNotEmpty) parts.add('Ngành: $faculty');
      if (className != null && className.isNotEmpty) {
        parts.add('Lớp: $className');
      }
      if (parts.isNotEmpty) {
        buffer.writeln('[Hồ sơ sinh viên]');
        buffer.writeln(parts.join(' | '));
        buffer.writeln();
      }
    }

    // 2. Preferences layer (max ~100 chars)
    if (pref.explanationStyle != 'standard') {
      buffer.writeln(_formatExplanationStyle(pref.explanationStyle));
      buffer.writeln();
    }

    // 3. Academic & Exams layer (max ~400 chars)
    try {
      final academicOverview = await _academic.getOverview(session);
      final academicParts = <String>[];

      if (academicOverview.courses.isNotEmpty) {
        final courseNames = academicOverview.courses
            .take(5)
            .map((c) => c.title)
            .join(', ');
        academicParts.add('Môn đang học: $courseNames');
      }

      academicParts.add(
        'GPA kỳ: ${academicOverview.semesterGpa.toStringAsFixed(2)}',
      );

      if (academicParts.isNotEmpty) {
        buffer.writeln('[Học tập hiện tại]');
        buffer.writeln(academicParts.join(' | '));
      }

      if (academicOverview.upcomingExams.isNotEmpty) {
        buffer.writeln('Kỳ thi sắp tới:');
        for (final exam in academicOverview.upcomingExams.take(3)) {
          final dateStr =
              '${exam.startsAt.day.toString().padLeft(2, '0')}/${exam.startsAt.month.toString().padLeft(2, '0')}';
          buffer.writeln('- ${exam.title}: ngày $dateStr (phòng ${exam.room})');
        }
      }
      if (academicParts.isNotEmpty ||
          academicOverview.upcomingExams.isNotEmpty) {
        buffer.writeln();
      }
    } catch (_) {
      // Academic layer unavailable: continue gracefully
    }

    // 4. Schedule layer (today's timetable, max ~250 chars)
    try {
      final todayClasses = await _academic.getDailyTimetable(
        session,
        day: reference,
        now: reference,
      );
      if (todayClasses.isNotEmpty) {
        buffer.writeln('[Lịch học hôm nay]');
        for (final entry in todayClasses.take(4)) {
          buffer.writeln(
            '- ${entry.title}: ${entry.room} '
            '(${entry.startsAt.hour}:${entry.startsAt.minute.toString().padLeft(2, '0')} - '
            '${entry.endsAt.hour}:${entry.endsAt.minute.toString().padLeft(2, '0')})',
          );
        }
        buffer.writeln();
      }
    } catch (_) {
      // Schedule layer unavailable: continue gracefully
    }

    // 5. Library loans layer (max ~200 chars)
    try {
      final loanPage = await _lending.myLoans(
        session,
        limit: 3,
        activeOnly: true,
      );
      if (loanPage.items.isNotEmpty) {
        buffer.writeln('[Mượn sách thư viện]');
        for (final loan in loanPage.items.take(3)) {
          final dueStr =
              '${loan.dueAt.day.toString().padLeft(2, '0')}/${loan.dueAt.month.toString().padLeft(2, '0')}';
          buffer.writeln(
            '- ${loan.title} (hạn trả: $dueStr'
            '${loan.isOverdue ? ' - ĐÃ QUÁ HẠN' : ''})',
          );
        }
        buffer.writeln();
      }
    } catch (_) {
      // Lending layer unavailable: continue gracefully
    }

    // 6. User Memories layer (max ~400 chars, only active memories)
    if (pref.memoryEnabled) {
      try {
        final memories = await _memories.listMemories(
          session,
          userId: userId,
          activeOnly: true,
        );
        if (memories.isNotEmpty) {
          buffer.writeln('[Ghi nhớ cá nhân]');
          for (final m in memories.take(5)) {
            final truncated = m.content.length > 100
                ? '${m.content.substring(0, 100)}...'
                : m.content;
            buffer.writeln('- $truncated');
          }
          buffer.writeln();
        }
      } catch (_) {
        // Memory layer unavailable: continue gracefully
      }
    }

    // 7. Book / Document Chat context layer (max ~400 chars)
    if (bookId != null ||
        (selectedText != null && selectedText.trim().isNotEmpty)) {
      try {
        buffer.writeln('[Tài liệu đang đọc]');
        if (bookId != null) {
          final book = await LibraryBook.db.findById(session, bookId);
          if (book != null) {
            buffer.writeln('Tựa sách: ${book.title}');
          }
        }
        if (selectedText != null && selectedText.trim().isNotEmpty) {
          final cleanExcerpt = selectedText.trim();
          final excerpt = cleanExcerpt.length > 250
              ? '${cleanExcerpt.substring(0, 250)}...'
              : cleanExcerpt;
          buffer.writeln('Đoạn trích người dùng đang chọn: "$excerpt"');
        }
        buffer.writeln();
      } catch (_) {
        // Book context unavailable: continue gracefully
      }
    }

    final result = buffer.toString().trim();
    return result.isEmpty ? null : result;
  }

  static String _formatExplanationStyle(String style) {
    return switch (style) {
      'concise' =>
        '[Phong cách giải thích]: Trả lời ngắn gọn, đi thẳng vào trọng tâm, dùng bullet points khi có thể.',
      'detailed' =>
        '[Phong cách giải thích]: Giải thích chi tiết, từng bước kèm ví dụ minh họa và phân tích nguyên lý.',
      'socratic' =>
        '[Phong cách giải thích]: Sử dụng phương pháp gợi mở (Socratic), đặt câu hỏi để người học tự tư duy.',
      'eli5' =>
        '[Phong cách giải thích]: Giải thích đơn giản, dễ hiểu như cho người mới bắt đầu (ELI5), dùng ẩn dụ đời thường.',
      _ => '',
    };
  }
}
