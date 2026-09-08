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

abstract class LibraryBookCategory
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LibraryBookCategory._({
    this.id,
    required this.bookId,
    required this.categoryId,
  });

  factory LibraryBookCategory({
    int? id,
    required int bookId,
    required int categoryId,
  }) = _LibraryBookCategoryImpl;

  factory LibraryBookCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryBookCategory(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      categoryId: jsonSerialization['categoryId'] as int,
    );
  }

  static final t = LibraryBookCategoryTable();

  static const db = LibraryBookCategoryRepository._();

  @override
  int? id;

  int bookId;

  int categoryId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LibraryBookCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryBookCategory copyWith({
    int? id,
    int? bookId,
    int? categoryId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LibraryBookCategory',
      if (id != null) 'id': id,
      'bookId': bookId,
      'categoryId': categoryId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LibraryBookCategory',
      if (id != null) 'id': id,
      'bookId': bookId,
      'categoryId': categoryId,
    };
  }

  static LibraryBookCategoryInclude include() {
    return LibraryBookCategoryInclude._();
  }

  static LibraryBookCategoryIncludeList includeList({
    _i1.WhereExpressionBuilder<LibraryBookCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookCategoryTable>? orderByList,
    LibraryBookCategoryInclude? include,
  }) {
    return LibraryBookCategoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryBookCategory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LibraryBookCategory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LibraryBookCategoryImpl extends LibraryBookCategory {
  _LibraryBookCategoryImpl({
    int? id,
    required int bookId,
    required int categoryId,
  }) : super._(
         id: id,
         bookId: bookId,
         categoryId: categoryId,
       );

  /// Returns a shallow copy of this [LibraryBookCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryBookCategory copyWith({
    Object? id = _Undefined,
    int? bookId,
    int? categoryId,
  }) {
    return LibraryBookCategory(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}

class LibraryBookCategoryUpdateTable
    extends _i1.UpdateTable<LibraryBookCategoryTable> {
  LibraryBookCategoryUpdateTable(super.table);

  _i1.ColumnValue<int, int> bookId(int value) => _i1.ColumnValue(
    table.bookId,
    value,
  );

  _i1.ColumnValue<int, int> categoryId(int value) => _i1.ColumnValue(
    table.categoryId,
    value,
  );
}

class LibraryBookCategoryTable extends _i1.Table<int?> {
  LibraryBookCategoryTable({super.tableRelation})
    : super(tableName: 'book_category_links') {
    updateTable = LibraryBookCategoryUpdateTable(this);
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    categoryId = _i1.ColumnInt(
      'categoryId',
      this,
    );
  }

  late final LibraryBookCategoryUpdateTable updateTable;

  late final _i1.ColumnInt bookId;

  late final _i1.ColumnInt categoryId;

  @override
  List<_i1.Column> get columns => [
    id,
    bookId,
    categoryId,
  ];
}

class LibraryBookCategoryInclude extends _i1.IncludeObject {
  LibraryBookCategoryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => LibraryBookCategory.t;
}

class LibraryBookCategoryIncludeList extends _i1.IncludeList {
  LibraryBookCategoryIncludeList._({
    _i1.WhereExpressionBuilder<LibraryBookCategoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LibraryBookCategory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LibraryBookCategory.t;
}

class LibraryBookCategoryRepository {
  const LibraryBookCategoryRepository._();

  /// Returns a list of [LibraryBookCategory]s matching the given query parameters.
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
  Future<List<LibraryBookCategory>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryBookCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookCategoryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LibraryBookCategory>(
      where: where?.call(LibraryBookCategory.t),
      orderBy: orderBy?.call(LibraryBookCategory.t),
      orderByList: orderByList?.call(LibraryBookCategory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LibraryBookCategory] matching the given query parameters.
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
  Future<LibraryBookCategory?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryBookCategoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<LibraryBookCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookCategoryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LibraryBookCategory>(
      where: where?.call(LibraryBookCategory.t),
      orderBy: orderBy?.call(LibraryBookCategory.t),
      orderByList: orderByList?.call(LibraryBookCategory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LibraryBookCategory] by its [id] or null if no such row exists.
  Future<LibraryBookCategory?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LibraryBookCategory>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LibraryBookCategory]s in the list and returns the inserted rows.
  ///
  /// The returned [LibraryBookCategory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<LibraryBookCategory>> insert(
    _i1.DatabaseSession session,
    List<LibraryBookCategory> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<LibraryBookCategory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [LibraryBookCategory] and returns the inserted row.
  ///
  /// The returned [LibraryBookCategory] will have its `id` field set.
  Future<LibraryBookCategory> insertRow(
    _i1.DatabaseSession session,
    LibraryBookCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LibraryBookCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LibraryBookCategory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LibraryBookCategory>> update(
    _i1.DatabaseSession session,
    List<LibraryBookCategory> rows, {
    _i1.ColumnSelections<LibraryBookCategoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LibraryBookCategory>(
      rows,
      columns: columns?.call(LibraryBookCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryBookCategory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LibraryBookCategory> updateRow(
    _i1.DatabaseSession session,
    LibraryBookCategory row, {
    _i1.ColumnSelections<LibraryBookCategoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LibraryBookCategory>(
      row,
      columns: columns?.call(LibraryBookCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryBookCategory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LibraryBookCategory?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<LibraryBookCategoryUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<LibraryBookCategory>(
      id,
      columnValues: columnValues(LibraryBookCategory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LibraryBookCategory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<LibraryBookCategory>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<LibraryBookCategoryUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<LibraryBookCategoryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookCategoryTable>? orderBy,
    _i1.OrderByListBuilder<LibraryBookCategoryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<LibraryBookCategory>(
      columnValues: columnValues(LibraryBookCategory.t.updateTable),
      where: where(LibraryBookCategory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryBookCategory.t),
      orderByList: orderByList?.call(LibraryBookCategory.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [LibraryBookCategory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LibraryBookCategory>> delete(
    _i1.DatabaseSession session,
    List<LibraryBookCategory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LibraryBookCategory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LibraryBookCategory].
  Future<LibraryBookCategory> deleteRow(
    _i1.DatabaseSession session,
    LibraryBookCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LibraryBookCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LibraryBookCategory>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LibraryBookCategoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LibraryBookCategory>(
      where: where(LibraryBookCategory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryBookCategoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LibraryBookCategory>(
      where: where?.call(LibraryBookCategory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LibraryBookCategory] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LibraryBookCategoryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LibraryBookCategory>(
      where: where(LibraryBookCategory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
