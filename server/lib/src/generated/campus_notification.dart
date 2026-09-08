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

abstract class CampusNotification
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CampusNotification._({
    this.id,
    required this.userId,
    required this.category,
    required this.title,
    required this.body,
    this.targetType,
    this.targetId,
    this.readAt,
    required this.createdAt,
  });

  factory CampusNotification({
    int? id,
    required _i1.UuidValue userId,
    required String category,
    required String title,
    required String body,
    String? targetType,
    int? targetId,
    DateTime? readAt,
    required DateTime createdAt,
  }) = _CampusNotificationImpl;

  factory CampusNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusNotification(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      category: jsonSerialization['category'] as String,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      targetType: jsonSerialization['targetType'] as String?,
      targetId: jsonSerialization['targetId'] as int?,
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = CampusNotificationTable();

  static const db = CampusNotificationRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  String category;

  String title;

  String body;

  String? targetType;

  int? targetId;

  DateTime? readAt;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CampusNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CampusNotification copyWith({
    int? id,
    _i1.UuidValue? userId,
    String? category,
    String? title,
    String? body,
    String? targetType,
    int? targetId,
    DateTime? readAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CampusNotification',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'category': category,
      'title': title,
      'body': body,
      if (targetType != null) 'targetType': targetType,
      if (targetId != null) 'targetId': targetId,
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CampusNotification',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'category': category,
      'title': title,
      'body': body,
      if (targetType != null) 'targetType': targetType,
      if (targetId != null) 'targetId': targetId,
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static CampusNotificationInclude include() {
    return CampusNotificationInclude._();
  }

  static CampusNotificationIncludeList includeList({
    _i1.WhereExpressionBuilder<CampusNotificationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CampusNotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CampusNotificationTable>? orderByList,
    CampusNotificationInclude? include,
  }) {
    return CampusNotificationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CampusNotification.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CampusNotification.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CampusNotificationImpl extends CampusNotification {
  _CampusNotificationImpl({
    int? id,
    required _i1.UuidValue userId,
    required String category,
    required String title,
    required String body,
    String? targetType,
    int? targetId,
    DateTime? readAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         category: category,
         title: title,
         body: body,
         targetType: targetType,
         targetId: targetId,
         readAt: readAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CampusNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CampusNotification copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    String? category,
    String? title,
    String? body,
    Object? targetType = _Undefined,
    Object? targetId = _Undefined,
    Object? readAt = _Undefined,
    DateTime? createdAt,
  }) {
    return CampusNotification(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      title: title ?? this.title,
      body: body ?? this.body,
      targetType: targetType is String? ? targetType : this.targetType,
      targetId: targetId is int? ? targetId : this.targetId,
      readAt: readAt is DateTime? ? readAt : this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CampusNotificationUpdateTable
    extends _i1.UpdateTable<CampusNotificationTable> {
  CampusNotificationUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> category(String value) => _i1.ColumnValue(
    table.category,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> body(String value) => _i1.ColumnValue(
    table.body,
    value,
  );

  _i1.ColumnValue<String, String> targetType(String? value) => _i1.ColumnValue(
    table.targetType,
    value,
  );

  _i1.ColumnValue<int, int> targetId(int? value) => _i1.ColumnValue(
    table.targetId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> readAt(DateTime? value) =>
      _i1.ColumnValue(
        table.readAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class CampusNotificationTable extends _i1.Table<int?> {
  CampusNotificationTable({super.tableRelation})
    : super(tableName: 'campus_notifications') {
    updateTable = CampusNotificationUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    category = _i1.ColumnString(
      'category',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    body = _i1.ColumnString(
      'body',
      this,
    );
    targetType = _i1.ColumnString(
      'targetType',
      this,
    );
    targetId = _i1.ColumnInt(
      'targetId',
      this,
    );
    readAt = _i1.ColumnDateTime(
      'readAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final CampusNotificationUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnString category;

  late final _i1.ColumnString title;

  late final _i1.ColumnString body;

  late final _i1.ColumnString targetType;

  late final _i1.ColumnInt targetId;

  late final _i1.ColumnDateTime readAt;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    category,
    title,
    body,
    targetType,
    targetId,
    readAt,
    createdAt,
  ];
}

class CampusNotificationInclude extends _i1.IncludeObject {
  CampusNotificationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CampusNotification.t;
}

class CampusNotificationIncludeList extends _i1.IncludeList {
  CampusNotificationIncludeList._({
    _i1.WhereExpressionBuilder<CampusNotificationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CampusNotification.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CampusNotification.t;
}

class CampusNotificationRepository {
  const CampusNotificationRepository._();

  /// Returns a list of [CampusNotification]s matching the given query parameters.
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
  Future<List<CampusNotification>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CampusNotificationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CampusNotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CampusNotificationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CampusNotification>(
      where: where?.call(CampusNotification.t),
      orderBy: orderBy?.call(CampusNotification.t),
      orderByList: orderByList?.call(CampusNotification.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CampusNotification] matching the given query parameters.
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
  Future<CampusNotification?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CampusNotificationTable>? where,
    int? offset,
    _i1.OrderByBuilder<CampusNotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CampusNotificationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CampusNotification>(
      where: where?.call(CampusNotification.t),
      orderBy: orderBy?.call(CampusNotification.t),
      orderByList: orderByList?.call(CampusNotification.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CampusNotification] by its [id] or null if no such row exists.
  Future<CampusNotification?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CampusNotification>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CampusNotification]s in the list and returns the inserted rows.
  ///
  /// The returned [CampusNotification]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CampusNotification>> insert(
    _i1.DatabaseSession session,
    List<CampusNotification> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CampusNotification>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CampusNotification] and returns the inserted row.
  ///
  /// The returned [CampusNotification] will have its `id` field set.
  Future<CampusNotification> insertRow(
    _i1.DatabaseSession session,
    CampusNotification row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CampusNotification>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CampusNotification]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CampusNotification>> update(
    _i1.DatabaseSession session,
    List<CampusNotification> rows, {
    _i1.ColumnSelections<CampusNotificationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CampusNotification>(
      rows,
      columns: columns?.call(CampusNotification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CampusNotification]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CampusNotification> updateRow(
    _i1.DatabaseSession session,
    CampusNotification row, {
    _i1.ColumnSelections<CampusNotificationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CampusNotification>(
      row,
      columns: columns?.call(CampusNotification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CampusNotification] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CampusNotification?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CampusNotificationUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CampusNotification>(
      id,
      columnValues: columnValues(CampusNotification.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CampusNotification]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CampusNotification>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CampusNotificationUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<CampusNotificationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CampusNotificationTable>? orderBy,
    _i1.OrderByListBuilder<CampusNotificationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CampusNotification>(
      columnValues: columnValues(CampusNotification.t.updateTable),
      where: where(CampusNotification.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CampusNotification.t),
      orderByList: orderByList?.call(CampusNotification.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CampusNotification]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CampusNotification>> delete(
    _i1.DatabaseSession session,
    List<CampusNotification> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CampusNotification>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CampusNotification].
  Future<CampusNotification> deleteRow(
    _i1.DatabaseSession session,
    CampusNotification row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CampusNotification>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CampusNotification>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CampusNotificationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CampusNotification>(
      where: where(CampusNotification.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CampusNotificationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CampusNotification>(
      where: where?.call(CampusNotification.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CampusNotification] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CampusNotificationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CampusNotification>(
      where: where(CampusNotification.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
