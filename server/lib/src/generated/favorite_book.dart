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

abstract class FavoriteBook
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FavoriteBook._({
    this.id,
    required this.userId,
    required this.bookId,
    required this.createdAt,
  });

  factory FavoriteBook({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required DateTime createdAt,
  }) = _FavoriteBookImpl;

  factory FavoriteBook.fromJson(Map<String, dynamic> jsonSerialization) {
    return FavoriteBook(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      bookId: jsonSerialization['bookId'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = FavoriteBookTable();

  static const db = FavoriteBookRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  int bookId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FavoriteBook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FavoriteBook copyWith({
    int? id,
    _i1.UuidValue? userId,
    int? bookId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FavoriteBook',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'bookId': bookId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FavoriteBook',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'bookId': bookId,
      'createdAt': createdAt.toJson(),
    };
  }

  static FavoriteBookInclude include() {
    return FavoriteBookInclude._();
  }

  static FavoriteBookIncludeList includeList({
    _i1.WhereExpressionBuilder<FavoriteBookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FavoriteBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FavoriteBookTable>? orderByList,
    FavoriteBookInclude? include,
  }) {
    return FavoriteBookIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FavoriteBook.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FavoriteBook.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FavoriteBookImpl extends FavoriteBook {
  _FavoriteBookImpl({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         bookId: bookId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FavoriteBook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FavoriteBook copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    int? bookId,
    DateTime? createdAt,
  }) {
    return FavoriteBook(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class FavoriteBookUpdateTable extends _i1.UpdateTable<FavoriteBookTable> {
  FavoriteBookUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<int, int> bookId(int value) => _i1.ColumnValue(
    table.bookId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class FavoriteBookTable extends _i1.Table<int?> {
  FavoriteBookTable({super.tableRelation})
    : super(tableName: 'favorite_books') {
    updateTable = FavoriteBookUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final FavoriteBookUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnInt bookId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    bookId,
    createdAt,
  ];
}

class FavoriteBookInclude extends _i1.IncludeObject {
  FavoriteBookInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FavoriteBook.t;
}

class FavoriteBookIncludeList extends _i1.IncludeList {
  FavoriteBookIncludeList._({
    _i1.WhereExpressionBuilder<FavoriteBookTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FavoriteBook.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FavoriteBook.t;
}

class FavoriteBookRepository {
  const FavoriteBookRepository._();

  /// Returns a list of [FavoriteBook]s matching the given query parameters.
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
  Future<List<FavoriteBook>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FavoriteBookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FavoriteBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FavoriteBookTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FavoriteBook>(
      where: where?.call(FavoriteBook.t),
      orderBy: orderBy?.call(FavoriteBook.t),
      orderByList: orderByList?.call(FavoriteBook.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FavoriteBook] matching the given query parameters.
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
  Future<FavoriteBook?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FavoriteBookTable>? where,
    int? offset,
    _i1.OrderByBuilder<FavoriteBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FavoriteBookTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FavoriteBook>(
      where: where?.call(FavoriteBook.t),
      orderBy: orderBy?.call(FavoriteBook.t),
      orderByList: orderByList?.call(FavoriteBook.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FavoriteBook] by its [id] or null if no such row exists.
  Future<FavoriteBook?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FavoriteBook>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FavoriteBook]s in the list and returns the inserted rows.
  ///
  /// The returned [FavoriteBook]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<FavoriteBook>> insert(
    _i1.DatabaseSession session,
    List<FavoriteBook> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FavoriteBook>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FavoriteBook] and returns the inserted row.
  ///
  /// The returned [FavoriteBook] will have its `id` field set.
  Future<FavoriteBook> insertRow(
    _i1.DatabaseSession session,
    FavoriteBook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FavoriteBook>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FavoriteBook]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FavoriteBook>> update(
    _i1.DatabaseSession session,
    List<FavoriteBook> rows, {
    _i1.ColumnSelections<FavoriteBookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FavoriteBook>(
      rows,
      columns: columns?.call(FavoriteBook.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FavoriteBook]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FavoriteBook> updateRow(
    _i1.DatabaseSession session,
    FavoriteBook row, {
    _i1.ColumnSelections<FavoriteBookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FavoriteBook>(
      row,
      columns: columns?.call(FavoriteBook.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FavoriteBook] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FavoriteBook?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<FavoriteBookUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FavoriteBook>(
      id,
      columnValues: columnValues(FavoriteBook.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FavoriteBook]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FavoriteBook>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<FavoriteBookUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FavoriteBookTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FavoriteBookTable>? orderBy,
    _i1.OrderByListBuilder<FavoriteBookTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FavoriteBook>(
      columnValues: columnValues(FavoriteBook.t.updateTable),
      where: where(FavoriteBook.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FavoriteBook.t),
      orderByList: orderByList?.call(FavoriteBook.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FavoriteBook]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FavoriteBook>> delete(
    _i1.DatabaseSession session,
    List<FavoriteBook> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FavoriteBook>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FavoriteBook].
  Future<FavoriteBook> deleteRow(
    _i1.DatabaseSession session,
    FavoriteBook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FavoriteBook>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FavoriteBook>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FavoriteBookTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FavoriteBook>(
      where: where(FavoriteBook.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FavoriteBookTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FavoriteBook>(
      where: where?.call(FavoriteBook.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FavoriteBook] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FavoriteBookTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FavoriteBook>(
      where: where(FavoriteBook.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
