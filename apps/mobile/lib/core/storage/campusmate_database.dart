import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'campusmate_database.g.dart';

class CachedAcademicProfiles extends Table {
  TextColumn get accountId => text()();
  TextColumn get payloadJson => text()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {accountId};
}

class CachedTimetables extends Table {
  TextColumn get accountId => text()();
  TextColumn get weekStartKey => text()();
  TextColumn get payloadJson => text()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {accountId, weekStartKey};
}

class CachedGrades extends Table {
  TextColumn get accountId => text()();
  TextColumn get semesterKey => text()();
  TextColumn get payloadJson => text()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {accountId, semesterKey};
}

@DriftDatabase(tables: [CachedAcademicProfiles, CachedTimetables, CachedGrades])
class CampusMateDatabase extends _$CampusMateDatabase {
  CampusMateDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'campusmate_cache'));

  @override
  int get schemaVersion => 1;

  Future<CachedAcademicProfile?> readAcademicProfile(String accountId) =>
      (select(
        cachedAcademicProfiles,
      )..where((row) => row.accountId.equals(accountId))).getSingleOrNull();

  Future<CachedTimetable?> readTimetable(
    String accountId,
    String weekStartKey,
  ) =>
      (select(cachedTimetables)..where(
            (row) =>
                row.accountId.equals(accountId) &
                row.weekStartKey.equals(weekStartKey),
          ))
          .getSingleOrNull();

  Future<CachedGrade?> readGrades(String accountId, String semesterKey) =>
      (select(cachedGrades)..where(
            (row) =>
                row.accountId.equals(accountId) &
                row.semesterKey.equals(semesterKey),
          ))
          .getSingleOrNull();

  Future<void> replaceAcademicSnapshot({
    required String accountId,
    required String weekStartKey,
    required String semesterKey,
    required String profilePayloadJson,
    required String timetablePayloadJson,
    required String gradesPayloadJson,
    required DateTime syncedAt,
  }) {
    return transaction(() async {
      await into(cachedAcademicProfiles).insertOnConflictUpdate(
        CachedAcademicProfilesCompanion.insert(
          accountId: accountId,
          payloadJson: profilePayloadJson,
          syncedAt: syncedAt,
        ),
      );
      await into(cachedTimetables).insertOnConflictUpdate(
        CachedTimetablesCompanion.insert(
          accountId: accountId,
          weekStartKey: weekStartKey,
          payloadJson: timetablePayloadJson,
          syncedAt: syncedAt,
        ),
      );
      await into(cachedGrades).insertOnConflictUpdate(
        CachedGradesCompanion.insert(
          accountId: accountId,
          semesterKey: semesterKey,
          payloadJson: gradesPayloadJson,
          syncedAt: syncedAt,
        ),
      );
    });
  }

  Future<void> clearAccountCache(String accountId) {
    return transaction(() async {
      await (delete(
        cachedAcademicProfiles,
      )..where((row) => row.accountId.equals(accountId))).go();
      await (delete(
        cachedTimetables,
      )..where((row) => row.accountId.equals(accountId))).go();
      await (delete(
        cachedGrades,
      )..where((row) => row.accountId.equals(accountId))).go();
    });
  }
}
