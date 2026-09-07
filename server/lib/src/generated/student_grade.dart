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

abstract class StudentGrade
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StudentGrade._({
    this.id,
    required this.enrollmentId,
    required this.componentName,
    required this.weight,
    required this.score,
    required this.maxScore,
    this.letter,
    this.gradedAt,
  });

  factory StudentGrade({
    int? id,
    required int enrollmentId,
    required String componentName,
    required double weight,
    required double score,
    required double maxScore,
    String? letter,
    DateTime? gradedAt,
  }) = _StudentGradeImpl;

  factory StudentGrade.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentGrade(
      id: jsonSerialization['id'] as int?,
      enrollmentId: jsonSerialization['enrollmentId'] as int,
      componentName: jsonSerialization['componentName'] as String,
      weight: (jsonSerialization['weight'] as num).toDouble(),
      score: (jsonSerialization['score'] as num).toDouble(),
      maxScore: (jsonSerialization['maxScore'] as num).toDouble(),
      letter: jsonSerialization['letter'] as String?,
      gradedAt: jsonSerialization['gradedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['gradedAt']),
    );
  }

  static final t = StudentGradeTable();

  static const db = StudentGradeRepository._();

  @override
  int? id;

  int enrollmentId;

  String componentName;

  double weight;

  double score;

  double maxScore;

  String? letter;

  DateTime? gradedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StudentGrade]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StudentGrade copyWith({
    int? id,
    int? enrollmentId,
    String? componentName,
    double? weight,
    double? score,
    double? maxScore,
    String? letter,
    DateTime? gradedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentGrade',
      if (id != null) 'id': id,
      'enrollmentId': enrollmentId,
      'componentName': componentName,
      'weight': weight,
      'score': score,
      'maxScore': maxScore,
      if (letter != null) 'letter': letter,
      if (gradedAt != null) 'gradedAt': gradedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentGrade',
      if (id != null) 'id': id,
      'enrollmentId': enrollmentId,
      'componentName': componentName,
      'weight': weight,
      'score': score,
      'maxScore': maxScore,
      if (letter != null) 'letter': letter,
      if (gradedAt != null) 'gradedAt': gradedAt?.toJson(),
    };
  }

  static StudentGradeInclude include() {
    return StudentGradeInclude._();
  }

  static StudentGradeIncludeList includeList({
    _i1.WhereExpressionBuilder<StudentGradeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudentGradeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudentGradeTable>? orderByList,
    StudentGradeInclude? include,
  }) {
    return StudentGradeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudentGrade.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StudentGrade.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentGradeImpl extends StudentGrade {
  _StudentGradeImpl({
    int? id,
    required int enrollmentId,
    required String componentName,
    required double weight,
    required double score,
    required double maxScore,
    String? letter,
    DateTime? gradedAt,
  }) : super._(
         id: id,
         enrollmentId: enrollmentId,
         componentName: componentName,
         weight: weight,
         score: score,
         maxScore: maxScore,
         letter: letter,
         gradedAt: gradedAt,
       );

  /// Returns a shallow copy of this [StudentGrade]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StudentGrade copyWith({
    Object? id = _Undefined,
    int? enrollmentId,
    String? componentName,
    double? weight,
    double? score,
    double? maxScore,
    Object? letter = _Undefined,
    Object? gradedAt = _Undefined,
  }) {
    return StudentGrade(
      id: id is int? ? id : this.id,
      enrollmentId: enrollmentId ?? this.enrollmentId,
      componentName: componentName ?? this.componentName,
      weight: weight ?? this.weight,
      score: score ?? this.score,
      maxScore: maxScore ?? this.maxScore,
      letter: letter is String? ? letter : this.letter,
      gradedAt: gradedAt is DateTime? ? gradedAt : this.gradedAt,
    );
  }
}

class StudentGradeUpdateTable extends _i1.UpdateTable<StudentGradeTable> {
  StudentGradeUpdateTable(super.table);

  _i1.ColumnValue<int, int> enrollmentId(int value) => _i1.ColumnValue(
    table.enrollmentId,
    value,
  );

  _i1.ColumnValue<String, String> componentName(String value) =>
      _i1.ColumnValue(
        table.componentName,
        value,
      );

  _i1.ColumnValue<double, double> weight(double value) => _i1.ColumnValue(
    table.weight,
    value,
  );

  _i1.ColumnValue<double, double> score(double value) => _i1.ColumnValue(
    table.score,
    value,
  );

  _i1.ColumnValue<double, double> maxScore(double value) => _i1.ColumnValue(
    table.maxScore,
    value,
  );

