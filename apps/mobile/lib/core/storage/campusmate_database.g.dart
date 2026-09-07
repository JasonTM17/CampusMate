// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campusmate_database.dart';

// ignore_for_file: type=lint
class $CachedAcademicProfilesTable extends CachedAcademicProfiles
    with TableInfo<$CachedAcademicProfilesTable, CachedAcademicProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedAcademicProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [accountId, payloadJson, syncedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_academic_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedAcademicProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_syncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId};
  @override
  CachedAcademicProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedAcademicProfile(
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      )!,
    );
  }

  @override
  $CachedAcademicProfilesTable createAlias(String alias) {
    return $CachedAcademicProfilesTable(attachedDatabase, alias);
  }
}

class CachedAcademicProfile extends DataClass
    implements Insertable<CachedAcademicProfile> {
  final String accountId;
  final String payloadJson;
  final DateTime syncedAt;
  const CachedAcademicProfile({
    required this.accountId,
    required this.payloadJson,
    required this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<String>(accountId);
    map['payload_json'] = Variable<String>(payloadJson);
    map['synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  CachedAcademicProfilesCompanion toCompanion(bool nullToAbsent) {
    return CachedAcademicProfilesCompanion(
      accountId: Value(accountId),
      payloadJson: Value(payloadJson),
      syncedAt: Value(syncedAt),
    );
  }

  factory CachedAcademicProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedAcademicProfile(
      accountId: serializer.fromJson<String>(json['accountId']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<String>(accountId),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  CachedAcademicProfile copyWith({
    String? accountId,
    String? payloadJson,
    DateTime? syncedAt,
  }) => CachedAcademicProfile(
    accountId: accountId ?? this.accountId,
    payloadJson: payloadJson ?? this.payloadJson,
    syncedAt: syncedAt ?? this.syncedAt,
  );
  CachedAcademicProfile copyWithCompanion(
    CachedAcademicProfilesCompanion data,
  ) {
    return CachedAcademicProfile(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedAcademicProfile(')
          ..write('accountId: $accountId, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(accountId, payloadJson, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedAcademicProfile &&
          other.accountId == this.accountId &&
          other.payloadJson == this.payloadJson &&
          other.syncedAt == this.syncedAt);
}

class CachedAcademicProfilesCompanion
    extends UpdateCompanion<CachedAcademicProfile> {
  final Value<String> accountId;
  final Value<String> payloadJson;
  final Value<DateTime> syncedAt;
  final Value<int> rowid;
  const CachedAcademicProfilesCompanion({
    this.accountId = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedAcademicProfilesCompanion.insert({
    required String accountId,
    required String payloadJson,
    required DateTime syncedAt,
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId),
       payloadJson = Value(payloadJson),
       syncedAt = Value(syncedAt);
  static Insertable<CachedAcademicProfile> custom({
    Expression<String>? accountId,
    Expression<String>? payloadJson,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedAcademicProfilesCompanion copyWith({
    Value<String>? accountId,
    Value<String>? payloadJson,
    Value<DateTime>? syncedAt,
    Value<int>? rowid,
  }) {
    return CachedAcademicProfilesCompanion(
      accountId: accountId ?? this.accountId,
      payloadJson: payloadJson ?? this.payloadJson,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedAcademicProfilesCompanion(')
          ..write('accountId: $accountId, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedTimetablesTable extends CachedTimetables
    with TableInfo<$CachedTimetablesTable, CachedTimetable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedTimetablesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekStartKeyMeta = const VerificationMeta(
    'weekStartKey',
  );
  @override
  late final GeneratedColumn<String> weekStartKey = GeneratedColumn<String>(
    'week_start_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    accountId,
    weekStartKey,
    payloadJson,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_timetables';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedTimetable> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('week_start_key')) {
      context.handle(
        _weekStartKeyMeta,
        weekStartKey.isAcceptableOrUnknown(
          data['week_start_key']!,
          _weekStartKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weekStartKeyMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_syncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId, weekStartKey};
  @override
  CachedTimetable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedTimetable(
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      weekStartKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}week_start_key'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      )!,
    );
  }

  @override
  $CachedTimetablesTable createAlias(String alias) {
    return $CachedTimetablesTable(attachedDatabase, alias);
  }
}

class CachedTimetable extends DataClass implements Insertable<CachedTimetable> {
  final String accountId;
  final String weekStartKey;
  final String payloadJson;
  final DateTime syncedAt;
  const CachedTimetable({
    required this.accountId,
    required this.weekStartKey,
    required this.payloadJson,
    required this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<String>(accountId);
    map['week_start_key'] = Variable<String>(weekStartKey);
    map['payload_json'] = Variable<String>(payloadJson);
    map['synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  CachedTimetablesCompanion toCompanion(bool nullToAbsent) {
    return CachedTimetablesCompanion(
      accountId: Value(accountId),
      weekStartKey: Value(weekStartKey),
      payloadJson: Value(payloadJson),
      syncedAt: Value(syncedAt),
    );
  }

  factory CachedTimetable.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedTimetable(
      accountId: serializer.fromJson<String>(json['accountId']),
      weekStartKey: serializer.fromJson<String>(json['weekStartKey']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<String>(accountId),
      'weekStartKey': serializer.toJson<String>(weekStartKey),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  CachedTimetable copyWith({
    String? accountId,
    String? weekStartKey,
    String? payloadJson,
    DateTime? syncedAt,
  }) => CachedTimetable(
    accountId: accountId ?? this.accountId,
    weekStartKey: weekStartKey ?? this.weekStartKey,
    payloadJson: payloadJson ?? this.payloadJson,
    syncedAt: syncedAt ?? this.syncedAt,
  );
  CachedTimetable copyWithCompanion(CachedTimetablesCompanion data) {
    return CachedTimetable(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      weekStartKey: data.weekStartKey.present
          ? data.weekStartKey.value
          : this.weekStartKey,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedTimetable(')
          ..write('accountId: $accountId, ')
          ..write('weekStartKey: $weekStartKey, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(accountId, weekStartKey, payloadJson, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedTimetable &&
          other.accountId == this.accountId &&
          other.weekStartKey == this.weekStartKey &&
          other.payloadJson == this.payloadJson &&
          other.syncedAt == this.syncedAt);
}

class CachedTimetablesCompanion extends UpdateCompanion<CachedTimetable> {
  final Value<String> accountId;
  final Value<String> weekStartKey;
  final Value<String> payloadJson;
  final Value<DateTime> syncedAt;
  final Value<int> rowid;
  const CachedTimetablesCompanion({
    this.accountId = const Value.absent(),
    this.weekStartKey = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedTimetablesCompanion.insert({
    required String accountId,
    required String weekStartKey,
    required String payloadJson,
    required DateTime syncedAt,
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId),
       weekStartKey = Value(weekStartKey),
       payloadJson = Value(payloadJson),
       syncedAt = Value(syncedAt);
  static Insertable<CachedTimetable> custom({
    Expression<String>? accountId,
    Expression<String>? weekStartKey,
    Expression<String>? payloadJson,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (weekStartKey != null) 'week_start_key': weekStartKey,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedTimetablesCompanion copyWith({
    Value<String>? accountId,
    Value<String>? weekStartKey,
    Value<String>? payloadJson,
    Value<DateTime>? syncedAt,
    Value<int>? rowid,
  }) {
    return CachedTimetablesCompanion(
      accountId: accountId ?? this.accountId,
      weekStartKey: weekStartKey ?? this.weekStartKey,
      payloadJson: payloadJson ?? this.payloadJson,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (weekStartKey.present) {
      map['week_start_key'] = Variable<String>(weekStartKey.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedTimetablesCompanion(')
          ..write('accountId: $accountId, ')
          ..write('weekStartKey: $weekStartKey, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedGradesTable extends CachedGrades
    with TableInfo<$CachedGradesTable, CachedGrade> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedGradesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _semesterKeyMeta = const VerificationMeta(
    'semesterKey',
  );
  @override
  late final GeneratedColumn<String> semesterKey = GeneratedColumn<String>(
    'semester_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    accountId,
    semesterKey,
    payloadJson,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_grades';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedGrade> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('semester_key')) {
      context.handle(
        _semesterKeyMeta,
        semesterKey.isAcceptableOrUnknown(
          data['semester_key']!,
          _semesterKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_semesterKeyMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_syncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId, semesterKey};
  @override
  CachedGrade map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedGrade(
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      semesterKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}semester_key'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      )!,
    );
  }

  @override
  $CachedGradesTable createAlias(String alias) {
    return $CachedGradesTable(attachedDatabase, alias);
  }
}

class CachedGrade extends DataClass implements Insertable<CachedGrade> {
  final String accountId;
  final String semesterKey;
  final String payloadJson;
  final DateTime syncedAt;
  const CachedGrade({
    required this.accountId,
    required this.semesterKey,
    required this.payloadJson,
    required this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<String>(accountId);
    map['semester_key'] = Variable<String>(semesterKey);
    map['payload_json'] = Variable<String>(payloadJson);
    map['synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  CachedGradesCompanion toCompanion(bool nullToAbsent) {
    return CachedGradesCompanion(
      accountId: Value(accountId),
      semesterKey: Value(semesterKey),
      payloadJson: Value(payloadJson),
      syncedAt: Value(syncedAt),
    );
  }

  factory CachedGrade.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedGrade(
      accountId: serializer.fromJson<String>(json['accountId']),
      semesterKey: serializer.fromJson<String>(json['semesterKey']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<String>(accountId),
      'semesterKey': serializer.toJson<String>(semesterKey),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  CachedGrade copyWith({
    String? accountId,
    String? semesterKey,
    String? payloadJson,
    DateTime? syncedAt,
  }) => CachedGrade(
    accountId: accountId ?? this.accountId,
    semesterKey: semesterKey ?? this.semesterKey,
    payloadJson: payloadJson ?? this.payloadJson,
    syncedAt: syncedAt ?? this.syncedAt,
  );
  CachedGrade copyWithCompanion(CachedGradesCompanion data) {
    return CachedGrade(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      semesterKey: data.semesterKey.present
          ? data.semesterKey.value
          : this.semesterKey,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedGrade(')
          ..write('accountId: $accountId, ')
          ..write('semesterKey: $semesterKey, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(accountId, semesterKey, payloadJson, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedGrade &&
          other.accountId == this.accountId &&
          other.semesterKey == this.semesterKey &&
          other.payloadJson == this.payloadJson &&
          other.syncedAt == this.syncedAt);
}

class CachedGradesCompanion extends UpdateCompanion<CachedGrade> {
  final Value<String> accountId;
  final Value<String> semesterKey;
  final Value<String> payloadJson;
  final Value<DateTime> syncedAt;
  final Value<int> rowid;
  const CachedGradesCompanion({
    this.accountId = const Value.absent(),
    this.semesterKey = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedGradesCompanion.insert({
    required String accountId,
    required String semesterKey,
    required String payloadJson,
    required DateTime syncedAt,
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId),
       semesterKey = Value(semesterKey),
       payloadJson = Value(payloadJson),
       syncedAt = Value(syncedAt);
  static Insertable<CachedGrade> custom({
    Expression<String>? accountId,
    Expression<String>? semesterKey,
    Expression<String>? payloadJson,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (semesterKey != null) 'semester_key': semesterKey,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedGradesCompanion copyWith({
    Value<String>? accountId,
    Value<String>? semesterKey,
    Value<String>? payloadJson,
    Value<DateTime>? syncedAt,
    Value<int>? rowid,
  }) {
    return CachedGradesCompanion(
      accountId: accountId ?? this.accountId,
      semesterKey: semesterKey ?? this.semesterKey,
      payloadJson: payloadJson ?? this.payloadJson,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (semesterKey.present) {
      map['semester_key'] = Variable<String>(semesterKey.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedGradesCompanion(')
          ..write('accountId: $accountId, ')
          ..write('semesterKey: $semesterKey, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$CampusMateDatabase extends GeneratedDatabase {
  _$CampusMateDatabase(QueryExecutor e) : super(e);
  $CampusMateDatabaseManager get managers => $CampusMateDatabaseManager(this);
  late final $CachedAcademicProfilesTable cachedAcademicProfiles =
      $CachedAcademicProfilesTable(this);
  late final $CachedTimetablesTable cachedTimetables = $CachedTimetablesTable(
    this,
  );
  late final $CachedGradesTable cachedGrades = $CachedGradesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedAcademicProfiles,
    cachedTimetables,
    cachedGrades,
  ];
}

typedef $$CachedAcademicProfilesTableCreateCompanionBuilder =
    CachedAcademicProfilesCompanion Function({
      required String accountId,
      required String payloadJson,
      required DateTime syncedAt,
      Value<int> rowid,
    });
typedef $$CachedAcademicProfilesTableUpdateCompanionBuilder =
    CachedAcademicProfilesCompanion Function({
      Value<String> accountId,
      Value<String> payloadJson,
      Value<DateTime> syncedAt,
      Value<int> rowid,
    });

class $$CachedAcademicProfilesTableFilterComposer
    extends Composer<_$CampusMateDatabase, $CachedAcademicProfilesTable> {
  $$CachedAcademicProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedAcademicProfilesTableOrderingComposer
    extends Composer<_$CampusMateDatabase, $CachedAcademicProfilesTable> {
  $$CachedAcademicProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedAcademicProfilesTableAnnotationComposer
    extends Composer<_$CampusMateDatabase, $CachedAcademicProfilesTable> {
  $$CachedAcademicProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CachedAcademicProfilesTableTableManager
    extends
        RootTableManager<
          _$CampusMateDatabase,
          $CachedAcademicProfilesTable,
          CachedAcademicProfile,
          $$CachedAcademicProfilesTableFilterComposer,
          $$CachedAcademicProfilesTableOrderingComposer,
          $$CachedAcademicProfilesTableAnnotationComposer,
          $$CachedAcademicProfilesTableCreateCompanionBuilder,
          $$CachedAcademicProfilesTableUpdateCompanionBuilder,
          (
            CachedAcademicProfile,
            BaseReferences<
              _$CampusMateDatabase,
              $CachedAcademicProfilesTable,
              CachedAcademicProfile
            >,
          ),
          CachedAcademicProfile,
          PrefetchHooks Function()
        > {
  $$CachedAcademicProfilesTableTableManager(
    _$CampusMateDatabase db,
    $CachedAcademicProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedAcademicProfilesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CachedAcademicProfilesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CachedAcademicProfilesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> accountId = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedAcademicProfilesCompanion(
                accountId: accountId,
                payloadJson: payloadJson,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String accountId,
                required String payloadJson,
                required DateTime syncedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedAcademicProfilesCompanion.insert(
                accountId: accountId,
                payloadJson: payloadJson,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $CachedAcademicProfilesTable,
                    CachedAcademicProfile
                  >(table),
                  BaseReferences<
                    _$CampusMateDatabase,
                    $CachedAcademicProfilesTable,
                    CachedAcademicProfile
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedAcademicProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$CampusMateDatabase,
      $CachedAcademicProfilesTable,
      CachedAcademicProfile,
      $$CachedAcademicProfilesTableFilterComposer,
      $$CachedAcademicProfilesTableOrderingComposer,
      $$CachedAcademicProfilesTableAnnotationComposer,
      $$CachedAcademicProfilesTableCreateCompanionBuilder,
      $$CachedAcademicProfilesTableUpdateCompanionBuilder,
      (
        CachedAcademicProfile,
        BaseReferences<
          _$CampusMateDatabase,
          $CachedAcademicProfilesTable,
          CachedAcademicProfile
        >,
      ),
      CachedAcademicProfile,
      PrefetchHooks Function()
    >;
typedef $$CachedTimetablesTableCreateCompanionBuilder =
    CachedTimetablesCompanion Function({
      required String accountId,
      required String weekStartKey,
      required String payloadJson,
      required DateTime syncedAt,
      Value<int> rowid,
    });
typedef $$CachedTimetablesTableUpdateCompanionBuilder =
    CachedTimetablesCompanion Function({
      Value<String> accountId,
      Value<String> weekStartKey,
      Value<String> payloadJson,
      Value<DateTime> syncedAt,
      Value<int> rowid,
    });

class $$CachedTimetablesTableFilterComposer
    extends Composer<_$CampusMateDatabase, $CachedTimetablesTable> {
  $$CachedTimetablesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weekStartKey => $composableBuilder(
    column: $table.weekStartKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedTimetablesTableOrderingComposer
    extends Composer<_$CampusMateDatabase, $CachedTimetablesTable> {
  $$CachedTimetablesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weekStartKey => $composableBuilder(
    column: $table.weekStartKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedTimetablesTableAnnotationComposer
    extends Composer<_$CampusMateDatabase, $CachedTimetablesTable> {
  $$CachedTimetablesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get weekStartKey => $composableBuilder(
    column: $table.weekStartKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CachedTimetablesTableTableManager
    extends
        RootTableManager<
          _$CampusMateDatabase,
          $CachedTimetablesTable,
          CachedTimetable,
          $$CachedTimetablesTableFilterComposer,
          $$CachedTimetablesTableOrderingComposer,
          $$CachedTimetablesTableAnnotationComposer,
          $$CachedTimetablesTableCreateCompanionBuilder,
          $$CachedTimetablesTableUpdateCompanionBuilder,
          (
            CachedTimetable,
            BaseReferences<
              _$CampusMateDatabase,
              $CachedTimetablesTable,
              CachedTimetable
            >,
          ),
          CachedTimetable,
          PrefetchHooks Function()
        > {
  $$CachedTimetablesTableTableManager(
    _$CampusMateDatabase db,
    $CachedTimetablesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedTimetablesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedTimetablesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedTimetablesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> accountId = const Value.absent(),
                Value<String> weekStartKey = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedTimetablesCompanion(
                accountId: accountId,
                weekStartKey: weekStartKey,
                payloadJson: payloadJson,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String accountId,
                required String weekStartKey,
                required String payloadJson,
                required DateTime syncedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedTimetablesCompanion.insert(
                accountId: accountId,
                weekStartKey: weekStartKey,
                payloadJson: payloadJson,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CachedTimetablesTable, CachedTimetable>(table),
                  BaseReferences<
                    _$CampusMateDatabase,
                    $CachedTimetablesTable,
                    CachedTimetable
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedTimetablesTableProcessedTableManager =
    ProcessedTableManager<
      _$CampusMateDatabase,
      $CachedTimetablesTable,
      CachedTimetable,
      $$CachedTimetablesTableFilterComposer,
      $$CachedTimetablesTableOrderingComposer,
      $$CachedTimetablesTableAnnotationComposer,
      $$CachedTimetablesTableCreateCompanionBuilder,
      $$CachedTimetablesTableUpdateCompanionBuilder,
      (
        CachedTimetable,
        BaseReferences<
          _$CampusMateDatabase,
          $CachedTimetablesTable,
          CachedTimetable
        >,
      ),
      CachedTimetable,
      PrefetchHooks Function()
    >;
typedef $$CachedGradesTableCreateCompanionBuilder =
    CachedGradesCompanion Function({
      required String accountId,
      required String semesterKey,
      required String payloadJson,
      required DateTime syncedAt,
      Value<int> rowid,
    });
typedef $$CachedGradesTableUpdateCompanionBuilder =
    CachedGradesCompanion Function({
      Value<String> accountId,
      Value<String> semesterKey,
      Value<String> payloadJson,
      Value<DateTime> syncedAt,
      Value<int> rowid,
    });

class $$CachedGradesTableFilterComposer
    extends Composer<_$CampusMateDatabase, $CachedGradesTable> {
  $$CachedGradesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get semesterKey => $composableBuilder(
    column: $table.semesterKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedGradesTableOrderingComposer
    extends Composer<_$CampusMateDatabase, $CachedGradesTable> {
  $$CachedGradesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get semesterKey => $composableBuilder(
    column: $table.semesterKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedGradesTableAnnotationComposer
    extends Composer<_$CampusMateDatabase, $CachedGradesTable> {
  $$CachedGradesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get semesterKey => $composableBuilder(
    column: $table.semesterKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CachedGradesTableTableManager
    extends
        RootTableManager<
          _$CampusMateDatabase,
          $CachedGradesTable,
          CachedGrade,
          $$CachedGradesTableFilterComposer,
          $$CachedGradesTableOrderingComposer,
          $$CachedGradesTableAnnotationComposer,
          $$CachedGradesTableCreateCompanionBuilder,
          $$CachedGradesTableUpdateCompanionBuilder,
          (
            CachedGrade,
            BaseReferences<
              _$CampusMateDatabase,
              $CachedGradesTable,
              CachedGrade
            >,
          ),
          CachedGrade,
          PrefetchHooks Function()
        > {
  $$CachedGradesTableTableManager(
    _$CampusMateDatabase db,
    $CachedGradesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedGradesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedGradesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedGradesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> accountId = const Value.absent(),
                Value<String> semesterKey = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedGradesCompanion(
                accountId: accountId,
                semesterKey: semesterKey,
                payloadJson: payloadJson,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String accountId,
                required String semesterKey,
                required String payloadJson,
                required DateTime syncedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedGradesCompanion.insert(
                accountId: accountId,
                semesterKey: semesterKey,
                payloadJson: payloadJson,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CachedGradesTable, CachedGrade>(table),
                  BaseReferences<
                    _$CampusMateDatabase,
                    $CachedGradesTable,
                    CachedGrade
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedGradesTableProcessedTableManager =
    ProcessedTableManager<
      _$CampusMateDatabase,
      $CachedGradesTable,
      CachedGrade,
      $$CachedGradesTableFilterComposer,
      $$CachedGradesTableOrderingComposer,
      $$CachedGradesTableAnnotationComposer,
      $$CachedGradesTableCreateCompanionBuilder,
      $$CachedGradesTableUpdateCompanionBuilder,
      (
        CachedGrade,
        BaseReferences<_$CampusMateDatabase, $CachedGradesTable, CachedGrade>,
      ),
      CachedGrade,
      PrefetchHooks Function()
    >;

class $CampusMateDatabaseManager {
  final _$CampusMateDatabase _db;
  $CampusMateDatabaseManager(this._db);
  $$CachedAcademicProfilesTableTableManager get cachedAcademicProfiles =>
      $$CachedAcademicProfilesTableTableManager(
        _db,
        _db.cachedAcademicProfiles,
      );
  $$CachedTimetablesTableTableManager get cachedTimetables =>
      $$CachedTimetablesTableTableManager(_db, _db.cachedTimetables);
  $$CachedGradesTableTableManager get cachedGrades =>
      $$CachedGradesTableTableManager(_db, _db.cachedGrades);
}
