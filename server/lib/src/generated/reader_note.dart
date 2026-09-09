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

abstract class ReaderNote
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ReaderNote._({
    this.id,
    required this.userId,
    required this.bookId,
    required this.location,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReaderNote({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required String location,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ReaderNoteImpl;

  factory ReaderNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReaderNote(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      bookId: jsonSerialization['bookId'] as int,
      location: jsonSerialization['location'] as String,
      content: jsonSerialization['content'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ReaderNoteTable();

  static const db = ReaderNoteRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  int bookId;

  String location;

  String content;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ReaderNote]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReaderNote copyWith({
    int? id,
    _i1.UuidValue? userId,
    int? bookId,
    String? location,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReaderNote',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'bookId': bookId,
      'location': location,
      'content': content,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReaderNote',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'bookId': bookId,
      'location': location,
      'content': content,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ReaderNoteInclude include() {
    return ReaderNoteInclude._();
  }

  static ReaderNoteIncludeList includeList({
    _i1.WhereExpressionBuilder<ReaderNoteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReaderNoteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReaderNoteTable>? orderByList,
    ReaderNoteInclude? include,
  }) {
    return ReaderNoteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReaderNote.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ReaderNote.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReaderNoteImpl extends ReaderNote {
  _ReaderNoteImpl({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required String location,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         bookId: bookId,
         location: location,
         content: content,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ReaderNote]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReaderNote copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    int? bookId,
    String? location,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReaderNote(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      location: location ?? this.location,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ReaderNoteUpdateTable extends _i1.UpdateTable<ReaderNoteTable> {
  ReaderNoteUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<int, int> bookId(int value) => _i1.ColumnValue(
    table.bookId,
    value,
  );

  _i1.ColumnValue<String, String> location(String value) => _i1.ColumnValue(
    table.location,
    value,
  );

  _i1.ColumnValue<String, String> content(String value) => _i1.ColumnValue(
    table.content,
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

class ReaderNoteTable extends _i1.Table<int?> {
  ReaderNoteTable({super.tableRelation}) : super(tableName: 'reader_notes') {
    updateTable = ReaderNoteUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    location = _i1.ColumnString(
      'location',
      this,
    );
    content = _i1.ColumnString(
      'content',
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

  late final ReaderNoteUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnInt bookId;

  late final _i1.ColumnString location;

  late final _i1.ColumnString content;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    bookId,
    location,
    content,
    createdAt,
    updatedAt,
  ];
}

class ReaderNoteInclude extends _i1.IncludeObject {
  ReaderNoteInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ReaderNote.t;
}

class ReaderNoteIncludeList extends _i1.IncludeList {
  ReaderNoteIncludeList._({
    _i1.WhereExpressionBuilder<ReaderNoteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ReaderNote.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ReaderNote.t;
}

class ReaderNoteRepository {
  const ReaderNoteRepository._();

  /// Returns a list of [ReaderNote]s matching the given query parameters.
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
  Future<List<ReaderNote>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReaderNoteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReaderNoteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReaderNoteTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ReaderNote>(
      where: where?.call(ReaderNote.t),
      orderBy: orderBy?.call(ReaderNote.t),
      orderByList: orderByList?.call(ReaderNote.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ReaderNote] matching the given query parameters.
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
  Future<ReaderNote?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReaderNoteTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReaderNoteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReaderNoteTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ReaderNote>(
      where: where?.call(ReaderNote.t),
      orderBy: orderBy?.call(ReaderNote.t),
      orderByList: orderByList?.call(ReaderNote.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ReaderNote] by its [id] or null if no such row exists.
  Future<ReaderNote?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ReaderNote>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ReaderNote]s in the list and returns the inserted rows.
  ///
  /// The returned [ReaderNote]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ReaderNote>> insert(
    _i1.DatabaseSession session,
    List<ReaderNote> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ReaderNote>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ReaderNote] and returns the inserted row.
  ///
  /// The returned [ReaderNote] will have its `id` field set.
  Future<ReaderNote> insertRow(
    _i1.DatabaseSession session,
    ReaderNote row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ReaderNote>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ReaderNote]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ReaderNote>> update(
    _i1.DatabaseSession session,
    List<ReaderNote> rows, {
    _i1.ColumnSelections<ReaderNoteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ReaderNote>(
      rows,
      columns: columns?.call(ReaderNote.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReaderNote]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ReaderNote> updateRow(
    _i1.DatabaseSession session,
    ReaderNote row, {
    _i1.ColumnSelections<ReaderNoteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ReaderNote>(
      row,
      columns: columns?.call(ReaderNote.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReaderNote] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ReaderNote?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ReaderNoteUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ReaderNote>(
      id,
      columnValues: columnValues(ReaderNote.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ReaderNote]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ReaderNote>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ReaderNoteUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ReaderNoteTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReaderNoteTable>? orderBy,
    _i1.OrderByListBuilder<ReaderNoteTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ReaderNote>(
      columnValues: columnValues(ReaderNote.t.updateTable),
      where: where(ReaderNote.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReaderNote.t),
      orderByList: orderByList?.call(ReaderNote.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ReaderNote]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ReaderNote>> delete(
    _i1.DatabaseSession session,
    List<ReaderNote> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ReaderNote>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ReaderNote].
  Future<ReaderNote> deleteRow(
    _i1.DatabaseSession session,
    ReaderNote row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ReaderNote>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ReaderNote>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ReaderNoteTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ReaderNote>(
      where: where(ReaderNote.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReaderNoteTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ReaderNote>(
      where: where?.call(ReaderNote.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ReaderNote] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ReaderNoteTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ReaderNote>(
      where: where(ReaderNote.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