  _i1.ColumnValue<String, String> letter(String? value) => _i1.ColumnValue(
    table.letter,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> gradedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.gradedAt,
        value,
      );
}

class StudentGradeTable extends _i1.Table<int?> {
  StudentGradeTable({super.tableRelation})
    : super(tableName: 'student_grades') {
    updateTable = StudentGradeUpdateTable(this);
    enrollmentId = _i1.ColumnInt(
      'enrollmentId',
      this,
    );
    componentName = _i1.ColumnString(
      'componentName',
      this,
    );
    weight = _i1.ColumnDouble(
      'weight',
      this,
    );
    score = _i1.ColumnDouble(
      'score',
      this,
    );
    maxScore = _i1.ColumnDouble(
      'maxScore',
      this,
    );
    letter = _i1.ColumnString(
      'letter',
      this,
    );
    gradedAt = _i1.ColumnDateTime(
      'gradedAt',
      this,
    );
  }

  late final StudentGradeUpdateTable updateTable;

  late final _i1.ColumnInt enrollmentId;

  late final _i1.ColumnString componentName;

  late final _i1.ColumnDouble weight;

  late final _i1.ColumnDouble score;

  late final _i1.ColumnDouble maxScore;

  late final _i1.ColumnString letter;

  late final _i1.ColumnDateTime gradedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    enrollmentId,
    componentName,
    weight,
    score,
    maxScore,
    letter,
    gradedAt,
  ];
}

class StudentGradeInclude extends _i1.IncludeObject {
  StudentGradeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StudentGrade.t;
}

class StudentGradeIncludeList extends _i1.IncludeList {
  StudentGradeIncludeList._({
    _i1.WhereExpressionBuilder<StudentGradeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StudentGrade.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StudentGrade.t;
}

class StudentGradeRepository {
  const StudentGradeRepository._();

  /// Returns a list of [StudentGrade]s matching the given query parameters.
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
  Future<List<StudentGrade>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudentGradeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudentGradeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudentGradeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StudentGrade>(
      where: where?.call(StudentGrade.t),
      orderBy: orderBy?.call(StudentGrade.t),
      orderByList: orderByList?.call(StudentGrade.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StudentGrade] matching the given query parameters.
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
  Future<StudentGrade?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudentGradeTable>? where,
    int? offset,
    _i1.OrderByBuilder<StudentGradeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudentGradeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StudentGrade>(
      where: where?.call(StudentGrade.t),
      orderBy: orderBy?.call(StudentGrade.t),
      orderByList: orderByList?.call(StudentGrade.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StudentGrade] by its [id] or null if no such row exists.
  Future<StudentGrade?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StudentGrade>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StudentGrade]s in the list and returns the inserted rows.
  ///
  /// The returned [StudentGrade]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<StudentGrade>> insert(
    _i1.DatabaseSession session,
    List<StudentGrade> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<StudentGrade>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [StudentGrade] and returns the inserted row.
  ///
  /// The returned [StudentGrade] will have its `id` field set.
  Future<StudentGrade> insertRow(
    _i1.DatabaseSession session,
    StudentGrade row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StudentGrade>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StudentGrade]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StudentGrade>> update(
    _i1.DatabaseSession session,
    List<StudentGrade> rows, {
    _i1.ColumnSelections<StudentGradeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StudentGrade>(
      rows,
      columns: columns?.call(StudentGrade.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudentGrade]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StudentGrade> updateRow(
    _i1.DatabaseSession session,
    StudentGrade row, {
    _i1.ColumnSelections<StudentGradeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StudentGrade>(
      row,
      columns: columns?.call(StudentGrade.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudentGrade] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StudentGrade?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<StudentGradeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StudentGrade>(
      id,
      columnValues: columnValues(StudentGrade.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StudentGrade]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StudentGrade>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<StudentGradeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StudentGradeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudentGradeTable>? orderBy,
    _i1.OrderByListBuilder<StudentGradeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StudentGrade>(
      columnValues: columnValues(StudentGrade.t.updateTable),
      where: where(StudentGrade.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudentGrade.t),
      orderByList: orderByList?.call(StudentGrade.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StudentGrade]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StudentGrade>> delete(
    _i1.DatabaseSession session,
    List<StudentGrade> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StudentGrade>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StudentGrade].
  Future<StudentGrade> deleteRow(
    _i1.DatabaseSession session,
    StudentGrade row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StudentGrade>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StudentGrade>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StudentGradeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StudentGrade>(
      where: where(StudentGrade.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudentGradeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StudentGrade>(
      where: where?.call(StudentGrade.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StudentGrade] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StudentGradeTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StudentGrade>(
      where: where(StudentGrade.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
