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

abstract class KnowledgeDocument
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  KnowledgeDocument._({
    this.id,
    required this.title,
    required this.sourceType,
    this.bookId,
    required this.accessLevel,
    this.requiredCourseId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KnowledgeDocument({
    int? id,
    required String title,
    required String sourceType,
    int? bookId,
    required String accessLevel,
    int? requiredCourseId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _KnowledgeDocumentImpl;

  factory KnowledgeDocument.fromJson(Map<String, dynamic> jsonSerialization) {
    return KnowledgeDocument(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      sourceType: jsonSerialization['sourceType'] as String,
      bookId: jsonSerialization['bookId'] as int?,
      accessLevel: jsonSerialization['accessLevel'] as String,
      requiredCourseId: jsonSerialization['requiredCourseId'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = KnowledgeDocumentTable();

  static const db = KnowledgeDocumentRepository._();

  @override
  int? id;

  String title;

  String sourceType;

  int? bookId;

  String accessLevel;

  int? requiredCourseId;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [KnowledgeDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  KnowledgeDocument copyWith({
    int? id,
    String? title,
    String? sourceType,
    int? bookId,
    String? accessLevel,
    int? requiredCourseId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'KnowledgeDocument',
      if (id != null) 'id': id,
      'title': title,
      'sourceType': sourceType,
      if (bookId != null) 'bookId': bookId,
      'accessLevel': accessLevel,
      if (requiredCourseId != null) 'requiredCourseId': requiredCourseId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'KnowledgeDocument',
      if (id != null) 'id': id,
      'title': title,
      'sourceType': sourceType,
      if (bookId != null) 'bookId': bookId,
      'accessLevel': accessLevel,
      if (requiredCourseId != null) 'requiredCourseId': requiredCourseId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static KnowledgeDocumentInclude include() {
    return KnowledgeDocumentInclude._();
  }

  static KnowledgeDocumentIncludeList includeList({
    _i1.WhereExpressionBuilder<KnowledgeDocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<KnowledgeDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<KnowledgeDocumentTable>? orderByList,
    KnowledgeDocumentInclude? include,
  }) {
    return KnowledgeDocumentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(KnowledgeDocument.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(KnowledgeDocument.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _KnowledgeDocumentImpl extends KnowledgeDocument {
  _KnowledgeDocumentImpl({
    int? id,
    required String title,
    required String sourceType,
    int? bookId,
    required String accessLevel,
    int? requiredCourseId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         title: title,
         sourceType: sourceType,
         bookId: bookId,
         accessLevel: accessLevel,
         requiredCourseId: requiredCourseId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [KnowledgeDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  KnowledgeDocument copyWith({
    Object? id = _Undefined,
    String? title,
    String? sourceType,
    Object? bookId = _Undefined,
    String? accessLevel,
    Object? requiredCourseId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return KnowledgeDocument(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      sourceType: sourceType ?? this.sourceType,
      bookId: bookId is int? ? bookId : this.bookId,
      accessLevel: accessLevel ?? this.accessLevel,
      requiredCourseId: requiredCourseId is int?
          ? requiredCourseId
          : this.requiredCourseId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class KnowledgeDocumentUpdateTable
    extends _i1.UpdateTable<KnowledgeDocumentTable> {
  KnowledgeDocumentUpdateTable(super.table);

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> sourceType(String value) => _i1.ColumnValue(
    table.sourceType,
    value,
  );

  _i1.ColumnValue<int, int> bookId(int? value) => _i1.ColumnValue(
    table.bookId,
    value,
  );

  _i1.ColumnValue<String, String> accessLevel(String value) => _i1.ColumnValue(
    table.accessLevel,
    value,
  );

  _i1.ColumnValue<int, int> requiredCourseId(int? value) => _i1.ColumnValue(
    table.requiredCourseId,
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

class KnowledgeDocumentTable extends _i1.Table<int?> {
  KnowledgeDocumentTable({super.tableRelation})
    : super(tableName: 'knowledge_documents') {
    updateTable = KnowledgeDocumentUpdateTable(this);
    title = _i1.ColumnString(
      'title',
      this,
    );
    sourceType = _i1.ColumnString(
      'sourceType',
      this,
    );
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    accessLevel = _i1.ColumnString(
      'accessLevel',
      this,
    );
    requiredCourseId = _i1.ColumnInt(
      'requiredCourseId',
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

  late final KnowledgeDocumentUpdateTable updateTable;

  late final _i1.ColumnString title;

  late final _i1.ColumnString sourceType;

  late final _i1.ColumnInt bookId;

  late final _i1.ColumnString accessLevel;

  late final _i1.ColumnInt requiredCourseId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    title,
    sourceType,
    bookId,
    accessLevel,
    requiredCourseId,
    createdAt,
    updatedAt,
  ];
}

class KnowledgeDocumentInclude extends _i1.IncludeObject {
  KnowledgeDocumentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => KnowledgeDocument.t;
}

class KnowledgeDocumentIncludeList extends _i1.IncludeList {
  KnowledgeDocumentIncludeList._({
    _i1.WhereExpressionBuilder<KnowledgeDocumentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(KnowledgeDocument.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => KnowledgeDocument.t;
}

class KnowledgeDocumentRepository {
  const KnowledgeDocumentRepository._();

  /// Returns a list of [KnowledgeDocument]s matching the given query parameters.
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
  Future<List<KnowledgeDocument>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<KnowledgeDocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<KnowledgeDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<KnowledgeDocumentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<KnowledgeDocument>(
      where: where?.call(KnowledgeDocument.t),
      orderBy: orderBy?.call(KnowledgeDocument.t),
      orderByList: orderByList?.call(KnowledgeDocument.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [KnowledgeDocument] matching the given query parameters.
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
  Future<KnowledgeDocument?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<KnowledgeDocumentTable>? where,
    int? offset,
    _i1.OrderByBuilder<KnowledgeDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<KnowledgeDocumentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<KnowledgeDocument>(
      where: where?.call(KnowledgeDocument.t),
      orderBy: orderBy?.call(KnowledgeDocument.t),
      orderByList: orderByList?.call(KnowledgeDocument.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [KnowledgeDocument] by its [id] or null if no such row exists.
  Future<KnowledgeDocument?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<KnowledgeDocument>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [KnowledgeDocument]s in the list and returns the inserted rows.
  ///
  /// The returned [KnowledgeDocument]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<KnowledgeDocument>> insert(
    _i1.DatabaseSession session,
    List<KnowledgeDocument> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<KnowledgeDocument>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [KnowledgeDocument] and returns the inserted row.
  ///
  /// The returned [KnowledgeDocument] will have its `id` field set.
  Future<KnowledgeDocument> insertRow(
    _i1.DatabaseSession session,
    KnowledgeDocument row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<KnowledgeDocument>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [KnowledgeDocument]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<KnowledgeDocument>> update(
    _i1.DatabaseSession session,
    List<KnowledgeDocument> rows, {
    _i1.ColumnSelections<KnowledgeDocumentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<KnowledgeDocument>(
      rows,
      columns: columns?.call(KnowledgeDocument.t),
      transaction: transaction,
    );
  }

  /// Updates a single [KnowledgeDocument]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<KnowledgeDocument> updateRow(
    _i1.DatabaseSession session,
    KnowledgeDocument row, {
    _i1.ColumnSelections<KnowledgeDocumentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<KnowledgeDocument>(
      row,
      columns: columns?.call(KnowledgeDocument.t),
      transaction: transaction,
    );
  }

  /// Updates a single [KnowledgeDocument] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<KnowledgeDocument?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<KnowledgeDocumentUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<KnowledgeDocument>(
      id,
      columnValues: columnValues(KnowledgeDocument.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [KnowledgeDocument]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<KnowledgeDocument>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<KnowledgeDocumentUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<KnowledgeDocumentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<KnowledgeDocumentTable>? orderBy,
    _i1.OrderByListBuilder<KnowledgeDocumentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<KnowledgeDocument>(
      columnValues: columnValues(KnowledgeDocument.t.updateTable),
      where: where(KnowledgeDocument.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(KnowledgeDocument.t),
      orderByList: orderByList?.call(KnowledgeDocument.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [KnowledgeDocument]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<KnowledgeDocument>> delete(
    _i1.DatabaseSession session,
    List<KnowledgeDocument> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<KnowledgeDocument>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [KnowledgeDocument].
  Future<KnowledgeDocument> deleteRow(
    _i1.DatabaseSession session,
    KnowledgeDocument row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<KnowledgeDocument>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<KnowledgeDocument>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<KnowledgeDocumentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<KnowledgeDocument>(
      where: where(KnowledgeDocument.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<KnowledgeDocumentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<KnowledgeDocument>(
      where: where?.call(KnowledgeDocument.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [KnowledgeDocument] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<KnowledgeDocumentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<KnowledgeDocument>(
      where: where(KnowledgeDocument.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
