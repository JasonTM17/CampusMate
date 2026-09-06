/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;

abstract class StudentProfile
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StudentProfile._({
    this.id,
    required this.authUserId,
    this.studentCode,
    this.fullName,
    this.faculty,
    this.major,
    this.className,
    this.gpa,
    this.credits,
    this.conductScore,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentProfile({
    int? id,
    required _i1.UuidValue authUserId,
    String? studentCode,
    String? fullName,
    String? faculty,
    String? major,
    String? className,
    double? gpa,
    int? credits,
    double? conductScore,
    required String role,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _StudentProfileImpl;

  factory StudentProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentCode: jsonSerialization['studentCode'] as String?,
      fullName: jsonSerialization['fullName'] as String?,
      faculty: jsonSerialization['faculty'] as String?,
      major: jsonSerialization['major'] as String?,
      className: jsonSerialization['className'] as String?,
      gpa: (jsonSerialization['gpa'] as num?)?.toDouble(),
      credits: jsonSerialization['credits'] as int?,
      conductScore: (jsonSerialization['conductScore'] as num?)?.toDouble(),
      role: jsonSerialization['role'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = StudentProfileTable();

  static const db = StudentProfileRepository._();

  @override
  int? id;

  _i1.UuidValue authUserId;

  String? studentCode;

  String? fullName;

  String? faculty;

  String? major;

  String? className;

  double? gpa;

  int? credits;

  double? conductScore;

  String role;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StudentProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StudentProfile copyWith({
    int? id,
    _i1.UuidValue? authUserId,
    String? studentCode,
    String? fullName,
    String? faculty,
    String? major,
    String? className,
    double? gpa,
    int? credits,
    double? conductScore,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (studentCode != null) 'studentCode': studentCode,
      if (fullName != null) 'fullName': fullName,
      if (faculty != null) 'faculty': faculty,
      if (major != null) 'major': major,
      if (className != null) 'className': className,
      if (gpa != null) 'gpa': gpa,
      if (credits != null) 'credits': credits,
      if (conductScore != null) 'conductScore': conductScore,
      'role': role,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (studentCode != null) 'studentCode': studentCode,
      if (fullName != null) 'fullName': fullName,
      if (faculty != null) 'faculty': faculty,
      if (major != null) 'major': major,
      if (className != null) 'className': className,
      if (gpa != null) 'gpa': gpa,
      if (credits != null) 'credits': credits,
      if (conductScore != null) 'conductScore': conductScore,
      'role': role,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static StudentProfileInclude include() {
    return StudentProfileInclude._();
  }

  static StudentProfileIncludeList includeList({
    _i1.WhereExpressionBuilder<StudentProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudentProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudentProfileTable>? orderByList,
    StudentProfileInclude? include,
  }) {
    return StudentProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudentProfile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StudentProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentProfileImpl extends StudentProfile {
  _StudentProfileImpl({
    int? id,
    required _i1.UuidValue authUserId,
    String? studentCode,
    String? fullName,
    String? faculty,
    String? major,
    String? className,
    double? gpa,
    int? credits,
    double? conductScore,
    required String role,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         studentCode: studentCode,
         fullName: fullName,
         faculty: faculty,
         major: major,
         className: className,
         gpa: gpa,
         credits: credits,
         conductScore: conductScore,
         role: role,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StudentProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StudentProfile copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? authUserId,
    Object? studentCode = _Undefined,
    Object? fullName = _Undefined,
    Object? faculty = _Undefined,
    Object? major = _Undefined,
    Object? className = _Undefined,
    Object? gpa = _Undefined,
    Object? credits = _Undefined,
    Object? conductScore = _Undefined,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      studentCode: studentCode is String? ? studentCode : this.studentCode,
      fullName: fullName is String? ? fullName : this.fullName,
      faculty: faculty is String? ? faculty : this.faculty,
      major: major is String? ? major : this.major,
      className: className is String? ? className : this.className,
      gpa: gpa is double? ? gpa : this.gpa,
      credits: credits is int? ? credits : this.credits,
      conductScore: conductScore is double? ? conductScore : this.conductScore,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class StudentProfileUpdateTable extends _i1.UpdateTable<StudentProfileTable> {
  StudentProfileUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> authUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<String, String> studentCode(String? value) => _i1.ColumnValue(
    table.studentCode,
    value,
  );

  _i1.ColumnValue<String, String> fullName(String? value) => _i1.ColumnValue(
    table.fullName,
    value,
  );

  _i1.ColumnValue<String, String> faculty(String? value) => _i1.ColumnValue(
    table.faculty,
    value,
  );

  _i1.ColumnValue<String, String> major(String? value) => _i1.ColumnValue(
    table.major,
    value,
  );

  _i1.ColumnValue<String, String> className(String? value) => _i1.ColumnValue(
    table.className,
    value,
  );

  _i1.ColumnValue<double, double> gpa(double? value) => _i1.ColumnValue(
    table.gpa,
    value,
  );

  _i1.ColumnValue<int, int> credits(int? value) => _i1.ColumnValue(
    table.credits,
    value,
  );

  _i1.ColumnValue<double, double> conductScore(double? value) =>
      _i1.ColumnValue(
        table.conductScore,
        value,
      );

  _i1.ColumnValue<String, String> role(String value) => _i1.ColumnValue(
    table.role,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class StudentProfileTable extends _i1.Table<int?> {
  StudentProfileTable({super.tableRelation})
    : super(tableName: 'student_profiles') {
    updateTable = StudentProfileUpdateTable(this);
    authUserId = _i1.ColumnUuid(
      'authUserId',
      this,
    );
    studentCode = _i1.ColumnString(
      'studentCode',
      this,
    );
    fullName = _i1.ColumnString(
      'fullName',
      this,
    );
    faculty = _i1.ColumnString(
      'faculty',
      this,
    );
    major = _i1.ColumnString(
      'major',
      this,
    );
    className = _i1.ColumnString(
      'className',
      this,
    );
    gpa = _i1.ColumnDouble(
      'gpa',
      this,
    );
    credits = _i1.ColumnInt(
      'credits',
      this,
    );
    conductScore = _i1.ColumnDouble(
      'conductScore',
      this,
    );
    role = _i1.ColumnString(
      'role',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final StudentProfileUpdateTable updateTable;

  late final _i1.ColumnUuid authUserId;

  late final _i1.ColumnString studentCode;

  late final _i1.ColumnString fullName;

  late final _i1.ColumnString faculty;

  late final _i1.ColumnString major;

  late final _i1.ColumnString className;

  late final _i1.ColumnDouble gpa;

  late final _i1.ColumnInt credits;

  late final _i1.ColumnDouble conductScore;

  late final _i1.ColumnString role;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    authUserId,
    studentCode,
    fullName,
    faculty,
    major,
    className,
    gpa,
    credits,
    conductScore,
    role,
    createdAt,
    updatedAt,
  ];
}

class StudentProfileInclude extends _i1.IncludeObject {
  StudentProfileInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StudentProfile.t;
}

class StudentProfileIncludeList extends _i1.IncludeList {
  StudentProfileIncludeList._({
    _i1.WhereExpressionBuilder<StudentProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StudentProfile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StudentProfile.t;
}

class StudentProfileRepository {
  const StudentProfileRepository._();

  /// Returns a list of [StudentProfile]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<StudentProfile>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudentProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudentProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudentProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StudentProfile>(
      where: where?.call(StudentProfile.t),
      orderBy: orderBy?.call(StudentProfile.t),
      orderByList: orderByList?.call(StudentProfile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StudentProfile] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<StudentProfile?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudentProfileTable>? where,
    int? offset,
    _i1.OrderByBuilder<StudentProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudentProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StudentProfile>(
      where: where?.call(StudentProfile.t),
      orderBy: orderBy?.call(StudentProfile.t),
      orderByList: orderByList?.call(StudentProfile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StudentProfile] by its [id] or null if no such row exists.
  Future<StudentProfile?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StudentProfile>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StudentProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [StudentProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<StudentProfile>> insert(
    _i1.DatabaseSession session,
    List<StudentProfile> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<StudentProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [StudentProfile] and returns the inserted row.
  ///
  /// The returned [StudentProfile] will have its `id` field set.
  Future<StudentProfile> insertRow(
    _i1.DatabaseSession session,
    StudentProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StudentProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StudentProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StudentProfile>> update(
    _i1.DatabaseSession session,
    List<StudentProfile> rows, {
    _i1.ColumnSelections<StudentProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StudentProfile>(
      rows,
      columns: columns?.call(StudentProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudentProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StudentProfile> updateRow(
    _i1.DatabaseSession session,
    StudentProfile row, {
    _i1.ColumnSelections<StudentProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StudentProfile>(
      row,
      columns: columns?.call(StudentProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudentProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StudentProfile?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<StudentProfileUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StudentProfile>(
      id,
      columnValues: columnValues(StudentProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StudentProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StudentProfile>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<StudentProfileUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StudentProfileTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudentProfileTable>? orderBy,
    _i1.OrderByListBuilder<StudentProfileTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StudentProfile>(
      columnValues: columnValues(StudentProfile.t.updateTable),
      where: where(StudentProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudentProfile.t),
      orderByList: orderByList?.call(StudentProfile.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StudentProfile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StudentProfile>> delete(
    _i1.DatabaseSession session,
    List<StudentProfile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StudentProfile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StudentProfile].
  Future<StudentProfile> deleteRow(
    _i1.DatabaseSession session,
    StudentProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StudentProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StudentProfile>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StudentProfileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StudentProfile>(
      where: where(StudentProfile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudentProfileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StudentProfile>(
      where: where?.call(StudentProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StudentProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StudentProfileTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StudentProfile>(
      where: where(StudentProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
