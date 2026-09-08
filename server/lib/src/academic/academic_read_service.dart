import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../auth/campusmate_auth.dart';
import '../generated/protocol.dart';

class AcademicReadService {
  Future<AcademicOverview> getOverview(Session session) async {
    final now = CampusClock.nowUtc();
    final semester = await _currentSemester(session);
    final courses = await getCourses(session, semesterId: semester.id);
    final today = await getDailyTimetable(session, day: now, now: now);
    final exams = await getUpcomingExams(session, now: now);
    final grades = await getGrades(session, semesterId: semester.id);
    final progress = await getProgress(session);

    return AcademicOverview(
      currentSemester: semester,
      availableSemesters: await _availableSemesters(session),
      courses: courses,
      today: today,
      upcomingExams: exams,
      progress: progress,
      semesterGpa: grades.semesterGpa,
      cumulativeGpa: grades.cumulativeGpa,
      creditsEarned: progress.creditsEarned,
      creditsRequired: progress.creditsRequired,
      syncedAt: now,
    );
  }

  Future<List<CourseSummary>> getCourses(
    Session session, {
    int? semesterId,
  }) async {
    final view = await _loadStudentAcademicView(
      session,
      semesterId: semesterId,
    );
    return _courseSummaries(view);
  }

  Future<CourseDetail> getCourseDetail(
    Session session, {
    required int offeringId,
  }) async {
    final view = await _loadStudentAcademicView(session);
    final matches = view.enrollments.where(
      (row) => row.offeringId == offeringId,
    );
    final enrollment = matches.isEmpty ? null : matches.first;
    if (enrollment == null) {
      throw ServerpodClientException('Course not found', 404);
    }

    final offering = view.offeringsById[offeringId]!;
    final course = view.coursesById[offering.courseId]!;
    final summary = _courseSummary(view, enrollment, offering, course);
    return CourseDetail(
      summary: summary,
      description: course.description,
      faculty: course.faculty,
      department: course.department,
      schedules: _timetableEntries(view, offeringIds: {offeringId}),
      grades: _gradeScores(view, enrollment.id!),
      documentsPlaceholder: 'Tài liệu môn học sẽ được nối ở phase thư viện.',
      relatedBooksPlaceholder: 'Sách liên quan sẽ xuất hiện sau phase catalog.',
      askAiPlaceholder:
          'Ask AI dùng dữ liệu môn học sau phase personalized AI.',
    );
  }

  Future<List<TimetableEntry>> getWeeklyTimetable(
    Session session, {
    DateTime? weekStart,
    DateTime? now,
  }) async {
    final view = await _loadStudentAcademicView(session);
    final start = CampusClock.startOfCampusWeekUtc(
      weekStart ?? now ?? CampusClock.nowUtc(),
    );
    final end = start.add(const Duration(days: 7));
    return _timetableEntries(view, weekStart: start, weekEnd: end, now: now);
  }

  Future<List<TimetableEntry>> getDailyTimetable(
    Session session, {
    DateTime? day,
    DateTime? now,
  }) async {
    final view = await _loadStudentAcademicView(session);
    final date = CampusClock.startOfCampusDayUtc(
      day ?? now ?? CampusClock.nowUtc(),
    );
    final scheduleWeekStart = CampusClock.startOfCampusWeekUtc(date);
    return _timetableEntries(
      view,
      weekStart: date,
      weekEnd: date.add(const Duration(days: 1)),
      occurrenceWeekStart: scheduleWeekStart,
      now: now,
      weekday: CampusClock.campusWeekday(date),
    );
  }

  Future<GradeSummary> getGrades(Session session, {int? semesterId}) async {
    final view = await _loadStudentAcademicView(
      session,
      semesterId: semesterId,
    );
    final semester = semesterId == null
        ? await _currentSemester(session)
        : await _semesterSummary(session, semesterId);
    final courses = _courseSummaries(view);
    final inputs = courses
        .where((course) => course.finalScore != null)
        .map(
          (course) => GradeCourseInput(
            credits: course.credits,
            finalScore: course.finalScore!,
          ),
        );
    final semesterResult = const GpaCalculator().calculate(inputs);

    final allView = await _loadStudentAcademicView(session);
    final allCourses = _courseSummaries(allView);
    final cumulative = const GpaCalculator().calculate(
      allCourses
          .where((course) => course.finalScore != null)
          .map(
            (course) => GradeCourseInput(
              credits: course.credits,
              finalScore: course.finalScore!,
            ),
          ),
    );

    return GradeSummary(
      semester: semester,
      courses: courses,
      semesterGpa: semesterResult.gpa,
      cumulativeGpa: cumulative.gpa,
      creditsEarned: cumulative.earnedCredits,
      creditsAttempted: cumulative.attemptedCredits,
    );
  }

