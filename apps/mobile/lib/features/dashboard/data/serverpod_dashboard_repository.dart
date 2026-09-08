import 'package:campusmate_client/campusmate_client.dart';

import '../domain/dashboard_repository.dart';

class ServerpodDashboardRepository implements DashboardRepository {
  const ServerpodDashboardRepository(this._client);

  final Client _client;

  @override
  Future<DashboardGreeting> loadGreeting({DateTime? now}) =>
      _client.dashboard.getGreeting(now: now);

  @override
  Future<DashboardAcademicSummary> loadAcademicSummary() =>
      _client.dashboard.getAcademicSummary();

  @override
  Future<List<TimetableEntry>> loadTodayClasses({DateTime? now}) =>
      _client.dashboard.getTodayClasses(now: now);

  @override
  Future<TimetableEntry?> loadNextClass({DateTime? now}) =>
      _client.dashboard.getNextClass(now: now);

  @override
  Future<ExamSummary?> loadUpcomingExam({DateTime? now}) =>
      _client.dashboard.getUpcomingExam(now: now);

  @override
  Future<List<AnnouncementSummary>> loadAnnouncements({int limit = 5}) =>
      _client.dashboard.getAnnouncements(limit: limit);
}
