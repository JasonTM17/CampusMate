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

abstract class LibraryAuthor
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LibraryAuthor._({
    this.id,
    required this.displayName,
    required this.normalizedName,
    this.biography,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LibraryAuthor({
    int? id,
    required String displayName,
    required String normalizedName,
    String? biography,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _LibraryAuthorImpl;

  factory LibraryAuthor.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryAuthor(
      id: jsonSerialization['id'] as int?,
      displayName: jsonSerialization['displayName'] as String,
      normalizedName: jsonSerialization['normalizedName'] as String,
      biography: jsonSerialization['biography'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = LibraryAuthorTable();

  static const db = LibraryAuthorRepository._();

  @override
  int? id;

  String displayName;

  String normalizedName;

  String? biography;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LibraryAuthor]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryAuthor copyWith({
    int? id,
    String? displayName,
    String? normalizedName,
    String? biography,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LibraryAuthor',
      if (id != null) 'id': id,
      'displayName': displayName,
      'normalizedName': normalizedName,
      if (biography != null) 'biography': biography,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LibraryAuthor',
      if (id != null) 'id': id,
      'displayName': displayName,
      'normalizedName': normalizedName,
      if (biography != null) 'biography': biography,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static LibraryAuthorInclude include() {
    return LibraryAuthorInclude._();
  }

  static LibraryAuthorIncludeList includeList({
    _i1.WhereExpressionBuilder<LibraryAuthorTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryAuthorTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryAuthorTable>? orderByList,
    LibraryAuthorInclude? include,
  }) {
    return LibraryAuthorIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryAuthor.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LibraryAuthor.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LibraryAuthorImpl extends LibraryAuthor {
  _LibraryAuthorImpl({
    int? id,
    required String displayName,
    required String normalizedName,
    String? biography,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         displayName: displayName,
         normalizedName: normalizedName,
         biography: biography,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [LibraryAuthor]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryAuthor copyWith({
    Object? id = _Undefined,
    String? displayName,
    String? normalizedName,
    Object? biography = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LibraryAuthor(
      id: id is int? ? id : this.id,
      displayName: displayName ?? this.displayName,
      normalizedName: normalizedName ?? this.normalizedName,
      biography: biography is String? ? biography : this.biography,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class LibraryAuthorUpdateTable extends _i1.UpdateTable<LibraryAuthorTable> {
  LibraryAuthorUpdateTable(super.table);

  _i1.ColumnValue<String, String> displayName(String value) => _i1.ColumnValue(
    table.displayName,
    value,
  );

  _i1.ColumnValue<String, String> normalizedName(String value) =>
      _i1.ColumnValue(
        table.normalizedName,
        value,
      );

  _i1.ColumnValue<String, String> biography(String? value) => _i1.ColumnValue(
    table.biography,
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

class LibraryAuthorTable extends _i1.Table<int?> {
  LibraryAuthorTable({super.tableRelation}) : super(tableName: 'authors') {
    updateTable = LibraryAuthorUpdateTable(this);
    displayName = _i1.ColumnString(
      'displayName',
      this,
    );
    normalizedName = _i1.ColumnString(
      'normalizedName',
      this,
    );
    biography = _i1.ColumnString(
      'biography',
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

  late final LibraryAuthorUpdateTable updateTable;

  late final _i1.ColumnString displayName;

  late final _i1.ColumnString normalizedName;

  late final _i1.ColumnString biography;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    displayName,
    normalizedName,
    biography,
    createdAt,
    updatedAt,
  ];
}

class LibraryAuthorInclude extends _i1.IncludeObject {
  LibraryAuthorInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => LibraryAuthor.t;
}

class LibraryAuthorIncludeList extends _i1.IncludeList {
  LibraryAuthorIncludeList._({
    _i1.WhereExpressionBuilder<LibraryAuthorTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LibraryAuthor.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LibraryAuthor.t;
}

class LibraryAuthorRepository {
  const LibraryAuthorRepository._();

  /// Returns a list of [LibraryAuthor]s matching the given query parameters.
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
  Future<List<LibraryAuthor>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryAuthorTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryAuthorTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryAuthorTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LibraryAuthor>(
      where: where?.call(LibraryAuthor.t),
      orderBy: orderBy?.call(LibraryAuthor.t),
      orderByList: orderByList?.call(LibraryAuthor.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LibraryAuthor] matching the given query parameters.
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
  Future<LibraryAuthor?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryAuthorTable>? where,
    int? offset,
    _i1.OrderByBuilder<LibraryAuthorTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryAuthorTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LibraryAuthor>(
      where: where?.call(LibraryAuthor.t),
      orderBy: orderBy?.call(LibraryAuthor.t),
      orderByList: orderByList?.call(LibraryAuthor.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LibraryAuthor] by its [id] or null if no such row exists.
  Future<LibraryAuthor?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LibraryAuthor>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LibraryAuthor]s in the list and returns the inserted rows.
  ///
  /// The returned [LibraryAuthor]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<LibraryAuthor>> insert(
    _i1.DatabaseSession session,
    List<LibraryAuthor> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<LibraryAuthor>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [LibraryAuthor] and returns the inserted row.
  ///
  /// The returned [LibraryAuthor] will have its `id` field set.
  Future<LibraryAuthor> insertRow(
    _i1.DatabaseSession session,
    LibraryAuthor row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LibraryAuthor>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LibraryAuthor]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LibraryAuthor>> update(
    _i1.DatabaseSession session,
    List<LibraryAuthor> rows, {
    _i1.ColumnSelections<LibraryAuthorTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LibraryAuthor>(
      rows,
      columns: columns?.call(LibraryAuthor.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryAuthor]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LibraryAuthor> updateRow(
    _i1.DatabaseSession session,
    LibraryAuthor row, {
    _i1.ColumnSelections<LibraryAuthorTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LibraryAuthor>(
      row,
      columns: columns?.call(LibraryAuthor.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryAuthor] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LibraryAuthor?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<LibraryAuthorUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<LibraryAuthor>(
      id,
      columnValues: columnValues(LibraryAuthor.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LibraryAuthor]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<LibraryAuthor>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<LibraryAuthorUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<LibraryAuthorTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryAuthorTable>? orderBy,
    _i1.OrderByListBuilder<LibraryAuthorTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<LibraryAuthor>(
      columnValues: columnValues(LibraryAuthor.t.updateTable),
      where: where(LibraryAuthor.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryAuthor.t),
      orderByList: orderByList?.call(LibraryAuthor.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [LibraryAuthor]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LibraryAuthor>> delete(
    _i1.DatabaseSession session,
    List<LibraryAuthor> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LibraryAuthor>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LibraryAuthor].
  Future<LibraryAuthor> deleteRow(
    _i1.DatabaseSession session,
    LibraryAuthor row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LibraryAuthor>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LibraryAuthor>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LibraryAuthorTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LibraryAuthor>(
      where: where(LibraryAuthor.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryAuthorTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LibraryAuthor>(
      where: where?.call(LibraryAuthor.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LibraryAuthor] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LibraryAuthorTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LibraryAuthor>(
      where: where(LibraryAuthor.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
