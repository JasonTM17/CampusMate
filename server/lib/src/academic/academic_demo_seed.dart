import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

Future<void> seedAcademicDemoData(Session session) async {
  final year = await _ensureAcademicYear(session);
  final semester = await _ensureSemester(session, year.id!);
  await _ensureHistoricalSemester(session, year.id!);
  final courses = <Course>[];

  for (final seed in _courseSeeds) {
    courses.add(
      await _ensureCourse(
        session,
        code: seed.code,
        title: seed.title,
        description: seed.description,
        credits: seed.credits,
        department: seed.department,
      ),
    );
  }

  final offerings = await _ensureOfferings(session, semester, courses);
  await _ensureSchedules(session, semester, offerings);
  await _ensureGradeComponents(session, offerings);
  await _ensureExams(session, offerings);

  final profiles = await StudentProfile.db.find(
    session,
    where: (t) => t.role.equals('student'),
    orderBy: (t) => t.id,
  );
  for (var i = 0; i < profiles.length; i++) {
    final profile = profiles[i];
    if (profile.id == null) continue;
    await _seedEnrollmentsAndGrades(session, profile, offerings, i);
  }
}

Future<AcademicYear> _ensureAcademicYear(Session session) async {
  final existing = await AcademicYear.db.findFirstRow(
    session,
    where: (t) => t.code.equals('2026-2027'),
  );
  if (existing != null) return existing;
  return AcademicYear.db.insertRow(
    session,
    AcademicYear(
      code: '2026-2027',
      name: 'Năm học 2026-2027',
      startsAt: DateTime.utc(2026, 8, 1),
      endsAt: DateTime.utc(2027, 7, 31),
    ),
  );
}

Future<Semester> _ensureSemester(Session session, int academicYearId) async {
  final existing = await Semester.db.findFirstRow(
    session,
    where: (t) => t.code.equals('2026-HK1'),
  );
  if (existing != null) return existing;
  return Semester.db.insertRow(
    session,
    Semester(
      academicYearId: academicYearId,
      code: '2026-HK1',
      name: 'Học kỳ 1 2026',
      startsAt: DateTime.utc(2026, 9, 7),
      endsAt: DateTime.utc(2026, 12, 27),
      isCurrent: true,
    ),
  );
}

Future<Semester> _ensureHistoricalSemester(
  Session session,
  int academicYearId,
) async {
  final existing = await Semester.db.findFirstRow(
    session,
    where: (t) => t.code.equals('2025-HK2'),
  );
  if (existing != null) return existing;
  return Semester.db.insertRow(
    session,
    Semester(
      academicYearId: academicYearId,
      code: '2025-HK2',
      name: 'Học kỳ 2 2025',
      startsAt: DateTime.utc(2026, 2, 9),
      endsAt: DateTime.utc(2026, 5, 31),
      isCurrent: false,
    ),
  );
}

Future<Course> _ensureCourse(
  Session session, {
  required String code,
  required String title,
  required String description,
  required int credits,
  required String department,
}) async {
  final existing = await Course.db.findFirstRow(
    session,
    where: (t) => t.code.equals(code),
  );
  if (existing != null) return existing;
  return Course.db.insertRow(
    session,
    Course(
      code: code,
      title: title,
      description: description,
      credits: credits,
      faculty: 'Công nghệ thông tin',
      department: department,
    ),
  );
}

Future<List<CourseOffering>> _ensureOfferings(
  Session session,
  Semester semester,
  List<Course> courses,
) async {
  final offerings = <CourseOffering>[];
  for (var i = 0; i < 25; i++) {
    final course = courses[i % courses.length];
    final section = 'N${(i ~/ courses.length) + 1}';
    offerings.add(
      await _ensureOffering(
        session,
        courseId: course.id!,
        semesterId: semester.id!,
        section: section,
        lecturerName: _lecturers[i % _lecturers.length],
        room: 'A${100 + i}',
      ),
    );
  }
  return offerings;
}

Future<CourseOffering> _ensureOffering(
  Session session, {
  required int courseId,
  required int semesterId,
  required String section,
  required String lecturerName,
  required String room,
}) async {
  final existing = await CourseOffering.db.findFirstRow(
    session,
    where: (t) =>
        t.courseId.equals(courseId) &
        t.semesterId.equals(semesterId) &
        t.section.equals(section),
  );
  if (existing != null) return existing;
  return CourseOffering.db.insertRow(
    session,
    CourseOffering(
      courseId: courseId,
      semesterId: semesterId,
      section: section,
      lecturerName: lecturerName,
      room: room,
    ),
  );
}