  Future<List<ExamSummary>> getUpcomingExams(
    Session session, {
    DateTime? now,
  }) async {
    final view = await _loadStudentAcademicView(session);
    final reference = now ?? CampusClock.nowUtc();
    final offeringIds = view.enrollments.map((row) => row.offeringId).toSet();
    final exams =
        view.exams
            .where(
              (exam) =>
                  offeringIds.contains(exam.offeringId) &&
                  !exam.startsAt.isBefore(
                    CampusClock.startOfCampusDayUtc(reference),
                  ),
            )
            .toList()
          ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
    return exams.map((exam) => _examSummary(view, exam, reference)).toList();
  }

  Future<ExamSummary> getExamDetail(
    Session session, {
    required int examId,
    DateTime? now,
  }) async {
    final view = await _loadStudentAcademicView(session);
    final matches = view.exams.where((row) => row.id == examId);
    final exam = matches.isEmpty ? null : matches.first;
    if (exam == null) {
      throw ServerpodClientException('Exam not found', 404);
    }

    return _examSummary(view, exam, now ?? CampusClock.nowUtc());
  }

  Future<CurriculumProgress> getProgress(Session session) async {
    final view = await _loadStudentAcademicView(session);
    final courses = _courseSummaries(view);
    final calculator = const GpaCalculator();
    final result = calculator.calculate(
      courses
          .where((course) => course.finalScore != null)
          .map(
            (course) => GradeCourseInput(
              credits: course.credits,
              finalScore: course.finalScore!,
            ),
          ),
    );
    const requiredCredits = 140;
    final earnedByFaculty = <String, int>{};
    for (final course in courses) {
      if (course.finalScore == null ||
          !calculator.policy.isPassing(course.finalScore!)) {
        continue;
      }
      final offering = view.offeringsById[course.offeringId]!;
      final fullCourse = view.coursesById[offering.courseId]!;
      earnedByFaculty.update(
        fullCourse.department,
        (value) => value + course.credits,
        ifAbsent: () => course.credits,
      );
    }

    final blocks = [
      CurriculumBlockProgress(
        name: 'Đại cương',
        creditsEarned: earnedByFaculty['Đại cương'] ?? 0,
        creditsRequired: 32,
      ),
      CurriculumBlockProgress(
        name: 'Cơ sở ngành',
        creditsEarned: earnedByFaculty['Cơ sở ngành'] ?? 0,
        creditsRequired: 48,
      ),
      CurriculumBlockProgress(
        name: 'Chuyên ngành',
        creditsEarned: earnedByFaculty['Chuyên ngành'] ?? 0,
        creditsRequired: 60,
      ),
    ];
    return CurriculumProgress(
      blocks: blocks,
      creditsEarned: result.earnedCredits,
      creditsRequired: requiredCredits,
      percentComplete: double.parse(
        ((result.earnedCredits / requiredCredits) * 100).toStringAsFixed(1),
      ),
    );
  }

  Future<_StudentAcademicView> _loadStudentAcademicView(
    Session session, {
    int? semesterId,
  }) async {
    final profile = await _requireStudentProfile(session);
    final enrollments = await Enrollment.db.find(
      session,
      where: (t) => t.studentProfileId.equals(profile.id!),
      orderBy: (t) => t.id,
    );
    final enrollmentOfferingIds = enrollments
        .map((row) => row.offeringId)
        .toSet();
    final allOfferings = enrollmentOfferingIds.isEmpty
        ? <CourseOffering>[]
        : await CourseOffering.db.find(
            session,
            where: (t) => t.id.inSet(enrollmentOfferingIds),
          );
    final offeringsById = {
      for (final row in allOfferings)
        if (row.id != null) row.id!: row,
    };
    final filteredEnrollments = semesterId == null
        ? enrollments
        : enrollments
              .where(
                (row) =>
                    offeringsById[row.offeringId]?.semesterId == semesterId,
              )
              .toList();
    final offeringIds = filteredEnrollments
        .map((row) => row.offeringId)
        .toSet();
    final courseIds = allOfferings
        .where((row) => row.id != null && offeringIds.contains(row.id))
        .map((row) => row.courseId)
        .toSet();
    final enrollmentIds = filteredEnrollments
        .where((row) => row.id != null)
        .map((row) => row.id!)
        .toSet();
    final semesterIds = allOfferings
        .where((row) => row.id != null && offeringIds.contains(row.id))
        .map((row) => row.semesterId)
        .toSet();

    final allCourses = courseIds.isEmpty
        ? <Course>[]
        : await Course.db.find(
            session,
            where: (t) => t.id.inSet(courseIds),
          );
    final allSchedules = offeringIds.isEmpty
        ? <CourseSchedule>[]
        : await CourseSchedule.db.find(
            session,
            where: (t) => t.offeringId.inSet(offeringIds),
          );
    final allGrades = enrollmentIds.isEmpty
        ? <StudentGrade>[]
        : await StudentGrade.db.find(
            session,
            where: (t) => t.enrollmentId.inSet(enrollmentIds),
          );
    final allExams = offeringIds.isEmpty
        ? <ExamSchedule>[]
        : await ExamSchedule.db.find(
            session,
            where: (t) => t.offeringId.inSet(offeringIds),
          );
    final allSemesters = semesterIds.isEmpty
        ? <Semester>[]
        : await Semester.db.find(
            session,
            where: (t) => t.id.inSet(semesterIds),
          );
    return _StudentAcademicView(
      profile: profile,
      enrollments: filteredEnrollments,
      offeringsById: offeringsById,
      coursesById: {
        for (final row in allCourses)
          if (row.id != null) row.id!: row,
      },
      semestersById: {
        for (final row in allSemesters)
          if (row.id != null) row.id!: row,
      },
      schedules: allSchedules,
      grades: allGrades,
      exams: allExams,
    );
  }

