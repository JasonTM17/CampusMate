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

abstract class AiUsage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AiUsage._({
    this.id,
    required this.userId,
    required this.day,
    required this.requestCount,
    required this.inputTokens,
    required this.outputTokens,
    required this.estimatedCost,
  });

  factory AiUsage({
    int? id,
    required String userId,
    required DateTime day,
    required int requestCount,
    required int inputTokens,
    required int outputTokens,
    required int estimatedCost,
  }) = _AiUsageImpl;

  factory AiUsage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiUsage(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      day: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['day']),
      requestCount: jsonSerialization['requestCount'] as int,
      inputTokens: jsonSerialization['inputTokens'] as int,
      outputTokens: jsonSerialization['outputTokens'] as int,
      estimatedCost: jsonSerialization['estimatedCost'] as int,
    );
  }

  static final t = AiUsageTable();

  static const db = AiUsageRepository._();

  @override
  int? id;

  String userId;

  DateTime day;

  int requestCount;

  int inputTokens;

  int outputTokens;

  int estimatedCost;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AiUsage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiUsage copyWith({
    int? id,
    String? userId,
    DateTime? day,
    int? requestCount,
    int? inputTokens,
    int? outputTokens,
    int? estimatedCost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiUsage',
      if (id != null) 'id': id,
      'userId': userId,
      'day': day.toJson(),
      'requestCount': requestCount,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'estimatedCost': estimatedCost,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiUsage',
      if (id != null) 'id': id,
      'userId': userId,
      'day': day.toJson(),
      'requestCount': requestCount,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'estimatedCost': estimatedCost,
    };
  }

  static AiUsageInclude include() {
    return AiUsageInclude._();
  }

  static AiUsageIncludeList includeList({
    _i1.WhereExpressionBuilder<AiUsageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AiUsageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AiUsageTable>? orderByList,
    AiUsageInclude? include,
  }) {
    return AiUsageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AiUsage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AiUsage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiUsageImpl extends AiUsage {
  _AiUsageImpl({
    int? id,
    required String userId,
    required DateTime day,
    required int requestCount,
    required int inputTokens,
    required int outputTokens,
    required int estimatedCost,
  }) : super._(
         id: id,
         userId: userId,
         day: day,
         requestCount: requestCount,
         inputTokens: inputTokens,
         outputTokens: outputTokens,
         estimatedCost: estimatedCost,
       );

  /// Returns a shallow copy of this [AiUsage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiUsage copyWith({
    Object? id = _Undefined,
    String? userId,
    DateTime? day,
    int? requestCount,
    int? inputTokens,
    int? outputTokens,
    int? estimatedCost,
  }) {
    return AiUsage(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      day: day ?? this.day,
      requestCount: requestCount ?? this.requestCount,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      estimatedCost: estimatedCost ?? this.estimatedCost,
    );
  }
}

class AiUsageUpdateTable extends _i1.UpdateTable<AiUsageTable> {
  AiUsageUpdateTable(super.table);

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> day(DateTime value) => _i1.ColumnValue(
    table.day,
    value,
  );

  _i1.ColumnValue<int, int> requestCount(int value) => _i1.ColumnValue(
    table.requestCount,
    value,
  );

  _i1.ColumnValue<int, int> inputTokens(int value) => _i1.ColumnValue(
    table.inputTokens,
    value,
  );

  _i1.ColumnValue<int, int> outputTokens(int value) => _i1.ColumnValue(
    table.outputTokens,
    value,
  );

  _i1.ColumnValue<int, int> estimatedCost(int value) => _i1.ColumnValue(
    table.estimatedCost,
    value,
  );
}

class AiUsageTable extends _i1.Table<int?> {
  AiUsageTable({super.tableRelation}) : super(tableName: 'ai_usage') {
    updateTable = AiUsageUpdateTable(this);
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    day = _i1.ColumnDateTime(
      'day',
      this,
    );
    requestCount = _i1.ColumnInt(
      'requestCount',
      this,
    );
    inputTokens = _i1.ColumnInt(
      'inputTokens',
      this,
    );
    outputTokens = _i1.ColumnInt(
      'outputTokens',
      this,
    );
    estimatedCost = _i1.ColumnInt(
      'estimatedCost',
      this,
    );
  }

  late final AiUsageUpdateTable updateTable;

  late final _i1.ColumnString userId;

  late final _i1.ColumnDateTime day;

  late final _i1.ColumnInt requestCount;

  late final _i1.ColumnInt inputTokens;

  late final _i1.ColumnInt outputTokens;

  late final _i1.ColumnInt estimatedCost;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    day,
    requestCount,
    inputTokens,
    outputTokens,
    estimatedCost,
  ];
}

class AiUsageInclude extends _i1.IncludeObject {
  AiUsageInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AiUsage.t;
}

class AiUsageIncludeList extends _i1.IncludeList {
  AiUsageIncludeList._({
    _i1.WhereExpressionBuilder<AiUsageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AiUsage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AiUsage.t;
}

class AiUsageRepository {
  const AiUsageRepository._();

  /// Returns a list of [AiUsage]s matching the given query parameters.
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
  Future<List<AiUsage>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AiUsageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AiUsageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AiUsageTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AiUsage>(
      where: where?.call(AiUsage.t),
      orderBy: orderBy?.call(AiUsage.t),
      orderByList: orderByList?.call(AiUsage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AiUsage] matching the given query parameters.
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
  Future<AiUsage?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AiUsageTable>? where,
    int? offset,
    _i1.OrderByBuilder<AiUsageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AiUsageTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AiUsage>(
      where: where?.call(AiUsage.t),
      orderBy: orderBy?.call(AiUsage.t),
      orderByList: orderByList?.call(AiUsage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AiUsage] by its [id] or null if no such row exists.
  Future<AiUsage?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AiUsage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AiUsage]s in the list and returns the inserted rows.
  ///
  /// The returned [AiUsage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AiUsage>> insert(
    _i1.DatabaseSession session,
    List<AiUsage> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AiUsage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AiUsage] and returns the inserted row.
  ///
  /// The returned [AiUsage] will have its `id` field set.
  Future<AiUsage> insertRow(
    _i1.DatabaseSession session,
    AiUsage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AiUsage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AiUsage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AiUsage>> update(
    _i1.DatabaseSession session,
    List<AiUsage> rows, {
    _i1.ColumnSelections<AiUsageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AiUsage>(
      rows,
      columns: columns?.call(AiUsage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AiUsage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AiUsage> updateRow(
    _i1.DatabaseSession session,
    AiUsage row, {
    _i1.ColumnSelections<AiUsageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AiUsage>(
      row,
      columns: columns?.call(AiUsage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AiUsage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AiUsage?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AiUsageUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AiUsage>(
      id,
      columnValues: columnValues(AiUsage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AiUsage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AiUsage>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AiUsageUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AiUsageTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AiUsageTable>? orderBy,
    _i1.OrderByListBuilder<AiUsageTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AiUsage>(
      columnValues: columnValues(AiUsage.t.updateTable),
      where: where(AiUsage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AiUsage.t),
      orderByList: orderByList?.call(AiUsage.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AiUsage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AiUsage>> delete(
    _i1.DatabaseSession session,
    List<AiUsage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AiUsage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AiUsage].
  Future<AiUsage> deleteRow(
    _i1.DatabaseSession session,
    AiUsage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AiUsage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AiUsage>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AiUsageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AiUsage>(
      where: where(AiUsage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AiUsageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AiUsage>(
      where: where?.call(AiUsage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AiUsage] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AiUsageTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AiUsage>(
      where: where(AiUsage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
