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

abstract class AiMessage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AiMessage._({
    this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    this.citations,
    this.feedback,
    required this.createdAt,
  });

  factory AiMessage({
    int? id,
    required int conversationId,
    required String role,
    required String content,
    String? citations,
    String? feedback,
    required DateTime createdAt,
  }) = _AiMessageImpl;

  factory AiMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiMessage(
      id: jsonSerialization['id'] as int?,
      conversationId: jsonSerialization['conversationId'] as int,
      role: jsonSerialization['role'] as String,
      content: jsonSerialization['content'] as String,
      citations: jsonSerialization['citations'] as String?,
      feedback: jsonSerialization['feedback'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = AiMessageTable();

  static const db = AiMessageRepository._();

  @override
  int? id;

  int conversationId;

  String role;

  String content;

  String? citations;

  String? feedback;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AiMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiMessage copyWith({
    int? id,
    int? conversationId,
    String? role,
    String? content,
    String? citations,
    String? feedback,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiMessage',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'role': role,
      'content': content,
      if (citations != null) 'citations': citations,
      if (feedback != null) 'feedback': feedback,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiMessage',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'role': role,
      'content': content,
      if (citations != null) 'citations': citations,
      if (feedback != null) 'feedback': feedback,
      'createdAt': createdAt.toJson(),
    };
  }

  static AiMessageInclude include() {
    return AiMessageInclude._();
  }

  static AiMessageIncludeList includeList({
    _i1.WhereExpressionBuilder<AiMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AiMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AiMessageTable>? orderByList,
    AiMessageInclude? include,
  }) {
    return AiMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AiMessage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AiMessage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiMessageImpl extends AiMessage {
  _AiMessageImpl({
    int? id,
    required int conversationId,
    required String role,
    required String content,
    String? citations,
    String? feedback,
    required DateTime createdAt,
  }) : super._(
         id: id,
         conversationId: conversationId,
         role: role,
         content: content,
         citations: citations,
         feedback: feedback,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AiMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiMessage copyWith({
    Object? id = _Undefined,
    int? conversationId,
    String? role,
    String? content,
    Object? citations = _Undefined,
    Object? feedback = _Undefined,
    DateTime? createdAt,
  }) {
    return AiMessage(
      id: id is int? ? id : this.id,
      conversationId: conversationId ?? this.conversationId,
      role: role ?? this.role,
      content: content ?? this.content,
      citations: citations is String? ? citations : this.citations,
      feedback: feedback is String? ? feedback : this.feedback,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AiMessageUpdateTable extends _i1.UpdateTable<AiMessageTable> {
  AiMessageUpdateTable(super.table);

  _i1.ColumnValue<int, int> conversationId(int value) => _i1.ColumnValue(
    table.conversationId,
    value,
  );

  _i1.ColumnValue<String, String> role(String value) => _i1.ColumnValue(
    table.role,
    value,
  );

  _i1.ColumnValue<String, String> content(String value) => _i1.ColumnValue(
    table.content,
    value,
  );

  _i1.ColumnValue<String, String> citations(String? value) => _i1.ColumnValue(
    table.citations,
    value,
  );

  _i1.ColumnValue<String, String> feedback(String? value) => _i1.ColumnValue(
    table.feedback,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class AiMessageTable extends _i1.Table<int?> {
  AiMessageTable({super.tableRelation}) : super(tableName: 'ai_messages') {
    updateTable = AiMessageUpdateTable(this);
    conversationId = _i1.ColumnInt(
      'conversationId',
      this,
    );
    role = _i1.ColumnString(
      'role',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    citations = _i1.ColumnString(
      'citations',
      this,
    );
    feedback = _i1.ColumnString(
      'feedback',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final AiMessageUpdateTable updateTable;

  late final _i1.ColumnInt conversationId;

  late final _i1.ColumnString role;

  late final _i1.ColumnString content;

  late final _i1.ColumnString citations;

  late final _i1.ColumnString feedback;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    conversationId,
    role,
    content,
    citations,
    feedback,
    createdAt,
  ];
}

class AiMessageInclude extends _i1.IncludeObject {
  AiMessageInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AiMessage.t;
}

class AiMessageIncludeList extends _i1.IncludeList {
  AiMessageIncludeList._({
    _i1.WhereExpressionBuilder<AiMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AiMessage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AiMessage.t;
}

class AiMessageRepository {
  const AiMessageRepository._();

  /// Returns a list of [AiMessage]s matching the given query parameters.
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
  Future<List<AiMessage>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AiMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AiMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AiMessageTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AiMessage>(
      where: where?.call(AiMessage.t),
      orderBy: orderBy?.call(AiMessage.t),
      orderByList: orderByList?.call(AiMessage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AiMessage] matching the given query parameters.
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
  Future<AiMessage?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AiMessageTable>? where,
    int? offset,
    _i1.OrderByBuilder<AiMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AiMessageTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AiMessage>(
      where: where?.call(AiMessage.t),
      orderBy: orderBy?.call(AiMessage.t),
      orderByList: orderByList?.call(AiMessage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AiMessage] by its [id] or null if no such row exists.
  Future<AiMessage?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AiMessage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AiMessage]s in the list and returns the inserted rows.
  ///
  /// The returned [AiMessage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AiMessage>> insert(
    _i1.DatabaseSession session,
    List<AiMessage> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AiMessage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AiMessage] and returns the inserted row.
  ///
  /// The returned [AiMessage] will have its `id` field set.
  Future<AiMessage> insertRow(
    _i1.DatabaseSession session,
    AiMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AiMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AiMessage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AiMessage>> update(
    _i1.DatabaseSession session,
    List<AiMessage> rows, {
    _i1.ColumnSelections<AiMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AiMessage>(
      rows,
      columns: columns?.call(AiMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AiMessage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AiMessage> updateRow(
    _i1.DatabaseSession session,
    AiMessage row, {
    _i1.ColumnSelections<AiMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AiMessage>(
      row,
      columns: columns?.call(AiMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AiMessage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AiMessage?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AiMessageUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AiMessage>(
      id,
      columnValues: columnValues(AiMessage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AiMessage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AiMessage>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AiMessageUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AiMessageTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AiMessageTable>? orderBy,
    _i1.OrderByListBuilder<AiMessageTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AiMessage>(
      columnValues: columnValues(AiMessage.t.updateTable),
      where: where(AiMessage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AiMessage.t),
      orderByList: orderByList?.call(AiMessage.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AiMessage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AiMessage>> delete(
    _i1.DatabaseSession session,
    List<AiMessage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AiMessage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AiMessage].
  Future<AiMessage> deleteRow(
    _i1.DatabaseSession session,
    AiMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AiMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AiMessage>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AiMessageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AiMessage>(
      where: where(AiMessage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AiMessageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AiMessage>(
      where: where?.call(AiMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AiMessage] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AiMessageTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AiMessage>(
      where: where(AiMessage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
