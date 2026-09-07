import 'package:campusmate_client/campusmate_client.dart';

class AcademicSnapshot {
  const AcademicSnapshot({
    required this.overview,
    required this.weeklyTimetable,
    required this.grades,
    required this.isFromCache,
    required this.cachedAt,
  });

  final AcademicOverview overview;
  final List<TimetableEntry> weeklyTimetable;
  final GradeSummary grades;
  final bool isFromCache;
  final DateTime cachedAt;
}

abstract interface class AcademicRepository {
  Future<AcademicSnapshot> loadDashboard({
    required String accountId,
    DateTime? now,
    DateTime? weekStart,
    int? semesterId,
  });

  Future<CourseDetail> loadCourseDetail({required int offeringId});
}
