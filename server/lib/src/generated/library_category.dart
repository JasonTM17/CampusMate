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

abstract class LibraryCategory
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LibraryCategory._({
    this.id,
    required this.name,
    required this.slug,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LibraryCategory({
    int? id,
    required String name,
    required String slug,
    String? description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _LibraryCategoryImpl;

  factory LibraryCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryCategory(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      slug: jsonSerialization['slug'] as String,
      description: jsonSerialization['description'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = LibraryCategoryTable();

  static const db = LibraryCategoryRepository._();

  @override
  int? id;

  String name;

  String slug;

  String? description;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LibraryCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryCategory copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LibraryCategory',
      if (id != null) 'id': id,
      'name': name,
      'slug': slug,
      if (description != null) 'description': description,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LibraryCategory',
      if (id != null) 'id': id,
      'name': name,
      'slug': slug,
      if (description != null) 'description': description,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static LibraryCategoryInclude include() {
    return LibraryCategoryInclude._();
  }

  static LibraryCategoryIncludeList includeList({
    _i1.WhereExpressionBuilder<LibraryCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryCategoryTable>? orderByList,
    LibraryCategoryInclude? include,
  }) {
    return LibraryCategoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryCategory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LibraryCategory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LibraryCategoryImpl extends LibraryCategory {
  _LibraryCategoryImpl({
    int? id,
    required String name,
    required String slug,
    String? description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         name: name,
         slug: slug,
         description: description,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [LibraryCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryCategory copyWith({
    Object? id = _Undefined,
    String? name,
    String? slug,
    Object? description = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LibraryCategory(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description is String? ? description : this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class LibraryCategoryUpdateTable extends _i1.UpdateTable<LibraryCategoryTable> {
  LibraryCategoryUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> slug(String value) => _i1.ColumnValue(
    table.slug,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
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

class LibraryCategoryTable extends _i1.Table<int?> {
  LibraryCategoryTable({super.tableRelation})
    : super(tableName: 'book_categories') {
    updateTable = LibraryCategoryUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    slug = _i1.ColumnString(
      'slug',
      this,
    );
    description = _i1.ColumnString(
      'description',
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

  late final LibraryCategoryUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString slug;

  late final _i1.ColumnString description;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    slug,
    description,
    createdAt,
    updatedAt,
  ];
}

class LibraryCategoryInclude extends _i1.IncludeObject {
  LibraryCategoryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => LibraryCategory.t;
}

class LibraryCategoryIncludeList extends _i1.IncludeList {
  LibraryCategoryIncludeList._({
    _i1.WhereExpressionBuilder<LibraryCategoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LibraryCategory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LibraryCategory.t;
}

class LibraryCategoryRepository {
  const LibraryCategoryRepository._();

  /// Returns a list of [LibraryCategory]s matching the given query parameters.
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
  Future<List<LibraryCategory>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryCategoryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LibraryCategory>(
      where: where?.call(LibraryCategory.t),
      orderBy: orderBy?.call(LibraryCategory.t),
      orderByList: orderByList?.call(LibraryCategory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LibraryCategory] matching the given query parameters.
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
  Future<LibraryCategory?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryCategoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<LibraryCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryCategoryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LibraryCategory>(
      where: where?.call(LibraryCategory.t),
      orderBy: orderBy?.call(LibraryCategory.t),
      orderByList: orderByList?.call(LibraryCategory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LibraryCategory] by its [id] or null if no such row exists.
  Future<LibraryCategory?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LibraryCategory>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LibraryCategory]s in the list and returns the inserted rows.
  ///
  /// The returned [LibraryCategory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<LibraryCategory>> insert(
    _i1.DatabaseSession session,
    List<LibraryCategory> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<LibraryCategory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [LibraryCategory] and returns the inserted row.
  ///
  /// The returned [LibraryCategory] will have its `id` field set.
  Future<LibraryCategory> insertRow(
    _i1.DatabaseSession session,
    LibraryCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LibraryCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LibraryCategory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LibraryCategory>> update(
    _i1.DatabaseSession session,
    List<LibraryCategory> rows, {
    _i1.ColumnSelections<LibraryCategoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LibraryCategory>(
      rows,
      columns: columns?.call(LibraryCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryCategory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LibraryCategory> updateRow(
    _i1.DatabaseSession session,
    LibraryCategory row, {
    _i1.ColumnSelections<LibraryCategoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LibraryCategory>(
      row,
      columns: columns?.call(LibraryCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryCategory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LibraryCategory?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<LibraryCategoryUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<LibraryCategory>(
      id,
      columnValues: columnValues(LibraryCategory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LibraryCategory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<LibraryCategory>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<LibraryCategoryUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<LibraryCategoryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryCategoryTable>? orderBy,
    _i1.OrderByListBuilder<LibraryCategoryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<LibraryCategory>(
      columnValues: columnValues(LibraryCategory.t.updateTable),
      where: where(LibraryCategory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryCategory.t),
      orderByList: orderByList?.call(LibraryCategory.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [LibraryCategory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LibraryCategory>> delete(
    _i1.DatabaseSession session,
    List<LibraryCategory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LibraryCategory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LibraryCategory].
  Future<LibraryCategory> deleteRow(
    _i1.DatabaseSession session,
    LibraryCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LibraryCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LibraryCategory>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LibraryCategoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LibraryCategory>(
      where: where(LibraryCategory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryCategoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LibraryCategory>(
      where: where?.call(LibraryCategory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LibraryCategory] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LibraryCategoryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LibraryCategory>(
      where: where(LibraryCategory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
