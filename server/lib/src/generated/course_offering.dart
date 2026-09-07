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

abstract class CourseOffering
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CourseOffering._({
    this.id,
    required this.courseId,
    required this.semesterId,
    required this.section,
    required this.lecturerName,
    this.room,
  });

  factory CourseOffering({
    int? id,
    required int courseId,
    required int semesterId,
    required String section,
    required String lecturerName,
    String? room,
  }) = _CourseOfferingImpl;

  factory CourseOffering.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseOffering(
      id: jsonSerialization['id'] as int?,
      courseId: jsonSerialization['courseId'] as int,
      semesterId: jsonSerialization['semesterId'] as int,
      section: jsonSerialization['section'] as String,
      lecturerName: jsonSerialization['lecturerName'] as String,
      room: jsonSerialization['room'] as String?,
    );
  }

  static final t = CourseOfferingTable();

  static const db = CourseOfferingRepository._();

  @override
  int? id;

  int courseId;

  int semesterId;

  String section;

  String lecturerName;

  String? room;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CourseOffering]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseOffering copyWith({
    int? id,
    int? courseId,
    int? semesterId,
    String? section,
    String? lecturerName,
    String? room,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseOffering',
      if (id != null) 'id': id,
      'courseId': courseId,
      'semesterId': semesterId,
      'section': section,
      'lecturerName': lecturerName,
      if (room != null) 'room': room,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CourseOffering',
      if (id != null) 'id': id,
      'courseId': courseId,
      'semesterId': semesterId,
      'section': section,
      'lecturerName': lecturerName,
      if (room != null) 'room': room,
    };
  }

  static CourseOfferingInclude include() {
    return CourseOfferingInclude._();
  }

  static CourseOfferingIncludeList includeList({
    _i1.WhereExpressionBuilder<CourseOfferingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseOfferingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseOfferingTable>? orderByList,
    CourseOfferingInclude? include,
  }) {
    return CourseOfferingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CourseOffering.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CourseOffering.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseOfferingImpl extends CourseOffering {
  _CourseOfferingImpl({
    int? id,
    required int courseId,
    required int semesterId,
    required String section,
    required String lecturerName,
    String? room,
  }) : super._(
         id: id,
         courseId: courseId,
         semesterId: semesterId,
         section: section,
         lecturerName: lecturerName,
         room: room,
       );

  /// Returns a shallow copy of this [CourseOffering]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CourseOffering copyWith({
    Object? id = _Undefined,
    int? courseId,
    int? semesterId,
    String? section,
    String? lecturerName,
    Object? room = _Undefined,
  }) {
    return CourseOffering(
      id: id is int? ? id : this.id,
      courseId: courseId ?? this.courseId,
      semesterId: semesterId ?? this.semesterId,
      section: section ?? this.section,
      lecturerName: lecturerName ?? this.lecturerName,
      room: room is String? ? room : this.room,
    );
  }
}

class CourseOfferingUpdateTable extends _i1.UpdateTable<CourseOfferingTable> {
  CourseOfferingUpdateTable(super.table);

  _i1.ColumnValue<int, int> courseId(int value) => _i1.ColumnValue(
    table.courseId,
    value,
  );

  _i1.ColumnValue<int, int> semesterId(int value) => _i1.ColumnValue(
    table.semesterId,
    value,
  );

  _i1.ColumnValue<String, String> section(String value) => _i1.ColumnValue(
    table.section,
    value,
  );

  _i1.ColumnValue<String, String> lecturerName(String value) => _i1.ColumnValue(
    table.lecturerName,
    value,
  );

  _i1.ColumnValue<String, String> room(String? value) => _i1.ColumnValue(
    table.room,
    value,
  );
}

class CourseOfferingTable extends _i1.Table<int?> {
  CourseOfferingTable({super.tableRelation})
    : super(tableName: 'course_offerings') {
    updateTable = CourseOfferingUpdateTable(this);
    courseId = _i1.ColumnInt(
      'courseId',
      this,
    );
    semesterId = _i1.ColumnInt(
      'semesterId',
      this,
    );
    section = _i1.ColumnString(
      'section',
      this,
    );
    lecturerName = _i1.ColumnString(
      'lecturerName',
      this,
    );
    room = _i1.ColumnString(
      'room',
      this,
    );
  }

