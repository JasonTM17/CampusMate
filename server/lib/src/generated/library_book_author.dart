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

abstract class LibraryBookAuthor
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LibraryBookAuthor._({
    this.id,
    required this.bookId,
    required this.authorId,
  });

  factory LibraryBookAuthor({
    int? id,
    required int bookId,
    required int authorId,
  }) = _LibraryBookAuthorImpl;

  factory LibraryBookAuthor.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryBookAuthor(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      authorId: jsonSerialization['authorId'] as int,
    );
  }

  static final t = LibraryBookAuthorTable();

  static const db = LibraryBookAuthorRepository._();

  @override
  int? id;

  int bookId;

  int authorId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LibraryBookAuthor]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryBookAuthor copyWith({
    int? id,
    int? bookId,
    int? authorId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LibraryBookAuthor',
      if (id != null) 'id': id,
      'bookId': bookId,
      'authorId': authorId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LibraryBookAuthor',
      if (id != null) 'id': id,
      'bookId': bookId,
      'authorId': authorId,
    };
  }

  static LibraryBookAuthorInclude include() {
    return LibraryBookAuthorInclude._();
  }

  static LibraryBookAuthorIncludeList includeList({
    _i1.WhereExpressionBuilder<LibraryBookAuthorTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookAuthorTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookAuthorTable>? orderByList,
    LibraryBookAuthorInclude? include,
  }) {
    return LibraryBookAuthorIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryBookAuthor.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LibraryBookAuthor.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LibraryBookAuthorImpl extends LibraryBookAuthor {
  _LibraryBookAuthorImpl({
    int? id,
    required int bookId,
    required int authorId,
  }) : super._(
         id: id,
         bookId: bookId,
         authorId: authorId,
       );

  /// Returns a shallow copy of this [LibraryBookAuthor]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryBookAuthor copyWith({
    Object? id = _Undefined,
    int? bookId,
    int? authorId,
  }) {
    return LibraryBookAuthor(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      authorId: authorId ?? this.authorId,
    );
  }
}

class LibraryBookAuthorUpdateTable
    extends _i1.UpdateTable<LibraryBookAuthorTable> {
  LibraryBookAuthorUpdateTable(super.table);

  _i1.ColumnValue<int, int> bookId(int value) => _i1.ColumnValue(
    table.bookId,
    value,
  );

  _i1.ColumnValue<int, int> authorId(int value) => _i1.ColumnValue(
    table.authorId,
    value,
  );
}

class LibraryBookAuthorTable extends _i1.Table<int?> {
  LibraryBookAuthorTable({super.tableRelation})
    : super(tableName: 'book_authors') {
    updateTable = LibraryBookAuthorUpdateTable(this);
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    authorId = _i1.ColumnInt(
      'authorId',
      this,
    );
  }

  late final LibraryBookAuthorUpdateTable updateTable;

  late final _i1.ColumnInt bookId;

  late final _i1.ColumnInt authorId;

  @override
  List<_i1.Column> get columns => [
    id,
    bookId,
    authorId,
  ];
}

class LibraryBookAuthorInclude extends _i1.IncludeObject {
  LibraryBookAuthorInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => LibraryBookAuthor.t;
}

class LibraryBookAuthorIncludeList extends _i1.IncludeList {
  LibraryBookAuthorIncludeList._({
    _i1.WhereExpressionBuilder<LibraryBookAuthorTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LibraryBookAuthor.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LibraryBookAuthor.t;
}

class LibraryBookAuthorRepository {
  const LibraryBookAuthorRepository._();

  /// Returns a list of [LibraryBookAuthor]s matching the given query parameters.
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
  Future<List<LibraryBookAuthor>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryBookAuthorTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookAuthorTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookAuthorTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LibraryBookAuthor>(
      where: where?.call(LibraryBookAuthor.t),
      orderBy: orderBy?.call(LibraryBookAuthor.t),
      orderByList: orderByList?.call(LibraryBookAuthor.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LibraryBookAuthor] matching the given query parameters.
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
  Future<LibraryBookAuthor?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryBookAuthorTable>? where,
    int? offset,
    _i1.OrderByBuilder<LibraryBookAuthorTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookAuthorTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LibraryBookAuthor>(
      where: where?.call(LibraryBookAuthor.t),
      orderBy: orderBy?.call(LibraryBookAuthor.t),
      orderByList: orderByList?.call(LibraryBookAuthor.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LibraryBookAuthor] by its [id] or null if no such row exists.
  Future<LibraryBookAuthor?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LibraryBookAuthor>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LibraryBookAuthor]s in the list and returns the inserted rows.
  ///
  /// The returned [LibraryBookAuthor]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<LibraryBookAuthor>> insert(
    _i1.DatabaseSession session,
    List<LibraryBookAuthor> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<LibraryBookAuthor>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [LibraryBookAuthor] and returns the inserted row.
  ///
  /// The returned [LibraryBookAuthor] will have its `id` field set.
  Future<LibraryBookAuthor> insertRow(
    _i1.DatabaseSession session,
    LibraryBookAuthor row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LibraryBookAuthor>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LibraryBookAuthor]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LibraryBookAuthor>> update(
    _i1.DatabaseSession session,
    List<LibraryBookAuthor> rows, {
    _i1.ColumnSelections<LibraryBookAuthorTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LibraryBookAuthor>(
      rows,
      columns: columns?.call(LibraryBookAuthor.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryBookAuthor]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LibraryBookAuthor> updateRow(
    _i1.DatabaseSession session,
    LibraryBookAuthor row, {
    _i1.ColumnSelections<LibraryBookAuthorTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LibraryBookAuthor>(
      row,
      columns: columns?.call(LibraryBookAuthor.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryBookAuthor] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LibraryBookAuthor?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<LibraryBookAuthorUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<LibraryBookAuthor>(
      id,
      columnValues: columnValues(LibraryBookAuthor.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LibraryBookAuthor]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<LibraryBookAuthor>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<LibraryBookAuthorUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<LibraryBookAuthorTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookAuthorTable>? orderBy,
    _i1.OrderByListBuilder<LibraryBookAuthorTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<LibraryBookAuthor>(
      columnValues: columnValues(LibraryBookAuthor.t.updateTable),
      where: where(LibraryBookAuthor.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryBookAuthor.t),
      orderByList: orderByList?.call(LibraryBookAuthor.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [LibraryBookAuthor]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LibraryBookAuthor>> delete(
    _i1.DatabaseSession session,
    List<LibraryBookAuthor> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LibraryBookAuthor>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LibraryBookAuthor].
  Future<LibraryBookAuthor> deleteRow(
    _i1.DatabaseSession session,
    LibraryBookAuthor row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LibraryBookAuthor>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LibraryBookAuthor>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LibraryBookAuthorTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LibraryBookAuthor>(
      where: where(LibraryBookAuthor.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryBookAuthorTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LibraryBookAuthor>(
      where: where?.call(LibraryBookAuthor.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LibraryBookAuthor] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LibraryBookAuthorTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LibraryBookAuthor>(
      where: where(LibraryBookAuthor.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
