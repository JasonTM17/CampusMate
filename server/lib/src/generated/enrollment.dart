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

abstract class Enrollment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Enrollment._({
    this.id,
    required this.studentProfileId,
    required this.offeringId,
    required this.status,
    required this.progressPercent,
    required this.attendancePercent,
  });

  factory Enrollment({
    int? id,
    required int studentProfileId,
    required int offeringId,
    required String status,
    required double progressPercent,
    required double attendancePercent,
  }) = _EnrollmentImpl;

  factory Enrollment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Enrollment(
      id: jsonSerialization['id'] as int?,
      studentProfileId: jsonSerialization['studentProfileId'] as int,
      offeringId: jsonSerialization['offeringId'] as int,
      status: jsonSerialization['status'] as String,
      progressPercent: (jsonSerialization['progressPercent'] as num).toDouble(),
      attendancePercent: (jsonSerialization['attendancePercent'] as num)
          .toDouble(),
    );
  }

  static final t = EnrollmentTable();

  static const db = EnrollmentRepository._();

  @override
  int? id;

  int studentProfileId;

  int offeringId;

  String status;

  double progressPercent;

  double attendancePercent;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Enrollment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Enrollment copyWith({
    int? id,
    int? studentProfileId,
    int? offeringId,
    String? status,
    double? progressPercent,
    double? attendancePercent,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Enrollment',
      if (id != null) 'id': id,
      'studentProfileId': studentProfileId,
      'offeringId': offeringId,
      'status': status,
      'progressPercent': progressPercent,
      'attendancePercent': attendancePercent,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Enrollment',
      if (id != null) 'id': id,
      'studentProfileId': studentProfileId,
      'offeringId': offeringId,
      'status': status,
      'progressPercent': progressPercent,
      'attendancePercent': attendancePercent,
    };
  }

  static EnrollmentInclude include() {
    return EnrollmentInclude._();
  }

  static EnrollmentIncludeList includeList({
    _i1.WhereExpressionBuilder<EnrollmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EnrollmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EnrollmentTable>? orderByList,
    EnrollmentInclude? include,
  }) {
    return EnrollmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Enrollment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Enrollment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EnrollmentImpl extends Enrollment {
  _EnrollmentImpl({
    int? id,
    required int studentProfileId,
    required int offeringId,
    required String status,
    required double progressPercent,
    required double attendancePercent,
  }) : super._(
         id: id,
         studentProfileId: studentProfileId,
         offeringId: offeringId,
         status: status,
         progressPercent: progressPercent,
         attendancePercent: attendancePercent,
       );

  /// Returns a shallow copy of this [Enrollment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Enrollment copyWith({
    Object? id = _Undefined,
    int? studentProfileId,
    int? offeringId,
    String? status,
    double? progressPercent,
    double? attendancePercent,
  }) {
    return Enrollment(
      id: id is int? ? id : this.id,
      studentProfileId: studentProfileId ?? this.studentProfileId,
      offeringId: offeringId ?? this.offeringId,
      status: status ?? this.status,
      progressPercent: progressPercent ?? this.progressPercent,
      attendancePercent: attendancePercent ?? this.attendancePercent,
    );
  }
}

class EnrollmentUpdateTable extends _i1.UpdateTable<EnrollmentTable> {
  EnrollmentUpdateTable(super.table);

  _i1.ColumnValue<int, int> studentProfileId(int value) => _i1.ColumnValue(
    table.studentProfileId,
    value,
  );