  late final CourseOfferingUpdateTable updateTable;

  late final _i1.ColumnInt courseId;

  late final _i1.ColumnInt semesterId;

  late final _i1.ColumnString section;

  late final _i1.ColumnString lecturerName;

  late final _i1.ColumnString room;

  @override
  List<_i1.Column> get columns => [
    id,
    courseId,
    semesterId,
    section,
    lecturerName,
    room,
  ];
}

class CourseOfferingInclude extends _i1.IncludeObject {
  CourseOfferingInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CourseOffering.t;
}

class CourseOfferingIncludeList extends _i1.IncludeList {
  CourseOfferingIncludeList._({
    _i1.WhereExpressionBuilder<CourseOfferingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CourseOffering.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CourseOffering.t;
}

class CourseOfferingRepository {
  const CourseOfferingRepository._();

  /// Returns a list of [CourseOffering]s matching the given query parameters.
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
  Future<List<CourseOffering>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CourseOfferingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseOfferingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseOfferingTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CourseOffering>(
      where: where?.call(CourseOffering.t),
      orderBy: orderBy?.call(CourseOffering.t),
      orderByList: orderByList?.call(CourseOffering.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CourseOffering] matching the given query parameters.
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
  Future<CourseOffering?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CourseOfferingTable>? where,
    int? offset,
    _i1.OrderByBuilder<CourseOfferingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseOfferingTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CourseOffering>(
      where: where?.call(CourseOffering.t),
      orderBy: orderBy?.call(CourseOffering.t),
      orderByList: orderByList?.call(CourseOffering.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CourseOffering] by its [id] or null if no such row exists.
  Future<CourseOffering?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CourseOffering>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CourseOffering]s in the list and returns the inserted rows.
  ///
  /// The returned [CourseOffering]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CourseOffering>> insert(
    _i1.DatabaseSession session,
    List<CourseOffering> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CourseOffering>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CourseOffering] and returns the inserted row.
  ///
  /// The returned [CourseOffering] will have its `id` field set.
  Future<CourseOffering> insertRow(
    _i1.DatabaseSession session,
    CourseOffering row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CourseOffering>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CourseOffering]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CourseOffering>> update(
    _i1.DatabaseSession session,
    List<CourseOffering> rows, {
    _i1.ColumnSelections<CourseOfferingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CourseOffering>(
      rows,
      columns: columns?.call(CourseOffering.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CourseOffering]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CourseOffering> updateRow(
    _i1.DatabaseSession session,
    CourseOffering row, {
    _i1.ColumnSelections<CourseOfferingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CourseOffering>(
      row,
      columns: columns?.call(CourseOffering.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CourseOffering] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CourseOffering?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CourseOfferingUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CourseOffering>(
      id,
      columnValues: columnValues(CourseOffering.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CourseOffering]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CourseOffering>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CourseOfferingUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CourseOfferingTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseOfferingTable>? orderBy,
    _i1.OrderByListBuilder<CourseOfferingTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CourseOffering>(
      columnValues: columnValues(CourseOffering.t.updateTable),
      where: where(CourseOffering.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CourseOffering.t),
      orderByList: orderByList?.call(CourseOffering.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CourseOffering]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CourseOffering>> delete(
    _i1.DatabaseSession session,
    List<CourseOffering> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CourseOffering>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CourseOffering].
  Future<CourseOffering> deleteRow(
    _i1.DatabaseSession session,
    CourseOffering row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CourseOffering>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CourseOffering>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CourseOfferingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CourseOffering>(
      where: where(CourseOffering.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CourseOfferingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CourseOffering>(
      where: where?.call(CourseOffering.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CourseOffering] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CourseOfferingTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CourseOffering>(
      where: where(CourseOffering.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
