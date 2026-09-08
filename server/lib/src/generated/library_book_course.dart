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

abstract class LibraryBookCourse
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LibraryBookCourse._({
    this.id,
    required this.bookId,
    required this.courseId,
  });

  factory LibraryBookCourse({
    int? id,
    required int bookId,
    required int courseId,
  }) = _LibraryBookCourseImpl;

  factory LibraryBookCourse.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryBookCourse(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      courseId: jsonSerialization['courseId'] as int,
    );
  }

  static final t = LibraryBookCourseTable();

  static const db = LibraryBookCourseRepository._();

  @override
  int? id;

  int bookId;

  int courseId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LibraryBookCourse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryBookCourse copyWith({
    int? id,
    int? bookId,
    int? courseId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LibraryBookCourse',
      if (id != null) 'id': id,
      'bookId': bookId,
      'courseId': courseId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LibraryBookCourse',
      if (id != null) 'id': id,
      'bookId': bookId,
      'courseId': courseId,
    };
  }

  static LibraryBookCourseInclude include() {
    return LibraryBookCourseInclude._();
  }

  static LibraryBookCourseIncludeList includeList({
    _i1.WhereExpressionBuilder<LibraryBookCourseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookCourseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookCourseTable>? orderByList,
    LibraryBookCourseInclude? include,
  }) {
    return LibraryBookCourseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryBookCourse.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LibraryBookCourse.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LibraryBookCourseImpl extends LibraryBookCourse {
  _LibraryBookCourseImpl({
    int? id,
    required int bookId,
    required int courseId,
  }) : super._(
         id: id,
         bookId: bookId,
         courseId: courseId,
       );

  /// Returns a shallow copy of this [LibraryBookCourse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryBookCourse copyWith({
    Object? id = _Undefined,
    int? bookId,
    int? courseId,
  }) {
    return LibraryBookCourse(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      courseId: courseId ?? this.courseId,
    );
  }
}

class LibraryBookCourseUpdateTable
    extends _i1.UpdateTable<LibraryBookCourseTable> {
  LibraryBookCourseUpdateTable(super.table);

  _i1.ColumnValue<int, int> bookId(int value) => _i1.ColumnValue(
    table.bookId,
    value,
  );

  _i1.ColumnValue<int, int> courseId(int value) => _i1.ColumnValue(
    table.courseId,
    value,
  );
}

class LibraryBookCourseTable extends _i1.Table<int?> {
  LibraryBookCourseTable({super.tableRelation})
    : super(tableName: 'book_course_links') {
    updateTable = LibraryBookCourseUpdateTable(this);
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    courseId = _i1.ColumnInt(
      'courseId',
      this,
    );
  }

  late final LibraryBookCourseUpdateTable updateTable;

  late final _i1.ColumnInt bookId;

  late final _i1.ColumnInt courseId;

  @override
  List<_i1.Column> get columns => [
    id,
    bookId,
    courseId,
  ];
}

class LibraryBookCourseInclude extends _i1.IncludeObject {
  LibraryBookCourseInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => LibraryBookCourse.t;
}

class LibraryBookCourseIncludeList extends _i1.IncludeList {
  LibraryBookCourseIncludeList._({
    _i1.WhereExpressionBuilder<LibraryBookCourseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LibraryBookCourse.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LibraryBookCourse.t;
}

class LibraryBookCourseRepository {
  const LibraryBookCourseRepository._();

  /// Returns a list of [LibraryBookCourse]s matching the given query parameters.
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
  Future<List<LibraryBookCourse>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryBookCourseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookCourseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookCourseTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LibraryBookCourse>(
      where: where?.call(LibraryBookCourse.t),
      orderBy: orderBy?.call(LibraryBookCourse.t),
      orderByList: orderByList?.call(LibraryBookCourse.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LibraryBookCourse] matching the given query parameters.
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
  Future<LibraryBookCourse?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryBookCourseTable>? where,
    int? offset,
    _i1.OrderByBuilder<LibraryBookCourseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookCourseTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LibraryBookCourse>(
      where: where?.call(LibraryBookCourse.t),
      orderBy: orderBy?.call(LibraryBookCourse.t),
      orderByList: orderByList?.call(LibraryBookCourse.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LibraryBookCourse] by its [id] or null if no such row exists.
  Future<LibraryBookCourse?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LibraryBookCourse>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LibraryBookCourse]s in the list and returns the inserted rows.
  ///
  /// The returned [LibraryBookCourse]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<LibraryBookCourse>> insert(
    _i1.DatabaseSession session,
    List<LibraryBookCourse> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<LibraryBookCourse>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [LibraryBookCourse] and returns the inserted row.
  ///
  /// The returned [LibraryBookCourse] will have its `id` field set.
  Future<LibraryBookCourse> insertRow(
    _i1.DatabaseSession session,
    LibraryBookCourse row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LibraryBookCourse>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LibraryBookCourse]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LibraryBookCourse>> update(
    _i1.DatabaseSession session,
    List<LibraryBookCourse> rows, {
    _i1.ColumnSelections<LibraryBookCourseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LibraryBookCourse>(
      rows,
      columns: columns?.call(LibraryBookCourse.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryBookCourse]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LibraryBookCourse> updateRow(
    _i1.DatabaseSession session,
    LibraryBookCourse row, {
    _i1.ColumnSelections<LibraryBookCourseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LibraryBookCourse>(
      row,
      columns: columns?.call(LibraryBookCourse.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryBookCourse] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LibraryBookCourse?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<LibraryBookCourseUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<LibraryBookCourse>(
      id,
      columnValues: columnValues(LibraryBookCourse.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LibraryBookCourse]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<LibraryBookCourse>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<LibraryBookCourseUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<LibraryBookCourseTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookCourseTable>? orderBy,
    _i1.OrderByListBuilder<LibraryBookCourseTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<LibraryBookCourse>(
      columnValues: columnValues(LibraryBookCourse.t.updateTable),
      where: where(LibraryBookCourse.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryBookCourse.t),
      orderByList: orderByList?.call(LibraryBookCourse.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [LibraryBookCourse]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LibraryBookCourse>> delete(
    _i1.DatabaseSession session,
    List<LibraryBookCourse> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LibraryBookCourse>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LibraryBookCourse].
  Future<LibraryBookCourse> deleteRow(
    _i1.DatabaseSession session,
    LibraryBookCourse row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LibraryBookCourse>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LibraryBookCourse>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LibraryBookCourseTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LibraryBookCourse>(
      where: where(LibraryBookCourse.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryBookCourseTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LibraryBookCourse>(
      where: where?.call(LibraryBookCourse.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LibraryBookCourse] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LibraryBookCourseTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LibraryBookCourse>(
      where: where(LibraryBookCourse.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