  _i1.ColumnValue<int, int> offeringId(int value) => _i1.ColumnValue(
    table.offeringId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<double, double> progressPercent(double value) =>
      _i1.ColumnValue(
        table.progressPercent,
        value,
      );

  _i1.ColumnValue<double, double> attendancePercent(double value) =>
      _i1.ColumnValue(
        table.attendancePercent,
        value,
      );
}

class EnrollmentTable extends _i1.Table<int?> {
  EnrollmentTable({super.tableRelation}) : super(tableName: 'enrollments') {
    updateTable = EnrollmentUpdateTable(this);
    studentProfileId = _i1.ColumnInt(
      'studentProfileId',
      this,
    );
    offeringId = _i1.ColumnInt(
      'offeringId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    progressPercent = _i1.ColumnDouble(
      'progressPercent',
      this,
    );
    attendancePercent = _i1.ColumnDouble(
      'attendancePercent',
      this,
    );
  }

  late final EnrollmentUpdateTable updateTable;

  late final _i1.ColumnInt studentProfileId;

  late final _i1.ColumnInt offeringId;

  late final _i1.ColumnString status;

  late final _i1.ColumnDouble progressPercent;

  late final _i1.ColumnDouble attendancePercent;

  @override
  List<_i1.Column> get columns => [
    id,
    studentProfileId,
    offeringId,
    status,
    progressPercent,
    attendancePercent,
  ];
}

class EnrollmentInclude extends _i1.IncludeObject {
  EnrollmentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Enrollment.t;
}

class EnrollmentIncludeList extends _i1.IncludeList {
  EnrollmentIncludeList._({
    _i1.WhereExpressionBuilder<EnrollmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Enrollment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Enrollment.t;
}

class EnrollmentRepository {
  const EnrollmentRepository._();

  /// Returns a list of [Enrollment]s matching the given query parameters.
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
  Future<List<Enrollment>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EnrollmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EnrollmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EnrollmentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Enrollment>(
      where: where?.call(Enrollment.t),
      orderBy: orderBy?.call(Enrollment.t),
      orderByList: orderByList?.call(Enrollment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Enrollment] matching the given query parameters.
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
  Future<Enrollment?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EnrollmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<EnrollmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EnrollmentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Enrollment>(
      where: where?.call(Enrollment.t),
      orderBy: orderBy?.call(Enrollment.t),
      orderByList: orderByList?.call(Enrollment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Enrollment] by its [id] or null if no such row exists.
  Future<Enrollment?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Enrollment>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Enrollment]s in the list and returns the inserted rows.
  ///
  /// The returned [Enrollment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Enrollment>> insert(
    _i1.DatabaseSession session,
    List<Enrollment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Enrollment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Enrollment] and returns the inserted row.
  ///
  /// The returned [Enrollment] will have its `id` field set.
  Future<Enrollment> insertRow(
    _i1.DatabaseSession session,
    Enrollment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Enrollment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Enrollment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Enrollment>> update(
    _i1.DatabaseSession session,
    List<Enrollment> rows, {
    _i1.ColumnSelections<EnrollmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Enrollment>(
      rows,
      columns: columns?.call(Enrollment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Enrollment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Enrollment> updateRow(
    _i1.DatabaseSession session,
    Enrollment row, {
    _i1.ColumnSelections<EnrollmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Enrollment>(
      row,
      columns: columns?.call(Enrollment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Enrollment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Enrollment?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<EnrollmentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Enrollment>(
      id,
      columnValues: columnValues(Enrollment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Enrollment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Enrollment>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<EnrollmentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<EnrollmentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EnrollmentTable>? orderBy,
    _i1.OrderByListBuilder<EnrollmentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Enrollment>(
      columnValues: columnValues(Enrollment.t.updateTable),
      where: where(Enrollment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Enrollment.t),
      orderByList: orderByList?.call(Enrollment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Enrollment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Enrollment>> delete(
    _i1.DatabaseSession session,
    List<Enrollment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Enrollment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Enrollment].
  Future<Enrollment> deleteRow(
    _i1.DatabaseSession session,
    Enrollment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Enrollment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Enrollment>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EnrollmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Enrollment>(
      where: where(Enrollment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EnrollmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Enrollment>(
      where: where?.call(Enrollment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Enrollment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EnrollmentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Enrollment>(
      where: where(Enrollment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
