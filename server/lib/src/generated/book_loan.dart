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
import 'book_loan_status.dart' as _i2;

abstract class BookLoan
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  BookLoan._({
    this.id,
    required this.userId,
    required this.bookId,
    required this.copyId,
    required this.borrowedAt,
    required this.dueAt,
    this.returnedAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookLoan({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required int copyId,
    required DateTime borrowedAt,
    required DateTime dueAt,
    DateTime? returnedAt,
    required _i2.BookLoanStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BookLoanImpl;

  factory BookLoan.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookLoan(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      bookId: jsonSerialization['bookId'] as int,
      copyId: jsonSerialization['copyId'] as int,
      borrowedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['borrowedAt'],
      ),
      dueAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
      returnedAt: jsonSerialization['returnedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['returnedAt']),
      status: _i2.BookLoanStatus.fromJson(
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

  static final t = BookLoanTable();

  static const db = BookLoanRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  int bookId;

  int copyId;

  DateTime borrowedAt;

  DateTime dueAt;

  DateTime? returnedAt;

  _i2.BookLoanStatus status;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [BookLoan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookLoan copyWith({
    int? id,
    _i1.UuidValue? userId,
    int? bookId,
    int? copyId,
    DateTime? borrowedAt,
    DateTime? dueAt,
    DateTime? returnedAt,
    _i2.BookLoanStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookLoan',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'bookId': bookId,
      'copyId': copyId,
      'borrowedAt': borrowedAt.toJson(),
      'dueAt': dueAt.toJson(),
      if (returnedAt != null) 'returnedAt': returnedAt?.toJson(),
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookLoan',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'bookId': bookId,
      'copyId': copyId,
      'borrowedAt': borrowedAt.toJson(),
      'dueAt': dueAt.toJson(),
      if (returnedAt != null) 'returnedAt': returnedAt?.toJson(),
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static BookLoanInclude include() {
    return BookLoanInclude._();
  }

  static BookLoanIncludeList includeList({
    _i1.WhereExpressionBuilder<BookLoanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookLoanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookLoanTable>? orderByList,
    BookLoanInclude? include,
  }) {
    return BookLoanIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookLoan.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BookLoan.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookLoanImpl extends BookLoan {
  _BookLoanImpl({
    int? id,
    required _i1.UuidValue userId,
    required int bookId,
    required int copyId,
    required DateTime borrowedAt,
    required DateTime dueAt,
    DateTime? returnedAt,
    required _i2.BookLoanStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         bookId: bookId,
         copyId: copyId,
         borrowedAt: borrowedAt,
         dueAt: dueAt,
         returnedAt: returnedAt,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [BookLoan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookLoan copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    int? bookId,
    int? copyId,
    DateTime? borrowedAt,
    DateTime? dueAt,
    Object? returnedAt = _Undefined,
    _i2.BookLoanStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookLoan(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      copyId: copyId ?? this.copyId,
      borrowedAt: borrowedAt ?? this.borrowedAt,
      dueAt: dueAt ?? this.dueAt,
      returnedAt: returnedAt is DateTime? ? returnedAt : this.returnedAt,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class BookLoanUpdateTable extends _i1.UpdateTable<BookLoanTable> {
  BookLoanUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<int, int> bookId(int value) => _i1.ColumnValue(
    table.bookId,
    value,
  );

  _i1.ColumnValue<int, int> copyId(int value) => _i1.ColumnValue(
    table.copyId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> borrowedAt(DateTime value) =>
      _i1.ColumnValue(
        table.borrowedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> dueAt(DateTime value) => _i1.ColumnValue(
    table.dueAt,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> returnedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.returnedAt,
        value,
      );

  _i1.ColumnValue<_i2.BookLoanStatus, _i2.BookLoanStatus> status(
    _i2.BookLoanStatus value,
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

class BookLoanTable extends _i1.Table<int?> {
  BookLoanTable({super.tableRelation}) : super(tableName: 'book_loans') {
    updateTable = BookLoanUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    copyId = _i1.ColumnInt(
      'copyId',
      this,
    );
    borrowedAt = _i1.ColumnDateTime(
      'borrowedAt',
      this,
    );
    dueAt = _i1.ColumnDateTime(
      'dueAt',
      this,
    );
    returnedAt = _i1.ColumnDateTime(
      'returnedAt',
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

  late final BookLoanUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnInt bookId;

  late final _i1.ColumnInt copyId;

  late final _i1.ColumnDateTime borrowedAt;

  late final _i1.ColumnDateTime dueAt;

  late final _i1.ColumnDateTime returnedAt;

  late final _i1.ColumnEnum<_i2.BookLoanStatus> status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    bookId,
    copyId,
    borrowedAt,
    dueAt,
    returnedAt,
    status,
    createdAt,
    updatedAt,
  ];
}

class BookLoanInclude extends _i1.IncludeObject {
  BookLoanInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => BookLoan.t;
}

class BookLoanIncludeList extends _i1.IncludeList {
  BookLoanIncludeList._({
    _i1.WhereExpressionBuilder<BookLoanTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookLoan.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BookLoan.t;
}

class BookLoanRepository {
  const BookLoanRepository._();

  /// Returns a list of [BookLoan]s matching the given query parameters.
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
  Future<List<BookLoan>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BookLoanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookLoanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookLoanTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BookLoan>(
      where: where?.call(BookLoan.t),
      orderBy: orderBy?.call(BookLoan.t),
      orderByList: orderByList?.call(BookLoan.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BookLoan] matching the given query parameters.
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
  Future<BookLoan?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BookLoanTable>? where,
    int? offset,
    _i1.OrderByBuilder<BookLoanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookLoanTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BookLoan>(
      where: where?.call(BookLoan.t),
      orderBy: orderBy?.call(BookLoan.t),
      orderByList: orderByList?.call(BookLoan.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BookLoan] by its [id] or null if no such row exists.
  Future<BookLoan?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BookLoan>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BookLoan]s in the list and returns the inserted rows.
  ///
  /// The returned [BookLoan]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<BookLoan>> insert(
    _i1.DatabaseSession session,
    List<BookLoan> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<BookLoan>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [BookLoan] and returns the inserted row.
  ///
  /// The returned [BookLoan] will have its `id` field set.
  Future<BookLoan> insertRow(
    _i1.DatabaseSession session,
    BookLoan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookLoan>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BookLoan]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BookLoan>> update(
    _i1.DatabaseSession session,
    List<BookLoan> rows, {
    _i1.ColumnSelections<BookLoanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BookLoan>(
      rows,
      columns: columns?.call(BookLoan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookLoan]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BookLoan> updateRow(
    _i1.DatabaseSession session,
    BookLoan row, {
    _i1.ColumnSelections<BookLoanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookLoan>(
      row,
      columns: columns?.call(BookLoan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BookLoan] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BookLoan?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<BookLoanUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BookLoan>(
      id,
      columnValues: columnValues(BookLoan.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BookLoan]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BookLoan>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BookLoanUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<BookLoanTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookLoanTable>? orderBy,
    _i1.OrderByListBuilder<BookLoanTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BookLoan>(
      columnValues: columnValues(BookLoan.t.updateTable),
      where: where(BookLoan.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookLoan.t),
      orderByList: orderByList?.call(BookLoan.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BookLoan]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BookLoan>> delete(
    _i1.DatabaseSession session,
    List<BookLoan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BookLoan>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BookLoan].
  Future<BookLoan> deleteRow(
    _i1.DatabaseSession session,
    BookLoan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookLoan>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BookLoan>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BookLoanTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BookLoan>(
      where: where(BookLoan.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BookLoanTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BookLoan>(
      where: where?.call(BookLoan.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BookLoan] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BookLoanTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BookLoan>(
      where: where(BookLoan.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
