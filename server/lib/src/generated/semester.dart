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

abstract class Semester
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Semester._({
    this.id,
    required this.academicYearId,
    required this.code,
    required this.name,
    required this.startsAt,
    required this.endsAt,
    required this.isCurrent,
  });

  factory Semester({
    int? id,
    required int academicYearId,
    required String code,
    required String name,
    required DateTime startsAt,
    required DateTime endsAt,
    required bool isCurrent,
  }) = _SemesterImpl;

  factory Semester.fromJson(Map<String, dynamic> jsonSerialization) {
    return Semester(
      id: jsonSerialization['id'] as int?,
      academicYearId: jsonSerialization['academicYearId'] as int,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      isCurrent: _i1.BoolJsonExtension.fromJson(jsonSerialization['isCurrent']),
    );
  }

  static final t = SemesterTable();

  static const db = SemesterRepository._();

  @override
  int? id;

  int academicYearId;

  String code;

  String name;

  DateTime startsAt;

  DateTime endsAt;

  bool isCurrent;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Semester]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Semester copyWith({
    int? id,
    int? academicYearId,
    String? code,
    String? name,
    DateTime? startsAt,
    DateTime? endsAt,
    bool? isCurrent,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Semester',
      if (id != null) 'id': id,
      'academicYearId': academicYearId,
      'code': code,
      'name': name,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'isCurrent': isCurrent,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Semester',
      if (id != null) 'id': id,
      'academicYearId': academicYearId,
      'code': code,
      'name': name,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'isCurrent': isCurrent,
    };
  }

  static SemesterInclude include() {
    return SemesterInclude._();
  }

  static SemesterIncludeList includeList({
    _i1.WhereExpressionBuilder<SemesterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SemesterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SemesterTable>? orderByList,
    SemesterInclude? include,
  }) {
    return SemesterIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Semester.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Semester.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SemesterImpl extends Semester {
  _SemesterImpl({
    int? id,
    required int academicYearId,
    required String code,
    required String name,
    required DateTime startsAt,
    required DateTime endsAt,
    required bool isCurrent,
  }) : super._(
         id: id,
         academicYearId: academicYearId,
         code: code,
         name: name,
         startsAt: startsAt,
         endsAt: endsAt,
         isCurrent: isCurrent,
       );

  /// Returns a shallow copy of this [Semester]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Semester copyWith({
    Object? id = _Undefined,
    int? academicYearId,
    String? code,
    String? name,
    DateTime? startsAt,
    DateTime? endsAt,
    bool? isCurrent,
  }) {
    return Semester(
      id: id is int? ? id : this.id,
      academicYearId: academicYearId ?? this.academicYearId,
      code: code ?? this.code,
      name: name ?? this.name,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }
}

class SemesterUpdateTable extends _i1.UpdateTable<SemesterTable> {
  SemesterUpdateTable(super.table);

  _i1.ColumnValue<int, int> academicYearId(int value) => _i1.ColumnValue(
    table.academicYearId,
    value,
  );

  _i1.ColumnValue<String, String> code(String value) => _i1.ColumnValue(
    table.code,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startsAt(DateTime value) =>
      _i1.ColumnValue(
        table.startsAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> endsAt(DateTime value) => _i1.ColumnValue(
    table.endsAt,
    value,
  );

  _i1.ColumnValue<bool, bool> isCurrent(bool value) => _i1.ColumnValue(
    table.isCurrent,
    value,
  );
}

class SemesterTable extends _i1.Table<int?> {
  SemesterTable({super.tableRelation}) : super(tableName: 'semesters') {
    updateTable = SemesterUpdateTable(this);
    academicYearId = _i1.ColumnInt(
      'academicYearId',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    startsAt = _i1.ColumnDateTime(
      'startsAt',
      this,
    );
    endsAt = _i1.ColumnDateTime(
      'endsAt',
      this,
    );
    isCurrent = _i1.ColumnBool(
      'isCurrent',
      this,
    );
  }

  late final SemesterUpdateTable updateTable;

  late final _i1.ColumnInt academicYearId;

  late final _i1.ColumnString code;

  late final _i1.ColumnString name;

  late final _i1.ColumnDateTime startsAt;

  late final _i1.ColumnDateTime endsAt;

  late final _i1.ColumnBool isCurrent;

  @override
  List<_i1.Column> get columns => [
    id,
    academicYearId,
    code,
    name,
    startsAt,
    endsAt,
    isCurrent,
  ];
}

class SemesterInclude extends _i1.IncludeObject {
  SemesterInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Semester.t;
}

class SemesterIncludeList extends _i1.IncludeList {
  SemesterIncludeList._({
    _i1.WhereExpressionBuilder<SemesterTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Semester.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Semester.t;
}

class SemesterRepository {
  const SemesterRepository._();

  /// Returns a list of [Semester]s matching the given query parameters.
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
  Future<List<Semester>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SemesterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SemesterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SemesterTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Semester>(
      where: where?.call(Semester.t),
      orderBy: orderBy?.call(Semester.t),
      orderByList: orderByList?.call(Semester.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Semester] matching the given query parameters.
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
  Future<Semester?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SemesterTable>? where,
    int? offset,
    _i1.OrderByBuilder<SemesterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SemesterTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Semester>(
      where: where?.call(Semester.t),
      orderBy: orderBy?.call(Semester.t),
      orderByList: orderByList?.call(Semester.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Semester] by its [id] or null if no such row exists.
  Future<Semester?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Semester>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Semester]s in the list and returns the inserted rows.
  ///
  /// The returned [Semester]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Semester>> insert(
    _i1.DatabaseSession session,
    List<Semester> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Semester>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Semester] and returns the inserted row.
  ///
  /// The returned [Semester] will have its `id` field set.
  Future<Semester> insertRow(
    _i1.DatabaseSession session,
    Semester row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Semester>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Semester]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Semester>> update(
    _i1.DatabaseSession session,
    List<Semester> rows, {
    _i1.ColumnSelections<SemesterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Semester>(
      rows,
      columns: columns?.call(Semester.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Semester]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Semester> updateRow(
    _i1.DatabaseSession session,
    Semester row, {
    _i1.ColumnSelections<SemesterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Semester>(
      row,
      columns: columns?.call(Semester.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Semester] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Semester?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SemesterUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Semester>(
      id,
      columnValues: columnValues(Semester.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Semester]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Semester>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SemesterUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SemesterTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SemesterTable>? orderBy,
    _i1.OrderByListBuilder<SemesterTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Semester>(
      columnValues: columnValues(Semester.t.updateTable),
      where: where(Semester.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Semester.t),
      orderByList: orderByList?.call(Semester.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Semester]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Semester>> delete(
    _i1.DatabaseSession session,
    List<Semester> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Semester>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Semester].
  Future<Semester> deleteRow(
    _i1.DatabaseSession session,
    Semester row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Semester>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Semester>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SemesterTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Semester>(
      where: where(Semester.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SemesterTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Semester>(
      where: where?.call(Semester.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Semester] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SemesterTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Semester>(
      where: where(Semester.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
