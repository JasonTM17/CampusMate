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

abstract class ReaderHighlight
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ReaderHighlight._({
    this.id,
    required this.userId,
    required this.bookId,
    required this.location,
    required this.text,
    required this.colorToken,
    required this.createdAt,
  });

  factory ReaderHighlight({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required String location,
    required String text,
    required String colorToken,
    required DateTime createdAt,
  }) = _ReaderHighlightImpl;

  factory ReaderHighlight.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReaderHighlight(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      bookId: jsonSerialization['bookId'] as int,
      location: jsonSerialization['location'] as String,
      text: jsonSerialization['text'] as String,
      colorToken: jsonSerialization['colorToken'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = ReaderHighlightTable();

  static const db = ReaderHighlightRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  int bookId;

  String location;

  String text;

  String colorToken;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ReaderHighlight]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReaderHighlight copyWith({
    int? id,
    _i1.UuidValue? userId,
    int? bookId,
    String? location,
    String? text,
    String? colorToken,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReaderHighlight',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'bookId': bookId,
      'location': location,
      'text': text,
      'colorToken': colorToken,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReaderHighlight',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'bookId': bookId,
      'location': location,
      'text': text,
      'colorToken': colorToken,
      'createdAt': createdAt.toJson(),
    };
  }

  static ReaderHighlightInclude include() {
    return ReaderHighlightInclude._();
  }

  static ReaderHighlightIncludeList includeList({
    _i1.WhereExpressionBuilder<ReaderHighlightTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReaderHighlightTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReaderHighlightTable>? orderByList,
    ReaderHighlightInclude? include,
  }) {
    return ReaderHighlightIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReaderHighlight.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ReaderHighlight.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReaderHighlightImpl extends ReaderHighlight {
  _ReaderHighlightImpl({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required String location,
    required String text,
    required String colorToken,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         bookId: bookId,
         location: location,
         text: text,
         colorToken: colorToken,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ReaderHighlight]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReaderHighlight copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    int? bookId,
    String? location,
    String? text,
    String? colorToken,
    DateTime? createdAt,
  }) {
    return ReaderHighlight(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      location: location ?? this.location,
      text: text ?? this.text,
      colorToken: colorToken ?? this.colorToken,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ReaderHighlightUpdateTable extends _i1.UpdateTable<ReaderHighlightTable> {
  ReaderHighlightUpdateTable(super.table);

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

  _i1.ColumnValue<String, String> text(String value) => _i1.ColumnValue(
    table.text,
    value,
  );

  _i1.ColumnValue<String, String> colorToken(String value) => _i1.ColumnValue(
    table.colorToken,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class ReaderHighlightTable extends _i1.Table<int?> {
  ReaderHighlightTable({super.tableRelation})
    : super(tableName: 'reader_highlights') {
    updateTable = ReaderHighlightUpdateTable(this);
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
    text = _i1.ColumnString(
      'text',
      this,
    );
    colorToken = _i1.ColumnString(
      'colorToken',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ReaderHighlightUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnInt bookId;

  late final _i1.ColumnString location;

  late final _i1.ColumnString text;

  late final _i1.ColumnString colorToken;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    bookId,
    location,
    text,
    colorToken,
    createdAt,
  ];
}

class ReaderHighlightInclude extends _i1.IncludeObject {
  ReaderHighlightInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ReaderHighlight.t;
}

class ReaderHighlightIncludeList extends _i1.IncludeList {
  ReaderHighlightIncludeList._({
    _i1.WhereExpressionBuilder<ReaderHighlightTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ReaderHighlight.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ReaderHighlight.t;
}

class ReaderHighlightRepository {
  const ReaderHighlightRepository._();

  /// Returns a list of [ReaderHighlight]s matching the given query parameters.
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
  Future<List<ReaderHighlight>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReaderHighlightTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReaderHighlightTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReaderHighlightTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ReaderHighlight>(
      where: where?.call(ReaderHighlight.t),
      orderBy: orderBy?.call(ReaderHighlight.t),
      orderByList: orderByList?.call(ReaderHighlight.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ReaderHighlight] matching the given query parameters.
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
  Future<ReaderHighlight?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReaderHighlightTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReaderHighlightTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReaderHighlightTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ReaderHighlight>(
      where: where?.call(ReaderHighlight.t),
      orderBy: orderBy?.call(ReaderHighlight.t),
      orderByList: orderByList?.call(ReaderHighlight.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ReaderHighlight] by its [id] or null if no such row exists.
  Future<ReaderHighlight?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ReaderHighlight>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ReaderHighlight]s in the list and returns the inserted rows.
  ///
  /// The returned [ReaderHighlight]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ReaderHighlight>> insert(
    _i1.DatabaseSession session,
    List<ReaderHighlight> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ReaderHighlight>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ReaderHighlight] and returns the inserted row.
  ///
  /// The returned [ReaderHighlight] will have its `id` field set.
  Future<ReaderHighlight> insertRow(
    _i1.DatabaseSession session,
    ReaderHighlight row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ReaderHighlight>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ReaderHighlight]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ReaderHighlight>> update(
    _i1.DatabaseSession session,
    List<ReaderHighlight> rows, {
    _i1.ColumnSelections<ReaderHighlightTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ReaderHighlight>(
      rows,
      columns: columns?.call(ReaderHighlight.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReaderHighlight]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ReaderHighlight> updateRow(
    _i1.DatabaseSession session,
    ReaderHighlight row, {
    _i1.ColumnSelections<ReaderHighlightTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ReaderHighlight>(
      row,
      columns: columns?.call(ReaderHighlight.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReaderHighlight] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ReaderHighlight?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ReaderHighlightUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ReaderHighlight>(
      id,
      columnValues: columnValues(ReaderHighlight.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ReaderHighlight]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ReaderHighlight>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ReaderHighlightUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ReaderHighlightTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReaderHighlightTable>? orderBy,
    _i1.OrderByListBuilder<ReaderHighlightTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ReaderHighlight>(
      columnValues: columnValues(ReaderHighlight.t.updateTable),
      where: where(ReaderHighlight.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReaderHighlight.t),
      orderByList: orderByList?.call(ReaderHighlight.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ReaderHighlight]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ReaderHighlight>> delete(
    _i1.DatabaseSession session,
    List<ReaderHighlight> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ReaderHighlight>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ReaderHighlight].
  Future<ReaderHighlight> deleteRow(
    _i1.DatabaseSession session,
    ReaderHighlight row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ReaderHighlight>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ReaderHighlight>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ReaderHighlightTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ReaderHighlight>(
      where: where(ReaderHighlight.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReaderHighlightTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ReaderHighlight>(
      where: where?.call(ReaderHighlight.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ReaderHighlight] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ReaderHighlightTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ReaderHighlight>(
      where: where(ReaderHighlight.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
