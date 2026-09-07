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

abstract class GradeComponent
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  GradeComponent._({
    this.id,
    required this.offeringId,
    required this.name,
    required this.weight,
    required this.maxScore,
  });

  factory GradeComponent({
    int? id,
    required int offeringId,
    required String name,
    required double weight,
    required double maxScore,
  }) = _GradeComponentImpl;

  factory GradeComponent.fromJson(Map<String, dynamic> jsonSerialization) {
    return GradeComponent(
      id: jsonSerialization['id'] as int?,
      offeringId: jsonSerialization['offeringId'] as int,
      name: jsonSerialization['name'] as String,
      weight: (jsonSerialization['weight'] as num).toDouble(),
      maxScore: (jsonSerialization['maxScore'] as num).toDouble(),
    );
  }

  static final t = GradeComponentTable();

  static const db = GradeComponentRepository._();

  @override
  int? id;

  int offeringId;

  String name;

  double weight;

  double maxScore;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [GradeComponent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GradeComponent copyWith({
    int? id,
    int? offeringId,
    String? name,
    double? weight,
    double? maxScore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GradeComponent',
      if (id != null) 'id': id,
      'offeringId': offeringId,
      'name': name,
      'weight': weight,
      'maxScore': maxScore,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GradeComponent',
      if (id != null) 'id': id,
      'offeringId': offeringId,
      'name': name,
      'weight': weight,
      'maxScore': maxScore,
    };
  }

  static GradeComponentInclude include() {
    return GradeComponentInclude._();
  }

  static GradeComponentIncludeList includeList({
    _i1.WhereExpressionBuilder<GradeComponentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GradeComponentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GradeComponentTable>? orderByList,
    GradeComponentInclude? include,
  }) {
    return GradeComponentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GradeComponent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(GradeComponent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GradeComponentImpl extends GradeComponent {
  _GradeComponentImpl({
    int? id,
    required int offeringId,
    required String name,
    required double weight,
    required double maxScore,
  }) : super._(
         id: id,
         offeringId: offeringId,
         name: name,
         weight: weight,
         maxScore: maxScore,
       );

  /// Returns a shallow copy of this [GradeComponent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GradeComponent copyWith({
    Object? id = _Undefined,
    int? offeringId,
    String? name,
    double? weight,
    double? maxScore,
  }) {
    return GradeComponent(
      id: id is int? ? id : this.id,
      offeringId: offeringId ?? this.offeringId,
      name: name ?? this.name,
      weight: weight ?? this.weight,
      maxScore: maxScore ?? this.maxScore,
    );
  }
}

class GradeComponentUpdateTable extends _i1.UpdateTable<GradeComponentTable> {
  GradeComponentUpdateTable(super.table);

  _i1.ColumnValue<int, int> offeringId(int value) => _i1.ColumnValue(
    table.offeringId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<double, double> weight(double value) => _i1.ColumnValue(
    table.weight,
    value,
  );

  _i1.ColumnValue<double, double> maxScore(double value) => _i1.ColumnValue(
    table.maxScore,
    value,
  );
}

class GradeComponentTable extends _i1.Table<int?> {
  GradeComponentTable({super.tableRelation})
    : super(tableName: 'grade_components') {
    updateTable = GradeComponentUpdateTable(this);
    offeringId = _i1.ColumnInt(
      'offeringId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    weight = _i1.ColumnDouble(
      'weight',
      this,
    );
    maxScore = _i1.ColumnDouble(
      'maxScore',
      this,
    );
  }

  late final GradeComponentUpdateTable updateTable;

  late final _i1.ColumnInt offeringId;

  late final _i1.ColumnString name;

  late final _i1.ColumnDouble weight;

  late final _i1.ColumnDouble maxScore;

  @override
  List<_i1.Column> get columns => [
    id,
    offeringId,
    name,
    weight,
    maxScore,
  ];
}

class GradeComponentInclude extends _i1.IncludeObject {
  GradeComponentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => GradeComponent.t;
}

class GradeComponentIncludeList extends _i1.IncludeList {
  GradeComponentIncludeList._({
    _i1.WhereExpressionBuilder<GradeComponentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(GradeComponent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => GradeComponent.t;
}

class GradeComponentRepository {
  const GradeComponentRepository._();

  /// Returns a list of [GradeComponent]s matching the given query parameters.
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
  Future<List<GradeComponent>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<GradeComponentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GradeComponentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GradeComponentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<GradeComponent>(
      where: where?.call(GradeComponent.t),
      orderBy: orderBy?.call(GradeComponent.t),
      orderByList: orderByList?.call(GradeComponent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [GradeComponent] matching the given query parameters.
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
  Future<GradeComponent?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<GradeComponentTable>? where,
    int? offset,
    _i1.OrderByBuilder<GradeComponentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GradeComponentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<GradeComponent>(
      where: where?.call(GradeComponent.t),
      orderBy: orderBy?.call(GradeComponent.t),
      orderByList: orderByList?.call(GradeComponent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [GradeComponent] by its [id] or null if no such row exists.
  Future<GradeComponent?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<GradeComponent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [GradeComponent]s in the list and returns the inserted rows.
  ///
  /// The returned [GradeComponent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<GradeComponent>> insert(
    _i1.DatabaseSession session,
    List<GradeComponent> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<GradeComponent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [GradeComponent] and returns the inserted row.
  ///
  /// The returned [GradeComponent] will have its `id` field set.
  Future<GradeComponent> insertRow(
    _i1.DatabaseSession session,
    GradeComponent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<GradeComponent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [GradeComponent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<GradeComponent>> update(
    _i1.DatabaseSession session,
    List<GradeComponent> rows, {
    _i1.ColumnSelections<GradeComponentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<GradeComponent>(
      rows,
      columns: columns?.call(GradeComponent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GradeComponent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<GradeComponent> updateRow(
    _i1.DatabaseSession session,
    GradeComponent row, {
    _i1.ColumnSelections<GradeComponentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<GradeComponent>(
      row,
      columns: columns?.call(GradeComponent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GradeComponent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<GradeComponent?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<GradeComponentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<GradeComponent>(
      id,
      columnValues: columnValues(GradeComponent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [GradeComponent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<GradeComponent>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<GradeComponentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<GradeComponentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GradeComponentTable>? orderBy,
    _i1.OrderByListBuilder<GradeComponentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<GradeComponent>(
      columnValues: columnValues(GradeComponent.t.updateTable),
      where: where(GradeComponent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GradeComponent.t),
      orderByList: orderByList?.call(GradeComponent.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [GradeComponent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<GradeComponent>> delete(
    _i1.DatabaseSession session,
    List<GradeComponent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<GradeComponent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [GradeComponent].
  Future<GradeComponent> deleteRow(
    _i1.DatabaseSession session,
    GradeComponent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<GradeComponent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<GradeComponent>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<GradeComponentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<GradeComponent>(
      where: where(GradeComponent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<GradeComponentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<GradeComponent>(
      where: where?.call(GradeComponent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [GradeComponent] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<GradeComponentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<GradeComponent>(
      where: where(GradeComponent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