  Future<StudentProfile> _requireStudentProfile(Session session) async {
    final authUserId = CampusMateAuth.requireUserId(session);
    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (profile?.id == null) {
      throw ServerpodClientException('Student profile not found', 404);
    }
    return profile!;
  }

  Future<SemesterSummary> _currentSemester(Session session) async {
    final semester = await Semester.db.findFirstRow(
      session,
      where: (t) => t.isCurrent.equals(true),
      orderBy: (t) => t.startsAt,
      orderDescending: true,
    );
    if (semester == null || semester.id == null) {
      throw ServerpodClientException('Current semester not configured', 404);
    }
    return _semesterSummaryFromRow(semester);
  }

  Future<List<SemesterSummary>> _availableSemesters(Session session) async {
    final semesters = await Semester.db.find(
      session,
      orderBy: (t) => t.startsAt,
      orderDescending: true,
    );
    return semesters
        .where((semester) => semester.id != null)
        .map(_semesterSummaryFromRow)
        .toList();
  }

  Future<SemesterSummary> _semesterSummary(Session session, int id) async {
    final semester = await Semester.db.findById(session, id);
    if (semester == null) {
      throw ServerpodClientException('Semester not found', 404);
    }
    return _semesterSummaryFromRow(semester);
  }

  SemesterSummary _semesterSummaryFromRow(Semester semester) => SemesterSummary(
    id: semester.id!,
    code: semester.code,
    name: semester.name,
    startsAt: semester.startsAt,
    endsAt: semester.endsAt,
    isCurrent: semester.isCurrent,
  );

  List<CourseSummary> _courseSummaries(_StudentAcademicView view) {
    final summaries = <CourseSummary>[];
    for (final enrollment in view.enrollments) {
      final offering = view.offeringsById[enrollment.offeringId];
      if (offering == null) continue;
      final course = view.coursesById[offering.courseId];
      if (course == null) continue;
      summaries.add(_courseSummary(view, enrollment, offering, course));
    }
    summaries.sort((a, b) => a.courseCode.compareTo(b.courseCode));
    return summaries;
  }

  CourseSummary _courseSummary(
    _StudentAcademicView view,
    Enrollment enrollment,
    CourseOffering offering,
    Course course,
  ) {
    final grades = _gradeScores(view, enrollment.id!);
    final finalScore = _weightedScore(grades);
    return CourseSummary(
      offeringId: offering.id!,
      courseCode: course.code,
      title: course.title,
      credits: course.credits,
      lecturerName: offering.lecturerName,
      section: offering.section,
      status: enrollment.status,
      progressPercent: enrollment.progressPercent,
      attendancePercent: enrollment.attendancePercent,
      finalScore: finalScore,
      letter: finalScore == null
          ? null
          : const StandardFourPointPolicy().letterFor(finalScore),
    );
  }

