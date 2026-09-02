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

abstract class AiConversation
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AiConversation._({
    this.id,
    required this.title,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AiConversation({
    int? id,
    required String title,
    required String userId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AiConversationImpl;

  factory AiConversation.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiConversation(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      userId: jsonSerialization['userId'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = AiConversationTable();

  static const db = AiConversationRepository._();

  @override
  int? id;

  String title;

  String userId;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AiConversation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiConversation copyWith({
    int? id,
    String? title,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiConversation',
      if (id != null) 'id': id,
      'title': title,
      'userId': userId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiConversation',
      if (id != null) 'id': id,
      'title': title,
      'userId': userId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AiConversationInclude include() {
    return AiConversationInclude._();
  }

  static AiConversationIncludeList includeList({
    _i1.WhereExpressionBuilder<AiConversationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AiConversationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AiConversationTable>? orderByList,
    AiConversationInclude? include,
  }) {
    return AiConversationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AiConversation.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AiConversation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiConversationImpl extends AiConversation {
  _AiConversationImpl({
    int? id,
    required String title,
    required String userId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         title: title,
         userId: userId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AiConversation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiConversation copyWith({
    Object? id = _Undefined,
    String? title,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AiConversation(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AiConversationUpdateTable extends _i1.UpdateTable<AiConversationTable> {
  AiConversationUpdateTable(super.table);

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
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

class AiConversationTable extends _i1.Table<int?> {
  AiConversationTable({super.tableRelation})
    : super(tableName: 'ai_conversations') {
    updateTable = AiConversationUpdateTable(this);
    title = _i1.ColumnString(
      'title',
      this,
    );
    userId = _i1.ColumnString(
      'userId',
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

  late final AiConversationUpdateTable updateTable;

  late final _i1.ColumnString title;

  late final _i1.ColumnString userId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    title,
    userId,
    createdAt,
    updatedAt,
  ];
}

class AiConversationInclude extends _i1.IncludeObject {
  AiConversationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AiConversation.t;
}

class AiConversationIncludeList extends _i1.IncludeList {
  AiConversationIncludeList._({
    _i1.WhereExpressionBuilder<AiConversationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AiConversation.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AiConversation.t;
}

class AiConversationRepository {
  const AiConversationRepository._();

  /// Returns a list of [AiConversation]s matching the given query parameters.
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
  Future<List<AiConversation>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AiConversationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AiConversationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AiConversationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AiConversation>(
      where: where?.call(AiConversation.t),
      orderBy: orderBy?.call(AiConversation.t),
      orderByList: orderByList?.call(AiConversation.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AiConversation] matching the given query parameters.
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
  Future<AiConversation?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AiConversationTable>? where,
    int? offset,
    _i1.OrderByBuilder<AiConversationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AiConversationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AiConversation>(
      where: where?.call(AiConversation.t),
      orderBy: orderBy?.call(AiConversation.t),
      orderByList: orderByList?.call(AiConversation.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AiConversation] by its [id] or null if no such row exists.
  Future<AiConversation?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AiConversation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AiConversation]s in the list and returns the inserted rows.
  ///
  /// The returned [AiConversation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AiConversation>> insert(
    _i1.DatabaseSession session,
    List<AiConversation> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AiConversation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AiConversation] and returns the inserted row.
  ///
  /// The returned [AiConversation] will have its `id` field set.
  Future<AiConversation> insertRow(
    _i1.DatabaseSession session,
    AiConversation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AiConversation>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AiConversation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AiConversation>> update(
    _i1.DatabaseSession session,
    List<AiConversation> rows, {
    _i1.ColumnSelections<AiConversationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AiConversation>(
      rows,
      columns: columns?.call(AiConversation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AiConversation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AiConversation> updateRow(
    _i1.DatabaseSession session,
    AiConversation row, {
    _i1.ColumnSelections<AiConversationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AiConversation>(
      row,
      columns: columns?.call(AiConversation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AiConversation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AiConversation?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AiConversationUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AiConversation>(
      id,
      columnValues: columnValues(AiConversation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AiConversation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AiConversation>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AiConversationUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AiConversationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AiConversationTable>? orderBy,
    _i1.OrderByListBuilder<AiConversationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AiConversation>(
      columnValues: columnValues(AiConversation.t.updateTable),
      where: where(AiConversation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AiConversation.t),
      orderByList: orderByList?.call(AiConversation.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AiConversation]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AiConversation>> delete(
    _i1.DatabaseSession session,
    List<AiConversation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AiConversation>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AiConversation].
  Future<AiConversation> deleteRow(
    _i1.DatabaseSession session,
    AiConversation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AiConversation>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AiConversation>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AiConversationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AiConversation>(
      where: where(AiConversation.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AiConversationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AiConversation>(
      where: where?.call(AiConversation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AiConversation] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AiConversationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AiConversation>(
      where: where(AiConversation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
