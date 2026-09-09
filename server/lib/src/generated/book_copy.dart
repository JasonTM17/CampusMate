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
import 'book_copy_status.dart' as _i2;

abstract class BookCopy
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  BookCopy._({
    this.id,
    required this.bookId,
    required this.barcode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookCopy({
    int? id,
    required int bookId,
    required String barcode,
    required _i2.BookCopyStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BookCopyImpl;

  factory BookCopy.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookCopy(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      barcode: jsonSerialization['barcode'] as String,
      status: _i2.BookCopyStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = BookCopyTable();

  static const db = BookCopyRepository._();

  @override
  int? id;

  int bookId;

  String barcode;

  _i2.BookCopyStatus status;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [BookCopy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookCopy copyWith({
    int? id,
    int? bookId,
    String? barcode,
    _i2.BookCopyStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookCopy',
      if (id != null) 'id': id,
      'bookId': bookId,
      'barcode': barcode,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookCopy',
      if (id != null) 'id': id,
      'bookId': bookId,
      'barcode': barcode,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static BookCopyInclude include() {
    return BookCopyInclude._();
  }

  static BookCopyIncludeList includeList({
    _i1.WhereExpressionBuilder<BookCopyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookCopyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookCopyTable>? orderByList,
    BookCopyInclude? include,
  }) {
    return BookCopyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookCopy.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BookCopy.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookCopyImpl extends BookCopy {
  _BookCopyImpl({
    int? id,
    required int bookId,
    required String barcode,
    required _i2.BookCopyStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         bookId: bookId,
         barcode: barcode,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [BookCopy]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookCopy copyWith({
    Object? id = _Undefined,
    int? bookId,
    String? barcode,
    _i2.BookCopyStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookCopy(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      barcode: barcode ?? this.barcode,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class BookCopyUpdateTable extends _i1.UpdateTable<BookCopyTable> {
  BookCopyUpdateTable(super.table);

  _i1.ColumnValue<int, int> bookId(int value) => _i1.ColumnValue(
    table.bookId,
    value,
  );

  _i1.ColumnValue<String, String> barcode(String value) => _i1.ColumnValue(
    table.barcode,
    value,
  );

  _i1.ColumnValue<_i2.BookCopyStatus, _i2.BookCopyStatus> status(
    _i2.BookCopyStatus value,
  ) => _i1.ColumnValue(
    table.status,
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

class BookCopyTable extends _i1.Table<int?> {
  BookCopyTable({super.tableRelation}) : super(tableName: 'book_copies') {
    updateTable = BookCopyUpdateTable(this);
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    barcode = _i1.ColumnString(
      'barcode',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
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

  late final BookCopyUpdateTable updateTable;

  late final _i1.ColumnInt bookId;

  late final _i1.ColumnString barcode;

  late final _i1.ColumnEnum<_i2.BookCopyStatus> status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    bookId,
    barcode,
    status,
    createdAt,
    updatedAt,
  ];
}

class BookCopyInclude extends _i1.IncludeObject {
  BookCopyInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => BookCopy.t;
}

class BookCopyIncludeList extends _i1.IncludeList {
  BookCopyIncludeList._({
    _i1.WhereExpressionBuilder<BookCopyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookCopy.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BookCopy.t;
}

class BookCopyRepository {
  const BookCopyRepository._();

  /// Returns a list of [BookCopy]s matching the given query parameters.
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
  Future<List<BookCopy>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BookCopyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookCopyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookCopyTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BookCopy>(
      where: where?.call(BookCopy.t),
      orderBy: orderBy?.call(BookCopy.t),
      orderByList: orderByList?.call(BookCopy.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BookCopy] matching the given query parameters.
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
  Future<BookCopy?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BookCopyTable>? where,
    int? offset,
    _i1.OrderByBuilder<BookCopyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookCopyTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BookCopy>(
      where: where?.call(BookCopy.t),
      orderBy: orderBy?.call(BookCopy.t),
      orderByList: orderByList?.call(BookCopy.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BookCopy] by its [id] or null if no such row exists.
  Future<BookCopy?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BookCopy>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BookCopy]s in the list and returns the inserted rows.
  ///
  /// The returned [BookCopy]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<BookCopy>> insert(
    _i1.DatabaseSession session,
    List<BookCopy> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<BookCopy>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [BookCopy] and returns the inserted row.
  ///
  /// The returned [BookCopy] will have its `id` field set.
  Future<BookCopy> insertRow(
    _i1.DatabaseSession session,
    BookCopy row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookCopy>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BookCopy]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BookCopy>> update(
    _i1.DatabaseSession session,
    List<BookCopy> rows, {
    _i1.ColumnSelections<BookCopyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BookCopy>(
      rows,
      columns: columns?.call(BookCopy.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookCopy]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookCopy> updateRow(
    _i1.DatabaseSession session,
    BookCopy row, {
    _i1.ColumnSelections<BookCopyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookCopy>(
      row,
      columns: columns?.call(BookCopy.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookCopy] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BookCopy?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<BookCopyUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BookCopy>(
      id,
      columnValues: columnValues(BookCopy.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BookCopy]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BookCopy>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BookCopyUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<BookCopyTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookCopyTable>? orderBy,
    _i1.OrderByListBuilder<BookCopyTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BookCopy>(
      columnValues: columnValues(BookCopy.t.updateTable),
      where: where(BookCopy.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookCopy.t),
      orderByList: orderByList?.call(BookCopy.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BookCopy]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BookCopy>> delete(
    _i1.DatabaseSession session,
    List<BookCopy> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BookCopy>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BookCopy].
  Future<BookCopy> deleteRow(
    _i1.DatabaseSession session,
    BookCopy row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookCopy>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BookCopy>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BookCopyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BookCopy>(
      where: where(BookCopy.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BookCopyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BookCopy>(
      where: where?.call(BookCopy.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BookCopy] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BookCopyTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BookCopy>(
      where: where(BookCopy.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
