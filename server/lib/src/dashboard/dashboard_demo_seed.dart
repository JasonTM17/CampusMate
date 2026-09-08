import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

Future<void> seedDashboardNotificationDemoData(Session session) async {
  await _ensureAnnouncements(session);

  final profiles = await StudentProfile.db.find(
    session,
    where: (t) => t.role.equals('student'),
    orderBy: (t) => t.id,
  );
  for (final profile in profiles) {
    if (profile.id == null) continue;
    final context = await _studentNotificationContext(session, profile);
    for (var i = 0; i < _notificationTemplates.length; i++) {
      final template = _notificationTemplates[i];
      await _ensureNotification(
        session,
        profile,
        template,
        context,
        DateTime.utc(2026, 9, 8, 7).subtract(Duration(minutes: i * 17)),
      );
    }
  }
}

Future<void> _ensureAnnouncements(Session session) async {
  final now = CampusClock.nowUtc();
  for (final seed in _announcementSeeds(now)) {
    final existing = await Announcement.db.findFirstRow(
      session,
      where: (t) => t.title.equals(seed.title),
    );
    if (existing == null) {
      await Announcement.db.insertRow(
        session,
        Announcement(
          title: seed.title,
          body: seed.body,
          audience: seed.audience,
          publishAt: seed.publishAt,
          expiresAt: seed.expiresAt,
          archived: seed.archived,
          createdAt: now,
          updatedAt: now,
        ),
      );
      continue;
    }

    await Announcement.db.updateRow(
      session,
      existing.copyWith(
        body: seed.body,
        audience: seed.audience,
        publishAt: seed.publishAt,
        expiresAt: seed.expiresAt,
        archived: seed.archived,
        updatedAt: now,
      ),
    );
  }
}

Future<_StudentNotificationContext> _studentNotificationContext(
  Session session,
  StudentProfile profile,
) async {
  final enrollments = await Enrollment.db.find(
    session,
    where: (t) => t.studentProfileId.equals(profile.id!),
    orderBy: (t) => t.id,
  );
  final offeringIds = enrollments.map((row) => row.offeringId).toSet();
  if (offeringIds.isEmpty) {
    return const _StudentNotificationContext();
  }

  final exams = await ExamSchedule.db.find(
    session,
    where: (t) => t.offeringId.inSet(offeringIds),
    orderBy: (t) => t.startsAt,
  );
  return _StudentNotificationContext(
    offeringId: offeringIds.first,
    examId: exams.isEmpty ? null : exams.first.id,
  );
}

Future<void> _ensureNotification(
  Session session,
  StudentProfile profile,
  _NotificationTemplate template,
  _StudentNotificationContext context,
  DateTime createdAt,
) async {
  final targetType = switch (template.category) {
    'exam' => context.examId == null ? null : 'exam',
    'course' => context.offeringId == null ? null : 'course',
    _ => null,
  };
  final targetId = switch (template.category) {
    'exam' => context.examId,
    'course' => context.offeringId,
    _ => null,
  };
  final existing = await CampusNotification.db.findFirstRow(
    session,
    where: (t) =>
        t.userId.equals(profile.authUserId) &
        t.category.equals(template.category) &
        t.title.equals(template.title),
  );
  if (existing != null) {
    await CampusNotification.db.updateRow(
      session,
      existing.copyWith(
        body: template.body,
        targetType: targetType,
        targetId: targetId,
      ),
    );
    return;
  }

  await CampusNotification.db.insertRow(
    session,
    CampusNotification(
      userId: profile.authUserId,
      category: template.category,
      title: template.title,
      body: template.body,
      targetType: targetType,
      targetId: targetId,
      readAt: null,
      createdAt: createdAt,
    ),
  );
}

List<_AnnouncementSeed> _announcementSeeds(DateTime now) => [
  _AnnouncementSeed(
    title: 'Khai giảng học kỳ 1',
    body: 'Sinh viên kiểm tra lịch học tuần đầu và phòng học trên CampusMate.',
    audience: 'student',
    publishAt: now.subtract(const Duration(days: 7)),
  ),
  _AnnouncementSeed(
    title: 'Mở đăng ký thư viện số',
    body:
        'Thư viện số mở thêm nhóm tài liệu chuyên ngành phần mềm trong tuần này.',
    audience: 'all',
    publishAt: now.subtract(const Duration(days: 5)),
  ),
  _AnnouncementSeed(
    title: 'Bảo trì hệ thống học vụ',
    body: 'Một số dịch vụ có thể gián đoạn ngắn vào tối thứ bảy.',
    audience: 'student',
    publishAt: now.subtract(const Duration(days: 3)),
    expiresAt: now.add(const Duration(days: 30)),
  ),
  _AnnouncementSeed(
    title: 'Thông báo cũ đã hết hạn',
    body: 'Dòng này chỉ dùng để kiểm thử bộ lọc hạn hiển thị.',
    audience: 'student',
    publishAt: now.subtract(const Duration(days: 40)),
    expiresAt: now.subtract(const Duration(days: 1)),
  ),
  _AnnouncementSeed(
    title: 'Bản nháp lưu trữ',
    body: 'Dòng này chỉ dùng để kiểm thử bộ lọc lưu trữ.',
    audience: 'student',
    publishAt: now.subtract(const Duration(days: 7)),
    archived: true,
  ),
];

const _notificationTemplates = [
  _NotificationTemplate(
    'academic',
    'Điểm học phần mới',
    'Bảng điểm học kỳ đã có dữ liệu mới để bạn kiểm tra.',
  ),
  _NotificationTemplate(
    'library',
    'Tài liệu thư viện gợi ý',
    'Thư viện số vừa thêm tài liệu phù hợp với môn học của bạn.',
  ),
  _NotificationTemplate(
    'system',
    'Cập nhật CampusMate',
    'Ứng dụng vừa bổ sung trung tâm thông báo và dashboard học tập.',
  ),
  _NotificationTemplate(
    'ai',
    'Gợi ý ôn tập từ AI',
    'Trợ lý AI đã chuẩn bị vài hướng ôn tập dựa trên môn đang học.',
  ),
  _NotificationTemplate(
    'course',
    'Cập nhật lớp học',
    'Giảng viên vừa cập nhật thông tin lớp học trong tuần này.',
  ),
  _NotificationTemplate(
    'exam',
    'Sắp đến lịch thi',
    'Bạn có một lịch thi sắp tới, mở thông báo để xem chi tiết.',
  ),
];

class _AnnouncementSeed {
  const _AnnouncementSeed({
    required this.title,
    required this.body,
    required this.audience,
    required this.publishAt,
    this.expiresAt,
    this.archived = false,
  });

  final String title;
  final String body;
  final String audience;
  final DateTime publishAt;
  final DateTime? expiresAt;
  final bool archived;
}

class _NotificationTemplate {
  const _NotificationTemplate(this.category, this.title, this.body);

  final String category;
  final String title;
  final String body;
}

class _StudentNotificationContext {
  const _StudentNotificationContext({this.offeringId, this.examId});

  final int? offeringId;
  final int? examId;
}
