import 'package:campusmate_client/campusmate_client.dart';

abstract interface class DashboardRepository {
  Future<DashboardGreeting> loadGreeting({DateTime? now});

  Future<DashboardAcademicSummary> loadAcademicSummary();

  Future<List<TimetableEntry>> loadTodayClasses({DateTime? now});

  Future<TimetableEntry?> loadNextClass({DateTime? now});

  Future<ExamSummary?> loadUpcomingExam({DateTime? now});

  Future<List<AnnouncementSummary>> loadAnnouncements({int limit = 5});
}
