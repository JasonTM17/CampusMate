import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'package:campusmate_server/src/academic/academic_demo_seed.dart';
import 'package:campusmate_server/src/auth/auth_setup.dart';
import 'package:campusmate_server/src/auth/campusmate_auth.dart';
import 'package:campusmate_server/src/dashboard/dashboard_demo_seed.dart';
import 'package:campusmate_server/src/generated/endpoints.dart';
import 'package:campusmate_server/src/generated/protocol.dart';

/// Seeds local-only CampusMate accounts and student profiles.
///
/// The password is deliberately supplied through CAMPUSMATE_SEED_PASSWORD so
/// no reusable credential is committed to source control or printed by this
/// command. Run this from the server directory after starting local services.
Future<void> main(List<String> args) async {
  final password = Platform.environment['CAMPUSMATE_SEED_PASSWORD'];
  if (password == null || password.length < 12) {
    stderr.writeln(
      'Set CAMPUSMATE_SEED_PASSWORD to a local-only password of at least 12 characters.',
    );
    exitCode = 64;
    return;
  }

  final podArgs = [
    ...args,
    if (!args.contains('--apply-migrations')) '--apply-migrations',
  ];
  final pod = Serverpod(podArgs, Protocol(), Endpoints());
  initializeCampusMateAuthServices(pod);

  await pod.start(runInGuardedZone: false);
  final session = await pod.createSession(enableLogging: false);
  try {
    await _seedAccounts(session, password);
  } finally {
    await session.close();
    await pod.shutdown(exitProcess: false);
  }
}

Future<void> _seedAccounts(Session session, String password) async {
  final accounts = <_SeedAccount>[
    const _SeedAccount(
      email: 'admin@campusmate.local',
      role: 'admin',
    ),
    const _SeedAccount(
      email: 'librarian@campusmate.local',
      role: 'librarian',
    ),
    ...[
      ('Nguyễn Minh Anh', 'SV2026001', 'K68PM01', 3.42),
      ('Trần Bảo Châu', 'SV2026002', 'K68PM01', 3.18),
      ('Lê Hoàng Nam', 'SV2026003', 'K68PM02', 3.67),
      ('Phạm Gia Hân', 'SV2026004', 'K68PM02', 3.05),
      ('Võ Đức Anh', 'SV2026005', 'K68PM03', 3.81),
      ('Đỗ Khánh Linh', 'SV2026006', 'K68PM03', 3.28),
      ('Bùi Quang Huy', 'SV2026007', 'K68PM04', 2.96),
      ('Hoàng Ngọc Mai', 'SV2026008', 'K68PM04', 3.54),
      ('Ngô Tuấn Kiệt', 'SV2026009', 'K68PM05', 3.11),
      ('Đặng Thu Hà', 'SV2026010', 'K68PM05', 3.73),
      ('Phan Nhật Minh', 'SV2026011', 'K68PM06', 3.36),
      ('Huỳnh Thảo Vy', 'SV2026012', 'K68PM06', 3.89),
      ('Mai Quốc Bảo', 'SV2026013', 'K68PM07', 2.84),
      ('Dương Thanh Tâm', 'SV2026014', 'K68PM07', 3.22),
      ('Nguyễn Hải Yến', 'SV2026015', 'K68PM08', 3.61),
      ('Trịnh Công Thành', 'SV2026016', 'K68PM08', 3.09),
      ('Phan Thùy Dương', 'SV2026017', 'K68PM09', 3.47),
      ('Lý Anh Khoa', 'SV2026018', 'K68PM09', 3.76),
      ('Đinh Ngọc Lan', 'SV2026019', 'K68PM10', 3.14),
      ('Tạ Việt Hoàng', 'SV2026020', 'K68PM10', 3.58),
    ].map(
      (student) => _SeedAccount(
        email: student.$2 == 'SV2026001'
            ? 'student001@campusmate.local'
            : '${student.$2.toLowerCase()}@campusmate.local',
        role: 'student',
        studentCode: student.$2,
        fullName: student.$1,
        className: student.$3,
        gpa: student.$4,
      ),
    ),
  ];

  final emailIdp = AuthServices.getIdentityProvider<EmailIdp>();
  for (final account in accounts) {
    final authUser = await _ensureAuthUser(
      session,
      emailIdp,
      account,
      password,
    );
    await _upsertProfile(session, authUser.id, account);
  }
  await seedAcademicDemoData(session);
  await seedDashboardNotificationDemoData(session);

  stdout.writeln(
    'Seeded ${accounts.length} local accounts plus academic dashboard and notification demo data. Password was read from CAMPUSMATE_SEED_PASSWORD.',
  );
}

Future<AuthUserModel> _ensureAuthUser(
  Session session,
  EmailIdp emailIdp,
  _SeedAccount account,
  String password,
) async {
  final existingEmailAccount = await emailIdp.admin.findAccount(
    session,
    email: account.email,
  );
  final scope = CampusMateAuth.scopeForRole(account.role);

  return session.db.transaction((transaction) async {
    if (existingEmailAccount == null) {
      final authUser = await AuthServices.instance.authUsers.create(
        session,
        scopes: {scope},
        transaction: transaction,
      );
      await emailIdp.admin.createEmailAuthentication(
        session,
        authUserId: authUser.id,
        email: account.email,
        password: password,
        transaction: transaction,
      );
      return authUser;
    }

    final authUser = await AuthServices.instance.authUsers.update(
      session,
      authUserId: existingEmailAccount.authUserId,
      scopes: {scope},
      transaction: transaction,
    );
    await emailIdp.admin.setPassword(
      session,
      email: account.email,
      password: password,
      transaction: transaction,
    );
    return authUser;
  });
}

Future<void> _upsertProfile(
  Session session,
  UuidValue authUserId,
  _SeedAccount account,
) async {
  final now = DateTime.now().toUtc();
  var profile = await StudentProfile.db.findFirstRow(
    session,
    where: (table) => table.authUserId.equals(authUserId),
  );

  if (profile == null) {
    profile = StudentProfile(
      authUserId: authUserId,
      studentCode: account.studentCode,
      fullName: account.fullName,
      faculty: account.studentCode == null ? null : 'Công nghệ thông tin',
      major: account.studentCode == null ? null : 'Kỹ thuật phần mềm',
      className: account.className,
      gpa: account.gpa,
      credits: account.studentCode == null ? null : 45,
      conductScore: account.studentCode == null ? null : 88,
      role: account.role,
      createdAt: now,
      updatedAt: now,
    );
    await StudentProfile.db.insertRow(session, profile);
    return;
  }

  profile.studentCode = account.studentCode;
  profile.fullName = account.fullName;
  profile.faculty = account.studentCode == null ? null : 'Công nghệ thông tin';
  profile.major = account.studentCode == null ? null : 'Kỹ thuật phần mềm';
  profile.className = account.className;
  profile.gpa = account.gpa;
  profile.credits = account.studentCode == null ? null : 45;
  profile.conductScore = account.studentCode == null ? null : 88;
  profile.role = account.role;
  profile.updatedAt = now;
  await StudentProfile.db.updateRow(session, profile);
}

class _SeedAccount {
  const _SeedAccount({
    required this.email,
    required this.role,
    this.studentCode,
    this.fullName,
    this.className,
    this.gpa,
  });

  final String email;
  final String role;
  final String? studentCode;
  final String? fullName;
  final String? className;
  final double? gpa;
}
