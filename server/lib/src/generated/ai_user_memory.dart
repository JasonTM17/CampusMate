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

abstract class AiUserMemory
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AiUserMemory._({
    this.id,
    required this.userId,
    required this.content,
    required this.source,
    required this.createdAt,
    this.disabledAt,
  });

  factory AiUserMemory({
    int? id,
    required _i1.UuidValue userId,
    required String content,
    required String source,
    required DateTime createdAt,
    DateTime? disabledAt,
  }) = _AiUserMemoryImpl;

  factory AiUserMemory.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiUserMemory(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      content: jsonSerialization['content'] as String,
      source: jsonSerialization['source'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      disabledAt: jsonSerialization['disabledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['disabledAt']),
    );
  }

  static final t = AiUserMemoryTable();

  static const db = AiUserMemoryRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  String content;

  String source;

  DateTime createdAt;

  DateTime? disabledAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AiUserMemory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiUserMemory copyWith({
    int? id,
    _i1.UuidValue? userId,
    String? content,
    String? source,
    DateTime? createdAt,
    DateTime? disabledAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiUserMemory',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'content': content,
      'source': source,
      'createdAt': createdAt.toJson(),
      if (disabledAt != null) 'disabledAt': disabledAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiUserMemory',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'content': content,
      'source': source,
      'createdAt': createdAt.toJson(),
      if (disabledAt != null) 'disabledAt': disabledAt?.toJson(),
    };
  }

  static AiUserMemoryInclude include() {
    return AiUserMemoryInclude._();
  }

  static AiUserMemoryIncludeList includeList({
    _i1.WhereExpressionBuilder<AiUserMemoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AiUserMemoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AiUserMemoryTable>? orderByList,
    AiUserMemoryInclude? include,
  }) {
    return AiUserMemoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AiUserMemory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AiUserMemory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiUserMemoryImpl extends AiUserMemory {
  _AiUserMemoryImpl({
    int? id,
    required _i1.UuidValue userId,
    required String content,
    required String source,
    required DateTime createdAt,
    DateTime? disabledAt,
  }) : super._(
         id: id,
         userId: userId,
         content: content,
         source: source,
         createdAt: createdAt,
         disabledAt: disabledAt,
       );

  /// Returns a shallow copy of this [AiUserMemory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiUserMemory copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    String? content,
    String? source,
    DateTime? createdAt,
    Object? disabledAt = _Undefined,
  }) {
    return AiUserMemory(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      disabledAt: disabledAt is DateTime? ? disabledAt : this.disabledAt,
    );
  }
}

class AiUserMemoryUpdateTable extends _i1.UpdateTable<AiUserMemoryTable> {
  AiUserMemoryUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> content(String value) => _i1.ColumnValue(
    table.content,
    value,
  );

  _i1.ColumnValue<String, String> source(String value) => _i1.ColumnValue(
    table.source,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> disabledAt(DateTime? value) =>
      _i1.ColumnValue(
        table.disabledAt,
        value,
      );
}

class AiUserMemoryTable extends _i1.Table<int?> {
  AiUserMemoryTable({super.tableRelation})
    : super(tableName: 'ai_user_memories') {
    updateTable = AiUserMemoryUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    source = _i1.ColumnString(
      'source',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    disabledAt = _i1.ColumnDateTime(
      'disabledAt',
      this,
    );
  }

  late final AiUserMemoryUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnString content;

  late final _i1.ColumnString source;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime disabledAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    content,
    source,
    createdAt,
    disabledAt,
  ];
}

class AiUserMemoryInclude extends _i1.IncludeObject {
  AiUserMemoryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AiUserMemory.t;
}

class AiUserMemoryIncludeList extends _i1.IncludeList {
  AiUserMemoryIncludeList._({
    _i1.WhereExpressionBuilder<AiUserMemoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AiUserMemory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AiUserMemory.t;
}

class AiUserMemoryRepository {
  const AiUserMemoryRepository._();

  /// Returns a list of [AiUserMemory]s matching the given query parameters.
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
  Future<List<AiUserMemory>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AiUserMemoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AiUserMemoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AiUserMemoryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AiUserMemory>(
      where: where?.call(AiUserMemory.t),
      orderBy: orderBy?.call(AiUserMemory.t),
      orderByList: orderByList?.call(AiUserMemory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AiUserMemory] matching the given query parameters.
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
  Future<AiUserMemory?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AiUserMemoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<AiUserMemoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AiUserMemoryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AiUserMemory>(
      where: where?.call(AiUserMemory.t),
      orderBy: orderBy?.call(AiUserMemory.t),
      orderByList: orderByList?.call(AiUserMemory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AiUserMemory] by its [id] or null if no such row exists.
  Future<AiUserMemory?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AiUserMemory>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AiUserMemory]s in the list and returns the inserted rows.
  ///
  /// The returned [AiUserMemory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AiUserMemory>> insert(
    _i1.DatabaseSession session,
    List<AiUserMemory> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AiUserMemory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AiUserMemory] and returns the inserted row.
  ///
  /// The returned [AiUserMemory] will have its `id` field set.
  Future<AiUserMemory> insertRow(
    _i1.DatabaseSession session,
    AiUserMemory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AiUserMemory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AiUserMemory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AiUserMemory>> update(
    _i1.DatabaseSession session,
    List<AiUserMemory> rows, {
    _i1.ColumnSelections<AiUserMemoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AiUserMemory>(
      rows,
      columns: columns?.call(AiUserMemory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AiUserMemory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AiUserMemory> updateRow(
    _i1.DatabaseSession session,
    AiUserMemory row, {
    _i1.ColumnSelections<AiUserMemoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AiUserMemory>(
      row,
      columns: columns?.call(AiUserMemory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AiUserMemory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AiUserMemory?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AiUserMemoryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AiUserMemory>(
      id,
      columnValues: columnValues(AiUserMemory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AiUserMemory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AiUserMemory>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AiUserMemoryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AiUserMemoryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AiUserMemoryTable>? orderBy,
    _i1.OrderByListBuilder<AiUserMemoryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AiUserMemory>(
      columnValues: columnValues(AiUserMemory.t.updateTable),
      where: where(AiUserMemory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AiUserMemory.t),
      orderByList: orderByList?.call(AiUserMemory.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AiUserMemory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AiUserMemory>> delete(
    _i1.DatabaseSession session,
    List<AiUserMemory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AiUserMemory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AiUserMemory].
  Future<AiUserMemory> deleteRow(
    _i1.DatabaseSession session,
    AiUserMemory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AiUserMemory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AiUserMemory>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AiUserMemoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AiUserMemory>(
      where: where(AiUserMemory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AiUserMemoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AiUserMemory>(
      where: where?.call(AiUserMemory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AiUserMemory] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AiUserMemoryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AiUserMemory>(
      where: where(AiUserMemory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
