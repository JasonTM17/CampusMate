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

abstract class LibraryBookFile
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LibraryBookFile._({
    this.id,
    required this.bookId,
    required this.format,
    required this.storageKey,
    required this.byteSize,
    required this.checksum,
    required this.isPrimary,
    required this.createdAt,
  });

  factory LibraryBookFile({
    int? id,
    required int bookId,
    required String format,
    required String storageKey,
    required int byteSize,
    required String checksum,
    required bool isPrimary,
    required DateTime createdAt,
  }) = _LibraryBookFileImpl;

  factory LibraryBookFile.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryBookFile(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      format: jsonSerialization['format'] as String,
      storageKey: jsonSerialization['storageKey'] as String,
      byteSize: jsonSerialization['byteSize'] as int,
      checksum: jsonSerialization['checksum'] as String,
      isPrimary: _i1.BoolJsonExtension.fromJson(jsonSerialization['isPrimary']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = LibraryBookFileTable();

  static const db = LibraryBookFileRepository._();

  @override
  int? id;

  int bookId;

  String format;

  String storageKey;

  int byteSize;

  String checksum;

  bool isPrimary;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LibraryBookFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryBookFile copyWith({
    int? id,
    int? bookId,
    String? format,
    String? storageKey,
    int? byteSize,
    String? checksum,
    bool? isPrimary,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LibraryBookFile',
      if (id != null) 'id': id,
      'bookId': bookId,
      'format': format,
      'storageKey': storageKey,
      'byteSize': byteSize,
      'checksum': checksum,
      'isPrimary': isPrimary,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LibraryBookFile',
      if (id != null) 'id': id,
      'bookId': bookId,
      'format': format,
      'storageKey': storageKey,
      'byteSize': byteSize,
      'checksum': checksum,
      'isPrimary': isPrimary,
      'createdAt': createdAt.toJson(),
    };
  }

  static LibraryBookFileInclude include() {
    return LibraryBookFileInclude._();
  }

  static LibraryBookFileIncludeList includeList({
    _i1.WhereExpressionBuilder<LibraryBookFileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookFileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookFileTable>? orderByList,
    LibraryBookFileInclude? include,
  }) {
    return LibraryBookFileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryBookFile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LibraryBookFile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LibraryBookFileImpl extends LibraryBookFile {
  _LibraryBookFileImpl({
    int? id,
    required int bookId,
    required String format,
    required String storageKey,
    required int byteSize,
    required String checksum,
    required bool isPrimary,
    required DateTime createdAt,
  }) : super._(
         id: id,
         bookId: bookId,
         format: format,
         storageKey: storageKey,
         byteSize: byteSize,
         checksum: checksum,
         isPrimary: isPrimary,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [LibraryBookFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryBookFile copyWith({
    Object? id = _Undefined,
    int? bookId,
    String? format,
    String? storageKey,
    int? byteSize,
    String? checksum,
    bool? isPrimary,
    DateTime? createdAt,
  }) {
    return LibraryBookFile(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      format: format ?? this.format,
      storageKey: storageKey ?? this.storageKey,
      byteSize: byteSize ?? this.byteSize,
      checksum: checksum ?? this.checksum,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class LibraryBookFileUpdateTable extends _i1.UpdateTable<LibraryBookFileTable> {
  LibraryBookFileUpdateTable(super.table);

  _i1.ColumnValue<int, int> bookId(int value) => _i1.ColumnValue(
    table.bookId,
    value,
  );

  _i1.ColumnValue<String, String> format(String value) => _i1.ColumnValue(
    table.format,
    value,
  );

  _i1.ColumnValue<String, String> storageKey(String value) => _i1.ColumnValue(
    table.storageKey,
    value,
  );

  _i1.ColumnValue<int, int> byteSize(int value) => _i1.ColumnValue(
    table.byteSize,
    value,
  );

  _i1.ColumnValue<String, String> checksum(String value) => _i1.ColumnValue(
    table.checksum,
    value,
  );

  _i1.ColumnValue<bool, bool> isPrimary(bool value) => _i1.ColumnValue(
    table.isPrimary,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class LibraryBookFileTable extends _i1.Table<int?> {
  LibraryBookFileTable({super.tableRelation}) : super(tableName: 'book_files') {
    updateTable = LibraryBookFileUpdateTable(this);
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    format = _i1.ColumnString(
      'format',
      this,
    );
    storageKey = _i1.ColumnString(
      'storageKey',
      this,
    );
    byteSize = _i1.ColumnInt(
      'byteSize',
      this,
    );
    checksum = _i1.ColumnString(
      'checksum',
      this,
    );
    isPrimary = _i1.ColumnBool(
      'isPrimary',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final LibraryBookFileUpdateTable updateTable;

  late final _i1.ColumnInt bookId;

  late final _i1.ColumnString format;

  late final _i1.ColumnString storageKey;

  late final _i1.ColumnInt byteSize;

  late final _i1.ColumnString checksum;

  late final _i1.ColumnBool isPrimary;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    bookId,
    format,
    storageKey,
    byteSize,
    checksum,
    isPrimary,
    createdAt,
  ];
}

class LibraryBookFileInclude extends _i1.IncludeObject {
  LibraryBookFileInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => LibraryBookFile.t;
}

class LibraryBookFileIncludeList extends _i1.IncludeList {
  LibraryBookFileIncludeList._({
    _i1.WhereExpressionBuilder<LibraryBookFileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LibraryBookFile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LibraryBookFile.t;
}

class LibraryBookFileRepository {
  const LibraryBookFileRepository._();

  /// Returns a list of [LibraryBookFile]s matching the given query parameters.
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
  Future<List<LibraryBookFile>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryBookFileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookFileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookFileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LibraryBookFile>(
      where: where?.call(LibraryBookFile.t),
      orderBy: orderBy?.call(LibraryBookFile.t),
      orderByList: orderByList?.call(LibraryBookFile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LibraryBookFile] matching the given query parameters.
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
  Future<LibraryBookFile?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryBookFileTable>? where,
    int? offset,
    _i1.OrderByBuilder<LibraryBookFileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookFileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LibraryBookFile>(
      where: where?.call(LibraryBookFile.t),
      orderBy: orderBy?.call(LibraryBookFile.t),
      orderByList: orderByList?.call(LibraryBookFile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LibraryBookFile] by its [id] or null if no such row exists.
  Future<LibraryBookFile?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LibraryBookFile>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LibraryBookFile]s in the list and returns the inserted rows.
  ///
  /// The returned [LibraryBookFile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<LibraryBookFile>> insert(
    _i1.DatabaseSession session,
    List<LibraryBookFile> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<LibraryBookFile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [LibraryBookFile] and returns the inserted row.
  ///
  /// The returned [LibraryBookFile] will have its `id` field set.
  Future<LibraryBookFile> insertRow(
    _i1.DatabaseSession session,
    LibraryBookFile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LibraryBookFile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LibraryBookFile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LibraryBookFile>> update(
    _i1.DatabaseSession session,
    List<LibraryBookFile> rows, {
    _i1.ColumnSelections<LibraryBookFileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LibraryBookFile>(
      rows,
      columns: columns?.call(LibraryBookFile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryBookFile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LibraryBookFile> updateRow(
    _i1.DatabaseSession session,
    LibraryBookFile row, {
    _i1.ColumnSelections<LibraryBookFileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LibraryBookFile>(
      row,
      columns: columns?.call(LibraryBookFile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryBookFile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LibraryBookFile?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<LibraryBookFileUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<LibraryBookFile>(
      id,
      columnValues: columnValues(LibraryBookFile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LibraryBookFile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<LibraryBookFile>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<LibraryBookFileUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<LibraryBookFileTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookFileTable>? orderBy,
    _i1.OrderByListBuilder<LibraryBookFileTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<LibraryBookFile>(
      columnValues: columnValues(LibraryBookFile.t.updateTable),
      where: where(LibraryBookFile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryBookFile.t),
      orderByList: orderByList?.call(LibraryBookFile.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [LibraryBookFile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LibraryBookFile>> delete(
    _i1.DatabaseSession session,
    List<LibraryBookFile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LibraryBookFile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LibraryBookFile].
  Future<LibraryBookFile> deleteRow(
    _i1.DatabaseSession session,
    LibraryBookFile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LibraryBookFile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LibraryBookFile>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LibraryBookFileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LibraryBookFile>(
      where: where(LibraryBookFile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryBookFileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LibraryBookFile>(
      where: where?.call(LibraryBookFile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LibraryBookFile] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LibraryBookFileTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LibraryBookFile>(
      where: where(LibraryBookFile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
