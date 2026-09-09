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

abstract class ReadingProgress
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ReadingProgress._({
    this.id,
    required this.userId,
    required this.bookId,
    required this.progressPercent,
    required this.currentLocation,
    required this.updatedAt,
  });

  factory ReadingProgress({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required double progressPercent,
    required String currentLocation,
    required DateTime updatedAt,
  }) = _ReadingProgressImpl;

  factory ReadingProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReadingProgress(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      bookId: jsonSerialization['bookId'] as int,
      progressPercent: (jsonSerialization['progressPercent'] as num).toDouble(),
      currentLocation: jsonSerialization['currentLocation'] as String,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ReadingProgressTable();

  static const db = ReadingProgressRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  int bookId;

  double progressPercent;

  String currentLocation;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ReadingProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReadingProgress copyWith({
    int? id,
    _i1.UuidValue? userId,
    int? bookId,
    double? progressPercent,
    String? currentLocation,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReadingProgress',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'bookId': bookId,
      'progressPercent': progressPercent,
      'currentLocation': currentLocation,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReadingProgress',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'bookId': bookId,
      'progressPercent': progressPercent,
      'currentLocation': currentLocation,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ReadingProgressInclude include() {
    return ReadingProgressInclude._();
  }

  static ReadingProgressIncludeList includeList({
    _i1.WhereExpressionBuilder<ReadingProgressTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReadingProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReadingProgressTable>? orderByList,
    ReadingProgressInclude? include,
  }) {
    return ReadingProgressIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReadingProgress.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ReadingProgress.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReadingProgressImpl extends ReadingProgress {
  _ReadingProgressImpl({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required double progressPercent,
    required String currentLocation,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         bookId: bookId,
         progressPercent: progressPercent,
         currentLocation: currentLocation,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ReadingProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReadingProgress copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    int? bookId,
    double? progressPercent,
    String? currentLocation,
    DateTime? updatedAt,
  }) {
    return ReadingProgress(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      progressPercent: progressPercent ?? this.progressPercent,
      currentLocation: currentLocation ?? this.currentLocation,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ReadingProgressUpdateTable extends _i1.UpdateTable<ReadingProgressTable> {
  ReadingProgressUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<int, int> bookId(int value) => _i1.ColumnValue(
    table.bookId,
    value,
  );

  _i1.ColumnValue<double, double> progressPercent(double value) =>
      _i1.ColumnValue(
        table.progressPercent,
        value,
      );

  _i1.ColumnValue<String, String> currentLocation(String value) =>
      _i1.ColumnValue(
        table.currentLocation,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ReadingProgressTable extends _i1.Table<int?> {
  ReadingProgressTable({super.tableRelation})
    : super(tableName: 'reading_progress') {
    updateTable = ReadingProgressUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    progressPercent = _i1.ColumnDouble(
      'progressPercent',
      this,
    );
    currentLocation = _i1.ColumnString(
      'currentLocation',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final ReadingProgressUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnInt bookId;

  late final _i1.ColumnDouble progressPercent;

  late final _i1.ColumnString currentLocation;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    bookId,
    progressPercent,
    currentLocation,
    updatedAt,
  ];
}

class ReadingProgressInclude extends _i1.IncludeObject {
  ReadingProgressInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ReadingProgress.t;
}

class ReadingProgressIncludeList extends _i1.IncludeList {
  ReadingProgressIncludeList._({
    _i1.WhereExpressionBuilder<ReadingProgressTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ReadingProgress.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ReadingProgress.t;
}

class ReadingProgressRepository {
  const ReadingProgressRepository._();

  /// Returns a list of [ReadingProgress]s matching the given query parameters.
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
  Future<List<ReadingProgress>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReadingProgressTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReadingProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReadingProgressTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ReadingProgress>(
      where: where?.call(ReadingProgress.t),
      orderBy: orderBy?.call(ReadingProgress.t),
      orderByList: orderByList?.call(ReadingProgress.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ReadingProgress] matching the given query parameters.
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
  Future<ReadingProgress?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReadingProgressTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReadingProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReadingProgressTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ReadingProgress>(
      where: where?.call(ReadingProgress.t),
      orderBy: orderBy?.call(ReadingProgress.t),
      orderByList: orderByList?.call(ReadingProgress.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ReadingProgress] by its [id] or null if no such row exists.
  Future<ReadingProgress?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ReadingProgress>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ReadingProgress]s in the list and returns the inserted rows.
  ///
  /// The returned [ReadingProgress]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ReadingProgress>> insert(
    _i1.DatabaseSession session,
    List<ReadingProgress> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ReadingProgress>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ReadingProgress] and returns the inserted row.
  ///
  /// The returned [ReadingProgress] will have its `id` field set.
  Future<ReadingProgress> insertRow(
    _i1.DatabaseSession session,
    ReadingProgress row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ReadingProgress>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ReadingProgress]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ReadingProgress>> update(
    _i1.DatabaseSession session,
    List<ReadingProgress> rows, {
    _i1.ColumnSelections<ReadingProgressTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ReadingProgress>(
      rows,
      columns: columns?.call(ReadingProgress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReadingProgress]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ReadingProgress> updateRow(
    _i1.DatabaseSession session,
    ReadingProgress row, {
    _i1.ColumnSelections<ReadingProgressTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ReadingProgress>(
      row,
      columns: columns?.call(ReadingProgress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReadingProgress] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ReadingProgress?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ReadingProgressUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ReadingProgress>(
      id,
      columnValues: columnValues(ReadingProgress.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ReadingProgress]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ReadingProgress>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ReadingProgressUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ReadingProgressTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReadingProgressTable>? orderBy,
    _i1.OrderByListBuilder<ReadingProgressTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ReadingProgress>(
      columnValues: columnValues(ReadingProgress.t.updateTable),
      where: where(ReadingProgress.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReadingProgress.t),
      orderByList: orderByList?.call(ReadingProgress.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ReadingProgress]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ReadingProgress>> delete(
    _i1.DatabaseSession session,
    List<ReadingProgress> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ReadingProgress>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ReadingProgress].
  Future<ReadingProgress> deleteRow(
    _i1.DatabaseSession session,
    ReadingProgress row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ReadingProgress>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ReadingProgress>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ReadingProgressTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ReadingProgress>(
      where: where(ReadingProgress.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ReadingProgressTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ReadingProgress>(
      where: where?.call(ReadingProgress.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ReadingProgress] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ReadingProgressTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ReadingProgress>(
      where: where(ReadingProgress.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