  List<GradeComponentScore> _gradeScores(
    _StudentAcademicView view,
    int enrollmentId,
  ) {
    final rows = view.grades.where((row) => row.enrollmentId == enrollmentId);
    return rows
        .map(
          (row) => GradeComponentScore(
            name: row.componentName,
            weight: row.weight,
            score: row.score,
            maxScore: row.maxScore,
            letter: row.letter,
            gradedAt: row.gradedAt,
          ),
        )
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  double? _weightedScore(List<GradeComponentScore> grades) {
    if (grades.isEmpty) return null;
    var totalWeight = 0.0;
    var weighted = 0.0;
    for (final grade in grades) {
      if (grade.maxScore <= 0 || grade.weight <= 0) continue;
      totalWeight += grade.weight;
      weighted += (grade.score / grade.maxScore) * 10 * grade.weight;
    }
    if (totalWeight == 0) return null;
    return double.parse((weighted / totalWeight).toStringAsFixed(1));
  }

  List<TimetableEntry> _timetableEntries(
    _StudentAcademicView view, {
    Set<int>? offeringIds,
    DateTime? weekStart,
    DateTime? weekEnd,
    DateTime? occurrenceWeekStart,
    DateTime? now,
    int? weekday,
  }) {
    final activeOfferingIds =
        offeringIds ?? view.enrollments.map((row) => row.offeringId).toSet();
    final reference = now ?? CampusClock.nowUtc();
    final entries = <TimetableEntry>[];
    for (final schedule in view.schedules) {
      if (!activeOfferingIds.contains(schedule.offeringId)) continue;
      if (weekday != null && schedule.weekday != weekday) continue;
      final offering = view.offeringsById[schedule.offeringId];
      final course = offering == null
          ? null
          : view.coursesById[offering.courseId];
      final semester = offering == null
          ? null
          : view.semestersById[offering.semesterId];
      if (offering == null || course == null || semester == null) continue;
      final actualStart = _dateForSchedule(
        occurrenceWeekStart ?? weekStart,
        schedule,
      );
      final actualEnd = actualStart.add(
        Duration(minutes: schedule.endMinute - schedule.startMinute),
      );
      final validFrom = _latestDate(
        CampusClock.startOfCampusDayUtc(schedule.startsAt),
        CampusClock.startOfCampusDayUtc(semester.startsAt),
      );
      final validUntilExclusive = _earliestDate(
        CampusClock.startOfCampusDayUtc(
          schedule.endsAt,
        ).add(const Duration(days: 1)),
        CampusClock.startOfCampusDayUtc(
          semester.endsAt,
        ).add(const Duration(days: 1)),
      );
      if (actualStart.isBefore(validFrom) ||
          !actualStart.isBefore(validUntilExclusive)) {
        continue;
      }
      if (weekStart != null &&
          weekEnd != null &&
          (actualStart.isBefore(weekStart) || !actualStart.isBefore(weekEnd))) {
        continue;
      }
      entries.add(
        TimetableEntry(
          scheduleId: schedule.id!,
          offeringId: offering.id!,
          courseCode: course.code,
          title: course.title,
          lecturerName: offering.lecturerName,
          weekday: schedule.weekday,
          startMinute: schedule.startMinute,
          endMinute: schedule.endMinute,
          room: schedule.room,
          campus: schedule.campus,
          status: schedule.status,
          startsAt: actualStart,
          endsAt: actualEnd,
          isCurrent:
              !reference.isBefore(actualStart) && reference.isBefore(actualEnd),
        ),
      );
    }
    entries.sort((a, b) {
      final day = a.weekday.compareTo(b.weekday);
      return day != 0 ? day : a.startMinute.compareTo(b.startMinute);
    });
    return entries;
  }

  ExamSummary _examSummary(
    _StudentAcademicView view,
    ExamSchedule exam,
    DateTime now,
  ) {
    final offering = view.offeringsById[exam.offeringId]!;
    final course = view.coursesById[offering.courseId]!;
    return ExamSummary(
      examId: exam.id!,
      offeringId: offering.id!,
      courseCode: course.code,
      title: course.title,
      examType: exam.examType,
      startsAt: exam.startsAt,
      endsAt: exam.endsAt,
      room: exam.room,
      notes: exam.notes,
      daysUntil: exam.startsAt
          .difference(CampusClock.startOfCampusDayUtc(now))
          .inDays,
    );
  }

  DateTime _dateForSchedule(DateTime? weekStart, CourseSchedule schedule) {
    final base =
        weekStart ?? CampusClock.startOfCampusWeekUtc(schedule.startsAt);
    return CampusClock.dateForCampusWeekday(
      base,
      weekday: schedule.weekday,
      minuteOfDay: schedule.startMinute,
    );
  }

  DateTime _latestDate(DateTime left, DateTime right) =>
      left.isAfter(right) ? left : right;

  DateTime _earliestDate(DateTime left, DateTime right) =>
      left.isBefore(right) ? left : right;
}

class _StudentAcademicView {
  const _StudentAcademicView({
    required this.profile,
    required this.enrollments,
    required this.offeringsById,
    required this.coursesById,
    required this.semestersById,
    required this.schedules,
    required this.grades,
    required this.exams,
  });

  final StudentProfile profile;
  final List<Enrollment> enrollments;
  final Map<int, CourseOffering> offeringsById;
  final Map<int, Course> coursesById;
  final Map<int, Semester> semestersById;
  final List<CourseSchedule> schedules;
  final List<StudentGrade> grades;
  final List<ExamSchedule> exams;
}