Future<void> _ensureSchedules(
  Session session,
  Semester semester,
  List<CourseOffering> offerings,
) async {
  for (var i = 0; i < offerings.length; i++) {
    final offering = offerings[i];
    final pattern = _schedulePatterns[i % _schedulePatterns.length];
    final existing = await CourseSchedule.db.findFirstRow(
      session,
      where: (t) =>
          t.offeringId.equals(offering.id!) &
          t.weekday.equals(pattern.weekday) &
          t.startMinute.equals(pattern.startMinute),
    );
    if (existing != null) continue;
    await CourseSchedule.db.insertRow(
      session,
      CourseSchedule(
        offeringId: offering.id!,
        weekday: pattern.weekday,
        startMinute: pattern.startMinute,
        endMinute: pattern.startMinute + 150,
        room: offering.room ?? 'A101',
        campus: 'Cơ sở chính',
        startsAt: semester.startsAt,
        endsAt: semester.endsAt,
        status: 'scheduled',
      ),
    );
  }
}

Future<void> _ensureGradeComponents(
  Session session,
  List<CourseOffering> offerings,
) async {
  for (final offering in offerings) {
    for (final component in _componentPlan) {
      final existing = await GradeComponent.db.findFirstRow(
        session,
        where: (t) =>
            t.offeringId.equals(offering.id!) & t.name.equals(component.name),
      );
      if (existing != null) continue;
      await GradeComponent.db.insertRow(
        session,
        GradeComponent(
          offeringId: offering.id!,
          name: component.name,
          weight: component.weight,
          maxScore: 10,
        ),
      );
    }
  }
}

Future<void> _ensureExams(
  Session session,
  List<CourseOffering> offerings,
) async {
  for (var i = 0; i < offerings.length; i++) {
    final offering = offerings[i];
    await _ensureExam(
      session,
      offering,
      examType: 'Giữa kỳ',
      startsAt: DateTime.utc(2026, 10, 20 + (i % 10), 2),
      durationMinutes: 90,
      room: offering.room ?? 'A101',
      notes: 'Mang thẻ sinh viên và máy tính cá nhân nếu môn học yêu cầu.',
    );
    await _ensureExam(
      session,
      offering,
      examType: 'Cuối kỳ',
      startsAt: DateTime.utc(2026, 12, 10 + (i % 12), 2),
      durationMinutes: 120,
      room: offering.room ?? 'A101',
      notes: 'Lịch thi chính thức có thể được phòng đào tạo cập nhật.',
    );
  }
}

Future<void> _ensureExam(
  Session session,
  CourseOffering offering, {
  required String examType,
  required DateTime startsAt,
  required int durationMinutes,
  required String room,
  required String notes,
}) async {
  final existing = await ExamSchedule.db.findFirstRow(
    session,
    where: (t) =>
        t.offeringId.equals(offering.id!) & t.examType.equals(examType),
  );
  if (existing != null) return;
  await ExamSchedule.db.insertRow(
    session,
    ExamSchedule(
      offeringId: offering.id!,
      examType: examType,
      startsAt: startsAt,
      endsAt: startsAt.add(Duration(minutes: durationMinutes)),
      room: room,
      notes: notes,
    ),
  );
}

Future<void> _seedEnrollmentsAndGrades(
  Session session,
  StudentProfile profile,
  List<CourseOffering> offerings,
  int profileIndex,
) async {
  final selected = _selectOfferingsForProfile(offerings, profileIndex);
  for (var i = 0; i < selected.length; i++) {
    final offering = selected[i];
    var enrollment = await Enrollment.db.findFirstRow(
      session,
      where: (t) =>
          t.studentProfileId.equals(profile.id!) &
          t.offeringId.equals(offering.id!),
    );
    enrollment ??= await Enrollment.db.insertRow(
      session,
      Enrollment(
        studentProfileId: profile.id!,
        offeringId: offering.id!,
        status: 'active',
        progressPercent: 35 + (i * 10),
        attendancePercent: 82 + ((profileIndex + i) % 6) * 2,
      ),
    );
    await _ensureGradesForEnrollment(session, enrollment, profileIndex + i);
  }
}

List<CourseOffering> _selectOfferingsForProfile(
  List<CourseOffering> offerings,
  int profileIndex,
) {
  final selected = <CourseOffering>[];
  final selectedCourseIds = <int>{};
  final start = (profileIndex * 3) % offerings.length;

  for (
    var offset = 0;
    selected.length < 5 && offset < offerings.length * 2;
    offset++
  ) {
    final offering = offerings[(start + offset) % offerings.length];
    if (selectedCourseIds.add(offering.courseId)) {
      selected.add(offering);
    }
  }

  return selected;
}

Future<void> _ensureGradesForEnrollment(
  Session session,
  Enrollment enrollment,
  int offset,
) async {
  final baseScore = 6.4 + ((offset % 7) * 0.35);
  for (var i = 0; i < _componentPlan.length; i++) {
    final component = _componentPlan[i];
    final existing = await StudentGrade.db.findFirstRow(
      session,
      where: (t) =>
          t.enrollmentId.equals(enrollment.id!) &
          t.componentName.equals(component.name),
    );
    if (existing != null) continue;
    final score = double.parse((baseScore + i * 0.25).toStringAsFixed(1));
    await StudentGrade.db.insertRow(
      session,
      StudentGrade(
        enrollmentId: enrollment.id!,
        componentName: component.name,
        weight: component.weight,
        score: score,
        maxScore: 10,
        letter: const StandardFourPointPolicy().letterFor(score),
        gradedAt: DateTime.utc(2026, 10, 1 + (offset % 20) + i),
      ),
    );
  }
}

