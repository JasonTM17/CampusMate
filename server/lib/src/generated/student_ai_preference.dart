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

abstract class StudentAiPreference
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StudentAiPreference._({
    this.id,
    required this.userId,
    required this.explanationStyle,
    required this.personalizationEnabled,
    required this.memoryEnabled,
    required this.updatedAt,
  });

  factory StudentAiPreference({
    int? id,
    required _i1.UuidValue userId,
    required String explanationStyle,
    required bool personalizationEnabled,
    required bool memoryEnabled,
    required DateTime updatedAt,
  }) = _StudentAiPreferenceImpl;

  factory StudentAiPreference.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentAiPreference(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      explanationStyle: jsonSerialization['explanationStyle'] as String,
      personalizationEnabled: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['personalizationEnabled'],
      ),
      memoryEnabled: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['memoryEnabled'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = StudentAiPreferenceTable();

  static const db = StudentAiPreferenceRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  String explanationStyle;

  bool personalizationEnabled;

  bool memoryEnabled;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StudentAiPreference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StudentAiPreference copyWith({
    int? id,
    _i1.UuidValue? userId,
    String? explanationStyle,
    bool? personalizationEnabled,
    bool? memoryEnabled,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentAiPreference',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'explanationStyle': explanationStyle,
      'personalizationEnabled': personalizationEnabled,
      'memoryEnabled': memoryEnabled,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentAiPreference',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'explanationStyle': explanationStyle,
      'personalizationEnabled': personalizationEnabled,
      'memoryEnabled': memoryEnabled,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static StudentAiPreferenceInclude include() {
    return StudentAiPreferenceInclude._();
  }

  static StudentAiPreferenceIncludeList includeList({
    _i1.WhereExpressionBuilder<StudentAiPreferenceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudentAiPreferenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudentAiPreferenceTable>? orderByList,
    StudentAiPreferenceInclude? include,
  }) {
    return StudentAiPreferenceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudentAiPreference.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StudentAiPreference.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentAiPreferenceImpl extends StudentAiPreference {
  _StudentAiPreferenceImpl({
    int? id,
    required _i1.UuidValue userId,
    required String explanationStyle,
    required bool personalizationEnabled,
    required bool memoryEnabled,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         explanationStyle: explanationStyle,
         personalizationEnabled: personalizationEnabled,
         memoryEnabled: memoryEnabled,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StudentAiPreference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StudentAiPreference copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    String? explanationStyle,
    bool? personalizationEnabled,
    bool? memoryEnabled,
    DateTime? updatedAt,
  }) {
    return StudentAiPreference(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      explanationStyle: explanationStyle ?? this.explanationStyle,
      personalizationEnabled:
          personalizationEnabled ?? this.personalizationEnabled,
      memoryEnabled: memoryEnabled ?? this.memoryEnabled,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class StudentAiPreferenceUpdateTable
    extends _i1.UpdateTable<StudentAiPreferenceTable> {
  StudentAiPreferenceUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> explanationStyle(String value) =>
      _i1.ColumnValue(
        table.explanationStyle,
        value,
      );

  _i1.ColumnValue<bool, bool> personalizationEnabled(bool value) =>
      _i1.ColumnValue(
        table.personalizationEnabled,
        value,
      );

  _i1.ColumnValue<bool, bool> memoryEnabled(bool value) => _i1.ColumnValue(
    table.memoryEnabled,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class StudentAiPreferenceTable extends _i1.Table<int?> {
  StudentAiPreferenceTable({super.tableRelation})
    : super(tableName: 'student_ai_preferences') {
    updateTable = StudentAiPreferenceUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    explanationStyle = _i1.ColumnString(
      'explanationStyle',
      this,
    );
    personalizationEnabled = _i1.ColumnBool(
      'personalizationEnabled',
      this,
    );
    memoryEnabled = _i1.ColumnBool(
      'memoryEnabled',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final StudentAiPreferenceUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnString explanationStyle;

  late final _i1.ColumnBool personalizationEnabled;

  late final _i1.ColumnBool memoryEnabled;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    explanationStyle,
    personalizationEnabled,
    memoryEnabled,
    updatedAt,
  ];
}

class StudentAiPreferenceInclude extends _i1.IncludeObject {
  StudentAiPreferenceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StudentAiPreference.t;
}

class StudentAiPreferenceIncludeList extends _i1.IncludeList {
  StudentAiPreferenceIncludeList._({
    _i1.WhereExpressionBuilder<StudentAiPreferenceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StudentAiPreference.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StudentAiPreference.t;
}

class StudentAiPreferenceRepository {
  const StudentAiPreferenceRepository._();

  /// Returns a list of [StudentAiPreference]s matching the given query parameters.
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
  Future<List<StudentAiPreference>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudentAiPreferenceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudentAiPreferenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudentAiPreferenceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StudentAiPreference>(
      where: where?.call(StudentAiPreference.t),
      orderBy: orderBy?.call(StudentAiPreference.t),
      orderByList: orderByList?.call(StudentAiPreference.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StudentAiPreference] matching the given query parameters.
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
  Future<StudentAiPreference?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudentAiPreferenceTable>? where,
    int? offset,
    _i1.OrderByBuilder<StudentAiPreferenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudentAiPreferenceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StudentAiPreference>(
      where: where?.call(StudentAiPreference.t),
      orderBy: orderBy?.call(StudentAiPreference.t),
      orderByList: orderByList?.call(StudentAiPreference.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StudentAiPreference] by its [id] or null if no such row exists.
  Future<StudentAiPreference?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StudentAiPreference>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StudentAiPreference]s in the list and returns the inserted rows.
  ///
  /// The returned [StudentAiPreference]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<StudentAiPreference>> insert(
    _i1.DatabaseSession session,
    List<StudentAiPreference> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<StudentAiPreference>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [StudentAiPreference] and returns the inserted row.
  ///
  /// The returned [StudentAiPreference] will have its `id` field set.
  Future<StudentAiPreference> insertRow(
    _i1.DatabaseSession session,
    StudentAiPreference row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StudentAiPreference>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StudentAiPreference]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StudentAiPreference>> update(
    _i1.DatabaseSession session,
    List<StudentAiPreference> rows, {
    _i1.ColumnSelections<StudentAiPreferenceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StudentAiPreference>(
      rows,
      columns: columns?.call(StudentAiPreference.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudentAiPreference]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StudentAiPreference> updateRow(
    _i1.DatabaseSession session,
    StudentAiPreference row, {
    _i1.ColumnSelections<StudentAiPreferenceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StudentAiPreference>(
      row,
      columns: columns?.call(StudentAiPreference.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudentAiPreference] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StudentAiPreference?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<StudentAiPreferenceUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StudentAiPreference>(
      id,
      columnValues: columnValues(StudentAiPreference.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StudentAiPreference]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StudentAiPreference>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<StudentAiPreferenceUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<StudentAiPreferenceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudentAiPreferenceTable>? orderBy,
    _i1.OrderByListBuilder<StudentAiPreferenceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StudentAiPreference>(
      columnValues: columnValues(StudentAiPreference.t.updateTable),
      where: where(StudentAiPreference.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudentAiPreference.t),
      orderByList: orderByList?.call(StudentAiPreference.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StudentAiPreference]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StudentAiPreference>> delete(
    _i1.DatabaseSession session,
    List<StudentAiPreference> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StudentAiPreference>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StudentAiPreference].
  Future<StudentAiPreference> deleteRow(
    _i1.DatabaseSession session,
    StudentAiPreference row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StudentAiPreference>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StudentAiPreference>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StudentAiPreferenceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StudentAiPreference>(
      where: where(StudentAiPreference.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudentAiPreferenceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StudentAiPreference>(
      where: where?.call(StudentAiPreference.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StudentAiPreference] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StudentAiPreferenceTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StudentAiPreference>(
      where: where(StudentAiPreference.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
