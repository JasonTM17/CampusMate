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

abstract class AcademicYear
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AcademicYear._({
    this.id,
    required this.code,
    required this.name,
    required this.startsAt,
    required this.endsAt,
  });

  factory AcademicYear({
    int? id,
    required String code,
    required String name,
    required DateTime startsAt,
    required DateTime endsAt,
  }) = _AcademicYearImpl;

  factory AcademicYear.fromJson(Map<String, dynamic> jsonSerialization) {
    return AcademicYear(
      id: jsonSerialization['id'] as int?,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
    );
  }

  static final t = AcademicYearTable();

  static const db = AcademicYearRepository._();

  @override
  int? id;

  String code;

  String name;

  DateTime startsAt;

  DateTime endsAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AcademicYear]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AcademicYear copyWith({
    int? id,
    String? code,
    String? name,
    DateTime? startsAt,
    DateTime? endsAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AcademicYear',
      if (id != null) 'id': id,
      'code': code,
      'name': name,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AcademicYear',
      if (id != null) 'id': id,
      'code': code,
      'name': name,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
    };
  }

  static AcademicYearInclude include() {
    return AcademicYearInclude._();
  }

  static AcademicYearIncludeList includeList({
    _i1.WhereExpressionBuilder<AcademicYearTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AcademicYearTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AcademicYearTable>? orderByList,
    AcademicYearInclude? include,
  }) {
    return AcademicYearIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AcademicYear.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AcademicYear.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AcademicYearImpl extends AcademicYear {
  _AcademicYearImpl({
    int? id,
    required String code,
    required String name,
    required DateTime startsAt,
    required DateTime endsAt,
  }) : super._(
         id: id,
         code: code,
         name: name,
         startsAt: startsAt,
         endsAt: endsAt,
       );

  /// Returns a shallow copy of this [AcademicYear]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AcademicYear copyWith({
    Object? id = _Undefined,
    String? code,
    String? name,
    DateTime? startsAt,
    DateTime? endsAt,
  }) {
    return AcademicYear(
      id: id is int? ? id : this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
    );
  }
}

class AcademicYearUpdateTable extends _i1.UpdateTable<AcademicYearTable> {
  AcademicYearUpdateTable(super.table);

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
}

class AcademicYearTable extends _i1.Table<int?> {
  AcademicYearTable({super.tableRelation})
    : super(tableName: 'academic_years') {
    updateTable = AcademicYearUpdateTable(this);
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
  }

  late final AcademicYearUpdateTable updateTable;

  late final _i1.ColumnString code;

  late final _i1.ColumnString name;

  late final _i1.ColumnDateTime startsAt;

  late final _i1.ColumnDateTime endsAt;

  @override
  List<_i1.Column> get columns => [
    id,
    code,
    name,
    startsAt,
    endsAt,
  ];
}

class AcademicYearInclude extends _i1.IncludeObject {
  AcademicYearInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AcademicYear.t;
}

class AcademicYearIncludeList extends _i1.IncludeList {
  AcademicYearIncludeList._({
    _i1.WhereExpressionBuilder<AcademicYearTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AcademicYear.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AcademicYear.t;
}

class AcademicYearRepository {
  const AcademicYearRepository._();

  /// Returns a list of [AcademicYear]s matching the given query parameters.
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
  Future<List<AcademicYear>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AcademicYearTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AcademicYearTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AcademicYearTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AcademicYear>(
      where: where?.call(AcademicYear.t),
      orderBy: orderBy?.call(AcademicYear.t),
      orderByList: orderByList?.call(AcademicYear.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AcademicYear] matching the given query parameters.
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
  Future<AcademicYear?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AcademicYearTable>? where,
    int? offset,
    _i1.OrderByBuilder<AcademicYearTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AcademicYearTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AcademicYear>(
      where: where?.call(AcademicYear.t),
      orderBy: orderBy?.call(AcademicYear.t),
      orderByList: orderByList?.call(AcademicYear.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AcademicYear] by its [id] or null if no such row exists.
  Future<AcademicYear?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AcademicYear>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AcademicYear]s in the list and returns the inserted rows.
  ///
  /// The returned [AcademicYear]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AcademicYear>> insert(
    _i1.DatabaseSession session,
    List<AcademicYear> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AcademicYear>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AcademicYear] and returns the inserted row.
  ///
  /// The returned [AcademicYear] will have its `id` field set.
  Future<AcademicYear> insertRow(
    _i1.DatabaseSession session,
    AcademicYear row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AcademicYear>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AcademicYear]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AcademicYear>> update(
    _i1.DatabaseSession session,
    List<AcademicYear> rows, {
    _i1.ColumnSelections<AcademicYearTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AcademicYear>(
      rows,
      columns: columns?.call(AcademicYear.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AcademicYear]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AcademicYear> updateRow(
    _i1.DatabaseSession session,
    AcademicYear row, {
    _i1.ColumnSelections<AcademicYearTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AcademicYear>(
      row,
      columns: columns?.call(AcademicYear.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AcademicYear] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AcademicYear?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AcademicYearUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AcademicYear>(
      id,
      columnValues: columnValues(AcademicYear.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AcademicYear]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AcademicYear>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AcademicYearUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AcademicYearTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AcademicYearTable>? orderBy,
    _i1.OrderByListBuilder<AcademicYearTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AcademicYear>(
      columnValues: columnValues(AcademicYear.t.updateTable),
      where: where(AcademicYear.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AcademicYear.t),
      orderByList: orderByList?.call(AcademicYear.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AcademicYear]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AcademicYear>> delete(
    _i1.DatabaseSession session,
    List<AcademicYear> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AcademicYear>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AcademicYear].
  Future<AcademicYear> deleteRow(
    _i1.DatabaseSession session,
    AcademicYear row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AcademicYear>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AcademicYear>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AcademicYearTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AcademicYear>(
      where: where(AcademicYear.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AcademicYearTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AcademicYear>(
      where: where?.call(AcademicYear.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AcademicYear] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AcademicYearTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AcademicYear>(
      where: where(AcademicYear.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
