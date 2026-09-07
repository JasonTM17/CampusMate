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

abstract class CourseSchedule
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CourseSchedule._({
    this.id,
    required this.offeringId,
    required this.weekday,
    required this.startMinute,
    required this.endMinute,
    required this.room,
    required this.campus,
    required this.startsAt,
    required this.endsAt,
    required this.status,
  });

  factory CourseSchedule({
    int? id,
    required int offeringId,
    required int weekday,
    required int startMinute,
    required int endMinute,
    required String room,
    required String campus,
    required DateTime startsAt,
    required DateTime endsAt,
    required String status,
  }) = _CourseScheduleImpl;

  factory CourseSchedule.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseSchedule(
      id: jsonSerialization['id'] as int?,
      offeringId: jsonSerialization['offeringId'] as int,
      weekday: jsonSerialization['weekday'] as int,
      startMinute: jsonSerialization['startMinute'] as int,
      endMinute: jsonSerialization['endMinute'] as int,
      room: jsonSerialization['room'] as String,
      campus: jsonSerialization['campus'] as String,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      status: jsonSerialization['status'] as String,
    );
  }

  static final t = CourseScheduleTable();

  static const db = CourseScheduleRepository._();

  @override
  int? id;

  int offeringId;

  int weekday;

  int startMinute;

  int endMinute;

  String room;

  String campus;

  DateTime startsAt;

  DateTime endsAt;

  String status;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CourseSchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseSchedule copyWith({
    int? id,
    int? offeringId,
    int? weekday,
    int? startMinute,
    int? endMinute,
    String? room,
    String? campus,
    DateTime? startsAt,
    DateTime? endsAt,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseSchedule',
      if (id != null) 'id': id,
      'offeringId': offeringId,
      'weekday': weekday,
      'startMinute': startMinute,
      'endMinute': endMinute,
      'room': room,
      'campus': campus,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CourseSchedule',
      if (id != null) 'id': id,
      'offeringId': offeringId,
      'weekday': weekday,
      'startMinute': startMinute,
      'endMinute': endMinute,
      'room': room,
      'campus': campus,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'status': status,
    };
  }

  static CourseScheduleInclude include() {
    return CourseScheduleInclude._();
  }

  static CourseScheduleIncludeList includeList({
    _i1.WhereExpressionBuilder<CourseScheduleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseScheduleTable>? orderByList,
    CourseScheduleInclude? include,
  }) {
    return CourseScheduleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CourseSchedule.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CourseSchedule.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseScheduleImpl extends CourseSchedule {
  _CourseScheduleImpl({
    int? id,
    required int offeringId,
    required int weekday,
    required int startMinute,
    required int endMinute,
    required String room,
    required String campus,
    required DateTime startsAt,
    required DateTime endsAt,
    required String status,
  }) : super._(
         id: id,
         offeringId: offeringId,
         weekday: weekday,
         startMinute: startMinute,
         endMinute: endMinute,
         room: room,
         campus: campus,
         startsAt: startsAt,
         endsAt: endsAt,
         status: status,
       );

  /// Returns a shallow copy of this [CourseSchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CourseSchedule copyWith({
    Object? id = _Undefined,
    int? offeringId,
    int? weekday,
    int? startMinute,
    int? endMinute,
    String? room,
    String? campus,
    DateTime? startsAt,
    DateTime? endsAt,
    String? status,
  }) {
    return CourseSchedule(
      id: id is int? ? id : this.id,
      offeringId: offeringId ?? this.offeringId,
      weekday: weekday ?? this.weekday,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      room: room ?? this.room,
      campus: campus ?? this.campus,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      status: status ?? this.status,
    );
  }
}

class CourseScheduleUpdateTable extends _i1.UpdateTable<CourseScheduleTable> {
  CourseScheduleUpdateTable(super.table);

  _i1.ColumnValue<int, int> offeringId(int value) => _i1.ColumnValue(
    table.offeringId,
    value,
  );

  _i1.ColumnValue<int, int> weekday(int value) => _i1.ColumnValue(
    table.weekday,
    value,
  );

  _i1.ColumnValue<int, int> startMinute(int value) => _i1.ColumnValue(
    table.startMinute,
    value,
  );

  _i1.ColumnValue<int, int> endMinute(int value) => _i1.ColumnValue(
    table.endMinute,
    value,
  );

  _i1.ColumnValue<String, String> room(String value) => _i1.ColumnValue(
    table.room,
    value,
  );