const _courseSeeds = [
  _CourseSeed(
    'SE101',
    'Nhập môn kỹ thuật phần mềm',
    'Tổng quan quy trình phát triển phần mềm hiện đại.',
    3,
    'Cơ sở ngành',
  ),
  _CourseSeed(
    'SE214',
    'Lập trình di động',
    'Xây dựng ứng dụng mobile với kiến trúc client-server.',
    4,
    'Chuyên ngành',
  ),
  _CourseSeed(
    'DB202',
    'Cơ sở dữ liệu',
    'Thiết kế dữ liệu quan hệ, truy vấn và giao dịch.',
    3,
    'Cơ sở ngành',
  ),
  _CourseSeed(
    'AI301',
    'Trí tuệ nhân tạo ứng dụng',
    'Ứng dụng AI trong học tập, tìm kiếm và trợ lý cá nhân.',
    3,
    'Chuyên ngành',
  ),
  _CourseSeed(
    'MATH101',
    'Toán rời rạc',
    'Logic, tập hợp, quan hệ và đồ thị cho ngành phần mềm.',
    3,
    'Đại cương',
  ),
  _CourseSeed(
    'NET204',
    'Mạng máy tính',
    'Nguyên lý mạng, giao thức Internet và vận hành dịch vụ.',
    3,
    'Cơ sở ngành',
  ),
  _CourseSeed(
    'UX220',
    'Thiết kế trải nghiệm người dùng',
    'Nghiên cứu người dùng, wireframe và kiểm thử khả dụng.',
    3,
    'Chuyên ngành',
  ),
  _CourseSeed(
    'SEC310',
    'An toàn phần mềm',
    'Threat modeling, kiểm thử bảo mật và bảo vệ dữ liệu người dùng.',
    3,
    'Chuyên ngành',
  ),
  _CourseSeed(
    'DS240',
    'Cấu trúc dữ liệu và giải thuật',
    'Phân tích độ phức tạp và thiết kế thuật toán thực dụng.',
    4,
    'Cơ sở ngành',
  ),
  _CourseSeed(
    'ENG102',
    'Tiếng Anh học thuật',
    'Đọc hiểu tài liệu chuyên ngành và trình bày kỹ thuật.',
    2,
    'Đại cương',
  ),
  _CourseSeed(
    'OS230',
    'Hệ điều hành',
    'Tiến trình, bộ nhớ, tập tin và đồng bộ hóa.',
    3,
    'Cơ sở ngành',
  ),
  _CourseSeed(
    'QA260',
    'Kiểm thử phần mềm',
    'Chiến lược kiểm thử, automation và chất lượng phát hành.',
    3,
    'Chuyên ngành',
  ),
  _CourseSeed(
    'CLOUD330',
    'Điện toán đám mây',
    'Triển khai dịch vụ, quan sát hệ thống và vận hành cloud.',
    3,
    'Chuyên ngành',
  ),
  _CourseSeed(
    'PM250',
    'Quản lý dự án phần mềm',
    'Lập kế hoạch, quản trị rủi ro và phối hợp nhóm kỹ thuật.',
    3,
    'Chuyên ngành',
  ),
  _CourseSeed(
    'STAT210',
    'Xác suất thống kê',
    'Nền tảng xác suất, suy luận thống kê và phân tích dữ liệu.',
    3,
    'Đại cương',
  ),
];

const _lecturers = [
  'TS. Trần Minh Khoa',
  'ThS. Nguyễn Thu Hà',
  'TS. Lê Quốc Bảo',
  'ThS. Phạm An Nhiên',
  'TS. Võ Đức Long',
  'ThS. Hoàng Mai Anh',
  'TS. Đặng Hải Nam',
];

const _schedulePatterns = [
  _SchedulePattern(1, 570),
  _SchedulePattern(1, 570),
  _SchedulePattern(2, 450),
  _SchedulePattern(2, 780),
  _SchedulePattern(3, 570),
  _SchedulePattern(3, 780),
  _SchedulePattern(4, 450),
  _SchedulePattern(4, 570),
  _SchedulePattern(5, 450),
  _SchedulePattern(5, 780),
];

const _componentPlan = [
  _GradeComponentPlan('Chuyên cần', 0.1),
  _GradeComponentPlan('Giữa kỳ', 0.3),
  _GradeComponentPlan('Cuối kỳ', 0.6),
];

class _CourseSeed {
  const _CourseSeed(
    this.code,
    this.title,
    this.description,
    this.credits,
    this.department,
  );

  final String code;
  final String title;
  final String description;
  final int credits;
  final String department;
}

class _SchedulePattern {
  const _SchedulePattern(this.weekday, this.startMinute);

  final int weekday;
  final int startMinute;
}

class _GradeComponentPlan {
  const _GradeComponentPlan(this.name, this.weight);

  final String name;
  final double weight;
}
