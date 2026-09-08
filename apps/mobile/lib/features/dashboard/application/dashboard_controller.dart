import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../data/serverpod_dashboard_repository.dart';
import '../domain/dashboard_repository.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>(
  (ref) => ServerpodDashboardRepository(ref.watch(serverpodClientProvider)),
);

final dashboardGreetingProvider = FutureProvider.autoDispose<DashboardGreeting>(
  (ref) => ref.watch(dashboardRepositoryProvider).loadGreeting(),
);

final dashboardAcademicSummaryProvider =
    FutureProvider.autoDispose<DashboardAcademicSummary>(
      (ref) => ref.watch(dashboardRepositoryProvider).loadAcademicSummary(),
    );

final dashboardTodayClassesProvider =
    FutureProvider.autoDispose<List<TimetableEntry>>(
      (ref) => ref.watch(dashboardRepositoryProvider).loadTodayClasses(),
    );

final dashboardNextClassProvider = FutureProvider.autoDispose<TimetableEntry?>(
  (ref) => ref.watch(dashboardRepositoryProvider).loadNextClass(),
);

final dashboardUpcomingExamProvider = FutureProvider.autoDispose<ExamSummary?>(
  (ref) => ref.watch(dashboardRepositoryProvider).loadUpcomingExam(),
);

final dashboardAnnouncementsProvider =
    FutureProvider.autoDispose<List<AnnouncementSummary>>(
      (ref) => ref.watch(dashboardRepositoryProvider).loadAnnouncements(),
    );

void refreshDashboardSections(WidgetRef ref) {
  ref
    ..invalidate(dashboardGreetingProvider)
    ..invalidate(dashboardAcademicSummaryProvider)
    ..invalidate(dashboardTodayClassesProvider)
    ..invalidate(dashboardNextClassProvider)
    ..invalidate(dashboardUpcomingExamProvider)
    ..invalidate(dashboardAnnouncementsProvider);
}