  _i1.ColumnValue<String, String> campus(String value) => _i1.ColumnValue(
    table.campus,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startsAt(DateTime value) =>
      _i1.ColumnValue(
        table.startsAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> endsAt(DateTime value) => _i1.ColumnValue(
    table.endsAt,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );
}

class CourseScheduleTable extends _i1.Table<int?> {
  CourseScheduleTable({super.tableRelation})
    : super(tableName: 'course_schedules') {
    updateTable = CourseScheduleUpdateTable(this);
    offeringId = _i1.ColumnInt(
      'offeringId',
      this,
    );
    weekday = _i1.ColumnInt(
      'weekday',
      this,
    );
    startMinute = _i1.ColumnInt(
      'startMinute',
      this,
    );
    endMinute = _i1.ColumnInt(
      'endMinute',
      this,
    );
    room = _i1.ColumnString(
      'room',
      this,
    );
    campus = _i1.ColumnString(
      'campus',
      this,
    );
    startsAt = _i1.ColumnDateTime(
      'startsAt',
      this,
    );
    endsAt = _i1.ColumnDateTime(
      'endsAt',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
  }

  late final CourseScheduleUpdateTable updateTable;

  late final _i1.ColumnInt offeringId;

  late final _i1.ColumnInt weekday;

  late final _i1.ColumnInt startMinute;

  late final _i1.ColumnInt endMinute;

  late final _i1.ColumnString room;

  late final _i1.ColumnString campus;

  late final _i1.ColumnDateTime startsAt;

  late final _i1.ColumnDateTime endsAt;

  late final _i1.ColumnString status;

  @override
  List<_i1.Column> get columns => [
    id,
    offeringId,
    weekday,
    startMinute,
    endMinute,
    room,
    campus,
    startsAt,
    endsAt,
    status,
  ];
}

class CourseScheduleInclude extends _i1.IncludeObject {
  CourseScheduleInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CourseSchedule.t;
}

class CourseScheduleIncludeList extends _i1.IncludeList {
  CourseScheduleIncludeList._({
    _i1.WhereExpressionBuilder<CourseScheduleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CourseSchedule.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CourseSchedule.t;
}

class CourseScheduleRepository {
  const CourseScheduleRepository._();

  /// Returns a list of [CourseSchedule]s matching the given query parameters.
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
  Future<List<CourseSchedule>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CourseScheduleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseScheduleTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CourseSchedule>(
      where: where?.call(CourseSchedule.t),
      orderBy: orderBy?.call(CourseSchedule.t),
      orderByList: orderByList?.call(CourseSchedule.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CourseSchedule] matching the given query parameters.
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
  Future<CourseSchedule?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CourseScheduleTable>? where,
    int? offset,
    _i1.OrderByBuilder<CourseScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CourseScheduleTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CourseSchedule>(
      where: where?.call(CourseSchedule.t),
      orderBy: orderBy?.call(CourseSchedule.t),
      orderByList: orderByList?.call(CourseSchedule.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CourseSchedule] by its [id] or null if no such row exists.
  Future<CourseSchedule?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CourseSchedule>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CourseSchedule]s in the list and returns the inserted rows.
  ///
  /// The returned [CourseSchedule]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CourseSchedule>> insert(
    _i1.DatabaseSession session,
    List<CourseSchedule> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CourseSchedule>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CourseSchedule] and returns the inserted row.
  ///
  /// The returned [CourseSchedule] will have its `id` field set.
  Future<CourseSchedule> insertRow(
    _i1.DatabaseSession session,
    CourseSchedule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CourseSchedule>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CourseSchedule]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CourseSchedule>> update(
    _i1.DatabaseSession session,
    List<CourseSchedule> rows, {
    _i1.ColumnSelections<CourseScheduleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CourseSchedule>(
      rows,
      columns: columns?.call(CourseSchedule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CourseSchedule]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CourseSchedule> updateRow(
    _i1.DatabaseSession session,
    CourseSchedule row, {
    _i1.ColumnSelections<CourseScheduleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CourseSchedule>(
      row,
      columns: columns?.call(CourseSchedule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CourseSchedule] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CourseSchedule?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CourseScheduleUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CourseSchedule>(
      id,
      columnValues: columnValues(CourseSchedule.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CourseSchedule]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CourseSchedule>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CourseScheduleUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CourseScheduleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CourseScheduleTable>? orderBy,
    _i1.OrderByListBuilder<CourseScheduleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CourseSchedule>(
      columnValues: columnValues(CourseSchedule.t.updateTable),
      where: where(CourseSchedule.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CourseSchedule.t),
      orderByList: orderByList?.call(CourseSchedule.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CourseSchedule]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CourseSchedule>> delete(
    _i1.DatabaseSession session,
    List<CourseSchedule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CourseSchedule>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CourseSchedule].
  Future<CourseSchedule> deleteRow(
    _i1.DatabaseSession session,
    CourseSchedule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CourseSchedule>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CourseSchedule>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CourseScheduleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CourseSchedule>(
      where: where(CourseSchedule.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CourseScheduleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CourseSchedule>(
      where: where?.call(CourseSchedule.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CourseSchedule] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CourseScheduleTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CourseSchedule>(
      where: where(CourseSchedule.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
