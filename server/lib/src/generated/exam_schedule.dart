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

abstract class ExamSchedule
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ExamSchedule._({
    this.id,
    required this.offeringId,
    required this.examType,
    required this.startsAt,
    required this.endsAt,
    required this.room,
    this.notes,
  });

  factory ExamSchedule({
    int? id,
    required int offeringId,
    required String examType,
    required DateTime startsAt,
    required DateTime endsAt,
    required String room,
    String? notes,
  }) = _ExamScheduleImpl;

  factory ExamSchedule.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExamSchedule(
      id: jsonSerialization['id'] as int?,
      offeringId: jsonSerialization['offeringId'] as int,
      examType: jsonSerialization['examType'] as String,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      room: jsonSerialization['room'] as String,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  static final t = ExamScheduleTable();

  static const db = ExamScheduleRepository._();

  @override
  int? id;

  int offeringId;

  String examType;

  DateTime startsAt;

  DateTime endsAt;

  String room;

  String? notes;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ExamSchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExamSchedule copyWith({
    int? id,
    int? offeringId,
    String? examType,
    DateTime? startsAt,
    DateTime? endsAt,
    String? room,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExamSchedule',
      if (id != null) 'id': id,
      'offeringId': offeringId,
      'examType': examType,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'room': room,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExamSchedule',
      if (id != null) 'id': id,
      'offeringId': offeringId,
      'examType': examType,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'room': room,
      if (notes != null) 'notes': notes,
    };
  }

  static ExamScheduleInclude include() {
    return ExamScheduleInclude._();
  }

  static ExamScheduleIncludeList includeList({
    _i1.WhereExpressionBuilder<ExamScheduleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExamScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExamScheduleTable>? orderByList,
    ExamScheduleInclude? include,
  }) {
    return ExamScheduleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExamSchedule.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ExamSchedule.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExamScheduleImpl extends ExamSchedule {
  _ExamScheduleImpl({
    int? id,
    required int offeringId,
    required String examType,
    required DateTime startsAt,
    required DateTime endsAt,
    required String room,
    String? notes,
  }) : super._(
         id: id,
         offeringId: offeringId,
         examType: examType,
         startsAt: startsAt,
         endsAt: endsAt,
         room: room,
         notes: notes,
       );

  /// Returns a shallow copy of this [ExamSchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExamSchedule copyWith({
    Object? id = _Undefined,
    int? offeringId,
    String? examType,
    DateTime? startsAt,
    DateTime? endsAt,
    String? room,
    Object? notes = _Undefined,
  }) {
    return ExamSchedule(
      id: id is int? ? id : this.id,
      offeringId: offeringId ?? this.offeringId,
      examType: examType ?? this.examType,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      room: room ?? this.room,
      notes: notes is String? ? notes : this.notes,
    );
  }
}

class ExamScheduleUpdateTable extends _i1.UpdateTable<ExamScheduleTable> {
  ExamScheduleUpdateTable(super.table);

  _i1.ColumnValue<int, int> offeringId(int value) => _i1.ColumnValue(
    table.offeringId,
    value,
  );

  _i1.ColumnValue<String, String> examType(String value) => _i1.ColumnValue(
    table.examType,
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

  _i1.ColumnValue<String, String> room(String value) => _i1.ColumnValue(
    table.room,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );
}

class ExamScheduleTable extends _i1.Table<int?> {
  ExamScheduleTable({super.tableRelation})
    : super(tableName: 'exam_schedules') {
    updateTable = ExamScheduleUpdateTable(this);
    offeringId = _i1.ColumnInt(
      'offeringId',
      this,
    );
    examType = _i1.ColumnString(
      'examType',
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
    room = _i1.ColumnString(
      'room',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
  }

  late final ExamScheduleUpdateTable updateTable;

  late final _i1.ColumnInt offeringId;

  late final _i1.ColumnString examType;

  late final _i1.ColumnDateTime startsAt;

  late final _i1.ColumnDateTime endsAt;

  late final _i1.ColumnString room;

  late final _i1.ColumnString notes;

  @override
  List<_i1.Column> get columns => [
    id,
    offeringId,
    examType,
    startsAt,
    endsAt,
    room,
    notes,
  ];
}

class ExamScheduleInclude extends _i1.IncludeObject {
  ExamScheduleInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ExamSchedule.t;
}

class ExamScheduleIncludeList extends _i1.IncludeList {
  ExamScheduleIncludeList._({
    _i1.WhereExpressionBuilder<ExamScheduleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ExamSchedule.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ExamSchedule.t;
}

class ExamScheduleRepository {
  const ExamScheduleRepository._();

  /// Returns a list of [ExamSchedule]s matching the given query parameters.
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
  Future<List<ExamSchedule>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ExamScheduleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExamScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExamScheduleTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ExamSchedule>(
      where: where?.call(ExamSchedule.t),
      orderBy: orderBy?.call(ExamSchedule.t),
      orderByList: orderByList?.call(ExamSchedule.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ExamSchedule] matching the given query parameters.
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
  Future<ExamSchedule?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ExamScheduleTable>? where,
    int? offset,
    _i1.OrderByBuilder<ExamScheduleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExamScheduleTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ExamSchedule>(
      where: where?.call(ExamSchedule.t),
      orderBy: orderBy?.call(ExamSchedule.t),
      orderByList: orderByList?.call(ExamSchedule.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ExamSchedule] by its [id] or null if no such row exists.
  Future<ExamSchedule?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ExamSchedule>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ExamSchedule]s in the list and returns the inserted rows.
  ///
  /// The returned [ExamSchedule]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ExamSchedule>> insert(
    _i1.DatabaseSession session,
    List<ExamSchedule> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ExamSchedule>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ExamSchedule] and returns the inserted row.
  ///
  /// The returned [ExamSchedule] will have its `id` field set.
  Future<ExamSchedule> insertRow(
    _i1.DatabaseSession session,
    ExamSchedule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ExamSchedule>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ExamSchedule]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ExamSchedule>> update(
    _i1.DatabaseSession session,
    List<ExamSchedule> rows, {
    _i1.ColumnSelections<ExamScheduleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ExamSchedule>(
      rows,
      columns: columns?.call(ExamSchedule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExamSchedule]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ExamSchedule> updateRow(
    _i1.DatabaseSession session,
    ExamSchedule row, {
    _i1.ColumnSelections<ExamScheduleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ExamSchedule>(
      row,
      columns: columns?.call(ExamSchedule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExamSchedule] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ExamSchedule?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ExamScheduleUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ExamSchedule>(
      id,
      columnValues: columnValues(ExamSchedule.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ExamSchedule]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ExamSchedule>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ExamScheduleUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ExamScheduleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExamScheduleTable>? orderBy,
    _i1.OrderByListBuilder<ExamScheduleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ExamSchedule>(
      columnValues: columnValues(ExamSchedule.t.updateTable),
      where: where(ExamSchedule.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExamSchedule.t),
      orderByList: orderByList?.call(ExamSchedule.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ExamSchedule]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ExamSchedule>> delete(
    _i1.DatabaseSession session,
    List<ExamSchedule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ExamSchedule>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ExamSchedule].
  Future<ExamSchedule> deleteRow(
    _i1.DatabaseSession session,
    ExamSchedule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ExamSchedule>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ExamSchedule>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ExamScheduleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ExamSchedule>(
      where: where(ExamSchedule.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ExamScheduleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ExamSchedule>(
      where: where?.call(ExamSchedule.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ExamSchedule] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ExamScheduleTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ExamSchedule>(
      where: where(ExamSchedule.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
