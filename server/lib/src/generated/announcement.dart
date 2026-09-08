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

abstract class Announcement
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Announcement._({
    this.id,
    required this.title,
    required this.body,
    required this.audience,
    required this.publishAt,
    this.expiresAt,
    required this.archived,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Announcement({
    int? id,
    required String title,
    required String body,
    required String audience,
    required DateTime publishAt,
    DateTime? expiresAt,
    required bool archived,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AnnouncementImpl;

  factory Announcement.fromJson(Map<String, dynamic> jsonSerialization) {
    return Announcement(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      audience: jsonSerialization['audience'] as String,
      publishAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['publishAt'],
      ),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      archived: _i1.BoolJsonExtension.fromJson(jsonSerialization['archived']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = AnnouncementTable();

  static const db = AnnouncementRepository._();

  @override
  int? id;

  String title;

  String body;

  String audience;

  DateTime publishAt;

  DateTime? expiresAt;

  bool archived;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Announcement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Announcement copyWith({
    int? id,
    String? title,
    String? body,
    String? audience,
    DateTime? publishAt,
    DateTime? expiresAt,
    bool? archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Announcement',
      if (id != null) 'id': id,
      'title': title,
      'body': body,
      'audience': audience,
      'publishAt': publishAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'archived': archived,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Announcement',
      if (id != null) 'id': id,
      'title': title,
      'body': body,
      'audience': audience,
      'publishAt': publishAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'archived': archived,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AnnouncementInclude include() {
    return AnnouncementInclude._();
  }

  static AnnouncementIncludeList includeList({
    _i1.WhereExpressionBuilder<AnnouncementTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnnouncementTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnnouncementTable>? orderByList,
    AnnouncementInclude? include,
  }) {
    return AnnouncementIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Announcement.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Announcement.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnnouncementImpl extends Announcement {
  _AnnouncementImpl({
    int? id,
    required String title,
    required String body,
    required String audience,
    required DateTime publishAt,
    DateTime? expiresAt,
    required bool archived,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         title: title,
         body: body,
         audience: audience,
         publishAt: publishAt,
         expiresAt: expiresAt,
         archived: archived,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Announcement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Announcement copyWith({
    Object? id = _Undefined,
    String? title,
    String? body,
    String? audience,
    DateTime? publishAt,
    Object? expiresAt = _Undefined,
    bool? archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Announcement(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      audience: audience ?? this.audience,
      publishAt: publishAt ?? this.publishAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AnnouncementUpdateTable extends _i1.UpdateTable<AnnouncementTable> {
  AnnouncementUpdateTable(super.table);

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> body(String value) => _i1.ColumnValue(
    table.body,
    value,
  );

  _i1.ColumnValue<String, String> audience(String value) => _i1.ColumnValue(
    table.audience,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> publishAt(DateTime value) =>
      _i1.ColumnValue(
        table.publishAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime? value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );

  _i1.ColumnValue<bool, bool> archived(bool value) => _i1.ColumnValue(
    table.archived,
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

class AnnouncementTable extends _i1.Table<int?> {
  AnnouncementTable({super.tableRelation}) : super(tableName: 'announcements') {
    updateTable = AnnouncementUpdateTable(this);
    title = _i1.ColumnString(
      'title',
      this,
    );
    body = _i1.ColumnString(
      'body',
      this,
    );
    audience = _i1.ColumnString(
      'audience',
      this,
    );
    publishAt = _i1.ColumnDateTime(
      'publishAt',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    archived = _i1.ColumnBool(
      'archived',
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

  late final AnnouncementUpdateTable updateTable;

  late final _i1.ColumnString title;

  late final _i1.ColumnString body;

  late final _i1.ColumnString audience;

  late final _i1.ColumnDateTime publishAt;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnBool archived;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    title,
    body,
    audience,
    publishAt,
    expiresAt,
    archived,
    createdAt,
    updatedAt,
  ];
}

class AnnouncementInclude extends _i1.IncludeObject {
  AnnouncementInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Announcement.t;
}

class AnnouncementIncludeList extends _i1.IncludeList {
  AnnouncementIncludeList._({
    _i1.WhereExpressionBuilder<AnnouncementTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Announcement.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Announcement.t;
}

class AnnouncementRepository {
  const AnnouncementRepository._();

  /// Returns a list of [Announcement]s matching the given query parameters.
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
  Future<List<Announcement>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AnnouncementTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnnouncementTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnnouncementTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Announcement>(
      where: where?.call(Announcement.t),
      orderBy: orderBy?.call(Announcement.t),
      orderByList: orderByList?.call(Announcement.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Announcement] matching the given query parameters.
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
  Future<Announcement?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AnnouncementTable>? where,
    int? offset,
    _i1.OrderByBuilder<AnnouncementTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AnnouncementTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Announcement>(
      where: where?.call(Announcement.t),
      orderBy: orderBy?.call(Announcement.t),
      orderByList: orderByList?.call(Announcement.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Announcement] by its [id] or null if no such row exists.
  Future<Announcement?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Announcement>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Announcement]s in the list and returns the inserted rows.
  ///
  /// The returned [Announcement]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Announcement>> insert(
    _i1.DatabaseSession session,
    List<Announcement> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Announcement>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Announcement] and returns the inserted row.
  ///
  /// The returned [Announcement] will have its `id` field set.
  Future<Announcement> insertRow(
    _i1.DatabaseSession session,
    Announcement row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Announcement>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Announcement]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Announcement>> update(
    _i1.DatabaseSession session,
    List<Announcement> rows, {
    _i1.ColumnSelections<AnnouncementTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Announcement>(
      rows,
      columns: columns?.call(Announcement.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Announcement]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Announcement> updateRow(
    _i1.DatabaseSession session,
    Announcement row, {
    _i1.ColumnSelections<AnnouncementTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Announcement>(
      row,
      columns: columns?.call(Announcement.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Announcement] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Announcement?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AnnouncementUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Announcement>(
      id,
      columnValues: columnValues(Announcement.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Announcement]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Announcement>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AnnouncementUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AnnouncementTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AnnouncementTable>? orderBy,
    _i1.OrderByListBuilder<AnnouncementTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Announcement>(
      columnValues: columnValues(Announcement.t.updateTable),
      where: where(Announcement.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Announcement.t),
      orderByList: orderByList?.call(Announcement.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Announcement]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Announcement>> delete(
    _i1.DatabaseSession session,
    List<Announcement> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Announcement>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Announcement].
  Future<Announcement> deleteRow(
    _i1.DatabaseSession session,
    Announcement row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Announcement>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Announcement>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AnnouncementTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Announcement>(
      where: where(Announcement.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AnnouncementTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Announcement>(
      where: where?.call(Announcement.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Announcement] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AnnouncementTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Announcement>(
      where: where(Announcement.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
