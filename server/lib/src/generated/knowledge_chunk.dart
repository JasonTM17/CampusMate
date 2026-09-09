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

abstract class KnowledgeChunk
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  KnowledgeChunk._({
    this.id,
    required this.documentId,
    this.bookId,
    required this.title,
    this.chapter,
    this.page,
    required this.content,
    required this.embedding,
    required this.createdAt,
  });

  factory KnowledgeChunk({
    int? id,
    required int documentId,
    int? bookId,
    required String title,
    String? chapter,
    int? page,
    required String content,
    required _i1.Vector embedding,
    required DateTime createdAt,
  }) = _KnowledgeChunkImpl;

  factory KnowledgeChunk.fromJson(Map<String, dynamic> jsonSerialization) {
    return KnowledgeChunk(
      id: jsonSerialization['id'] as int?,
      documentId: jsonSerialization['documentId'] as int,
      bookId: jsonSerialization['bookId'] as int?,
      title: jsonSerialization['title'] as String,
      chapter: jsonSerialization['chapter'] as String?,
      page: jsonSerialization['page'] as int?,
      content: jsonSerialization['content'] as String,
      embedding: _i1.VectorJsonExtension.fromJson(
        jsonSerialization['embedding'],
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = KnowledgeChunkTable();

  static const db = KnowledgeChunkRepository._();

  @override
  int? id;

  int documentId;

  int? bookId;

  String title;

  String? chapter;

  int? page;

  String content;

  _i1.Vector embedding;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [KnowledgeChunk]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  KnowledgeChunk copyWith({
    int? id,
    int? documentId,
    int? bookId,
    String? title,
    String? chapter,
    int? page,
    String? content,
    _i1.Vector? embedding,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'KnowledgeChunk',
      if (id != null) 'id': id,
      'documentId': documentId,
      if (bookId != null) 'bookId': bookId,
      'title': title,
      if (chapter != null) 'chapter': chapter,
      if (page != null) 'page': page,
      'content': content,
      'embedding': embedding.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'KnowledgeChunk',
      if (id != null) 'id': id,
      'documentId': documentId,
      if (bookId != null) 'bookId': bookId,
      'title': title,
      if (chapter != null) 'chapter': chapter,
      if (page != null) 'page': page,
      'content': content,
      'embedding': embedding.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static KnowledgeChunkInclude include() {
    return KnowledgeChunkInclude._();
  }

  static KnowledgeChunkIncludeList includeList({
    _i1.WhereExpressionBuilder<KnowledgeChunkTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<KnowledgeChunkTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<KnowledgeChunkTable>? orderByList,
    KnowledgeChunkInclude? include,
  }) {
    return KnowledgeChunkIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(KnowledgeChunk.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(KnowledgeChunk.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _KnowledgeChunkImpl extends KnowledgeChunk {
  _KnowledgeChunkImpl({
    int? id,
    required int documentId,
    int? bookId,
    required String title,
    String? chapter,
    int? page,
    required String content,
    required _i1.Vector embedding,
    required DateTime createdAt,
  }) : super._(
         id: id,
         documentId: documentId,
         bookId: bookId,
         title: title,
         chapter: chapter,
         page: page,
         content: content,
         embedding: embedding,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [KnowledgeChunk]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  KnowledgeChunk copyWith({
    Object? id = _Undefined,
    int? documentId,
    Object? bookId = _Undefined,
    String? title,
    Object? chapter = _Undefined,
    Object? page = _Undefined,
    String? content,
    _i1.Vector? embedding,
    DateTime? createdAt,
  }) {
    return KnowledgeChunk(
      id: id is int? ? id : this.id,
      documentId: documentId ?? this.documentId,
      bookId: bookId is int? ? bookId : this.bookId,
      title: title ?? this.title,
      chapter: chapter is String? ? chapter : this.chapter,
      page: page is int? ? page : this.page,
      content: content ?? this.content,
      embedding: embedding ?? this.embedding.clone(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class KnowledgeChunkUpdateTable extends _i1.UpdateTable<KnowledgeChunkTable> {
  KnowledgeChunkUpdateTable(super.table);

  _i1.ColumnValue<int, int> documentId(int value) => _i1.ColumnValue(
    table.documentId,
    value,
  );

  _i1.ColumnValue<int, int> bookId(int? value) => _i1.ColumnValue(
    table.bookId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> chapter(String? value) => _i1.ColumnValue(
    table.chapter,
    value,
  );

  _i1.ColumnValue<int, int> page(int? value) => _i1.ColumnValue(
    table.page,
    value,
  );

  _i1.ColumnValue<String, String> content(String value) => _i1.ColumnValue(
    table.content,
    value,
  );

  _i1.ColumnValue<_i1.Vector, _i1.Vector> embedding(_i1.Vector value) =>
      _i1.ColumnValue(
        table.embedding,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class KnowledgeChunkTable extends _i1.Table<int?> {
  KnowledgeChunkTable({super.tableRelation})
    : super(tableName: 'knowledge_chunks') {
    updateTable = KnowledgeChunkUpdateTable(this);
    documentId = _i1.ColumnInt(
      'documentId',
      this,
    );
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    chapter = _i1.ColumnString(
      'chapter',
      this,
    );
    page = _i1.ColumnInt(
      'page',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    embedding = _i1.ColumnVector(
      'embedding',
      this,
      dimension: 1536,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final KnowledgeChunkUpdateTable updateTable;

  late final _i1.ColumnInt documentId;

  late final _i1.ColumnInt bookId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString chapter;

  late final _i1.ColumnInt page;

  late final _i1.ColumnString content;

  late final _i1.ColumnVector embedding;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    documentId,
    bookId,
    title,
    chapter,
    page,
    content,
    embedding,
    createdAt,
  ];
}

class KnowledgeChunkInclude extends _i1.IncludeObject {
  KnowledgeChunkInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => KnowledgeChunk.t;
}

class KnowledgeChunkIncludeList extends _i1.IncludeList {
  KnowledgeChunkIncludeList._({
    _i1.WhereExpressionBuilder<KnowledgeChunkTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(KnowledgeChunk.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => KnowledgeChunk.t;
}

class KnowledgeChunkRepository {
  const KnowledgeChunkRepository._();

  /// Returns a list of [KnowledgeChunk]s matching the given query parameters.
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
  Future<List<KnowledgeChunk>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<KnowledgeChunkTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<KnowledgeChunkTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<KnowledgeChunkTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<KnowledgeChunk>(
      where: where?.call(KnowledgeChunk.t),
      orderBy: orderBy?.call(KnowledgeChunk.t),
      orderByList: orderByList?.call(KnowledgeChunk.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [KnowledgeChunk] matching the given query parameters.
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
  Future<KnowledgeChunk?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<KnowledgeChunkTable>? where,
    int? offset,
    _i1.OrderByBuilder<KnowledgeChunkTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<KnowledgeChunkTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<KnowledgeChunk>(
      where: where?.call(KnowledgeChunk.t),
      orderBy: orderBy?.call(KnowledgeChunk.t),
      orderByList: orderByList?.call(KnowledgeChunk.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [KnowledgeChunk] by its [id] or null if no such row exists.
  Future<KnowledgeChunk?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<KnowledgeChunk>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [KnowledgeChunk]s in the list and returns the inserted rows.
  ///
  /// The returned [KnowledgeChunk]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<KnowledgeChunk>> insert(
    _i1.DatabaseSession session,
    List<KnowledgeChunk> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<KnowledgeChunk>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [KnowledgeChunk] and returns the inserted row.
  ///
  /// The returned [KnowledgeChunk] will have its `id` field set.
  Future<KnowledgeChunk> insertRow(
    _i1.DatabaseSession session,
    KnowledgeChunk row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<KnowledgeChunk>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [KnowledgeChunk]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<KnowledgeChunk>> update(
    _i1.DatabaseSession session,
    List<KnowledgeChunk> rows, {
    _i1.ColumnSelections<KnowledgeChunkTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<KnowledgeChunk>(
      rows,
      columns: columns?.call(KnowledgeChunk.t),
      transaction: transaction,
    );
  }

  /// Updates a single [KnowledgeChunk]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<KnowledgeChunk> updateRow(
    _i1.DatabaseSession session,
    KnowledgeChunk row, {
    _i1.ColumnSelections<KnowledgeChunkTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<KnowledgeChunk>(
      row,
      columns: columns?.call(KnowledgeChunk.t),
      transaction: transaction,
    );
  }

  /// Updates a single [KnowledgeChunk] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<KnowledgeChunk?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<KnowledgeChunkUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<KnowledgeChunk>(
      id,
      columnValues: columnValues(KnowledgeChunk.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [KnowledgeChunk]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<KnowledgeChunk>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<KnowledgeChunkUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<KnowledgeChunkTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<KnowledgeChunkTable>? orderBy,
    _i1.OrderByListBuilder<KnowledgeChunkTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<KnowledgeChunk>(
      columnValues: columnValues(KnowledgeChunk.t.updateTable),
      where: where(KnowledgeChunk.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(KnowledgeChunk.t),
      orderByList: orderByList?.call(KnowledgeChunk.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [KnowledgeChunk]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<KnowledgeChunk>> delete(
    _i1.DatabaseSession session,
    List<KnowledgeChunk> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<KnowledgeChunk>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [KnowledgeChunk].
  Future<KnowledgeChunk> deleteRow(
    _i1.DatabaseSession session,
    KnowledgeChunk row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<KnowledgeChunk>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<KnowledgeChunk>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<KnowledgeChunkTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<KnowledgeChunk>(
      where: where(KnowledgeChunk.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<KnowledgeChunkTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<KnowledgeChunk>(
      where: where?.call(KnowledgeChunk.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [KnowledgeChunk] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<KnowledgeChunkTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<KnowledgeChunk>(
      where: where(KnowledgeChunk.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
