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

abstract class VectorCapabilityProbe
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  VectorCapabilityProbe._({
    this.id,
    required this.embedding,
  });

  factory VectorCapabilityProbe({
    int? id,
    required _i1.Vector embedding,
  }) = _VectorCapabilityProbeImpl;

  factory VectorCapabilityProbe.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return VectorCapabilityProbe(
      id: jsonSerialization['id'] as int?,
      embedding: _i1.VectorJsonExtension.fromJson(
        jsonSerialization['embedding'],
      ),
    );
  }

  static final t = VectorCapabilityProbeTable();

  static const db = VectorCapabilityProbeRepository._();

  @override
  int? id;

  _i1.Vector embedding;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [VectorCapabilityProbe]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VectorCapabilityProbe copyWith({
    int? id,
    _i1.Vector? embedding,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VectorCapabilityProbe',
      if (id != null) 'id': id,
      'embedding': embedding.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VectorCapabilityProbe',
      if (id != null) 'id': id,
      'embedding': embedding.toJson(),
    };
  }

  static VectorCapabilityProbeInclude include() {
    return VectorCapabilityProbeInclude._();
  }

  static VectorCapabilityProbeIncludeList includeList({
    _i1.WhereExpressionBuilder<VectorCapabilityProbeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VectorCapabilityProbeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VectorCapabilityProbeTable>? orderByList,
    VectorCapabilityProbeInclude? include,
  }) {
    return VectorCapabilityProbeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VectorCapabilityProbe.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(VectorCapabilityProbe.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VectorCapabilityProbeImpl extends VectorCapabilityProbe {
  _VectorCapabilityProbeImpl({
    int? id,
    required _i1.Vector embedding,
  }) : super._(
         id: id,
         embedding: embedding,
       );

  /// Returns a shallow copy of this [VectorCapabilityProbe]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VectorCapabilityProbe copyWith({
    Object? id = _Undefined,
    _i1.Vector? embedding,
  }) {
    return VectorCapabilityProbe(
      id: id is int? ? id : this.id,
      embedding: embedding ?? this.embedding.clone(),
    );
  }
}

class VectorCapabilityProbeUpdateTable
    extends _i1.UpdateTable<VectorCapabilityProbeTable> {
  VectorCapabilityProbeUpdateTable(super.table);

  _i1.ColumnValue<_i1.Vector, _i1.Vector> embedding(_i1.Vector value) =>
      _i1.ColumnValue(
        table.embedding,
        value,
      );
}

class VectorCapabilityProbeTable extends _i1.Table<int?> {
  VectorCapabilityProbeTable({super.tableRelation})
    : super(tableName: 'vector_capability_probe') {
    updateTable = VectorCapabilityProbeUpdateTable(this);
    embedding = _i1.ColumnVector(
      'embedding',
      this,
      dimension: 1536,
    );
  }

  late final VectorCapabilityProbeUpdateTable updateTable;

  late final _i1.ColumnVector embedding;

  @override
  List<_i1.Column> get columns => [
    id,
    embedding,
  ];
}

class VectorCapabilityProbeInclude extends _i1.IncludeObject {
  VectorCapabilityProbeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => VectorCapabilityProbe.t;
}

class VectorCapabilityProbeIncludeList extends _i1.IncludeList {
  VectorCapabilityProbeIncludeList._({
    _i1.WhereExpressionBuilder<VectorCapabilityProbeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VectorCapabilityProbe.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => VectorCapabilityProbe.t;
}

class VectorCapabilityProbeRepository {
  const VectorCapabilityProbeRepository._();

  /// Returns a list of [VectorCapabilityProbe]s matching the given query parameters.
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
  Future<List<VectorCapabilityProbe>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VectorCapabilityProbeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VectorCapabilityProbeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VectorCapabilityProbeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VectorCapabilityProbe>(
      where: where?.call(VectorCapabilityProbe.t),
      orderBy: orderBy?.call(VectorCapabilityProbe.t),
      orderByList: orderByList?.call(VectorCapabilityProbe.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VectorCapabilityProbe] matching the given query parameters.
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
  Future<VectorCapabilityProbe?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VectorCapabilityProbeTable>? where,
    int? offset,
    _i1.OrderByBuilder<VectorCapabilityProbeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VectorCapabilityProbeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VectorCapabilityProbe>(
      where: where?.call(VectorCapabilityProbe.t),
      orderBy: orderBy?.call(VectorCapabilityProbe.t),
      orderByList: orderByList?.call(VectorCapabilityProbe.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VectorCapabilityProbe] by its [id] or null if no such row exists.
  Future<VectorCapabilityProbe?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VectorCapabilityProbe>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VectorCapabilityProbe]s in the list and returns the inserted rows.
  ///
  /// The returned [VectorCapabilityProbe]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<VectorCapabilityProbe>> insert(
    _i1.DatabaseSession session,
    List<VectorCapabilityProbe> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<VectorCapabilityProbe>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [VectorCapabilityProbe] and returns the inserted row.
  ///
  /// The returned [VectorCapabilityProbe] will have its `id` field set.
  Future<VectorCapabilityProbe> insertRow(
    _i1.DatabaseSession session,
    VectorCapabilityProbe row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<VectorCapabilityProbe>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [VectorCapabilityProbe]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<VectorCapabilityProbe>> update(
    _i1.DatabaseSession session,
    List<VectorCapabilityProbe> rows, {
    _i1.ColumnSelections<VectorCapabilityProbeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<VectorCapabilityProbe>(
      rows,
      columns: columns?.call(VectorCapabilityProbe.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VectorCapabilityProbe]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VectorCapabilityProbe> updateRow(
    _i1.DatabaseSession session,
    VectorCapabilityProbe row, {
    _i1.ColumnSelections<VectorCapabilityProbeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<VectorCapabilityProbe>(
      row,
      columns: columns?.call(VectorCapabilityProbe.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VectorCapabilityProbe] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VectorCapabilityProbe?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<VectorCapabilityProbeUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<VectorCapabilityProbe>(
      id,
      columnValues: columnValues(VectorCapabilityProbe.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VectorCapabilityProbe]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<VectorCapabilityProbe>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<VectorCapabilityProbeUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<VectorCapabilityProbeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VectorCapabilityProbeTable>? orderBy,
    _i1.OrderByListBuilder<VectorCapabilityProbeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<VectorCapabilityProbe>(
      columnValues: columnValues(VectorCapabilityProbe.t.updateTable),
      where: where(VectorCapabilityProbe.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VectorCapabilityProbe.t),
      orderByList: orderByList?.call(VectorCapabilityProbe.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [VectorCapabilityProbe]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<VectorCapabilityProbe>> delete(
    _i1.DatabaseSession session,
    List<VectorCapabilityProbe> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<VectorCapabilityProbe>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [VectorCapabilityProbe].
  Future<VectorCapabilityProbe> deleteRow(
    _i1.DatabaseSession session,
    VectorCapabilityProbe row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VectorCapabilityProbe>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<VectorCapabilityProbe>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VectorCapabilityProbeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<VectorCapabilityProbe>(
      where: where(VectorCapabilityProbe.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VectorCapabilityProbeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<VectorCapabilityProbe>(
      where: where?.call(VectorCapabilityProbe.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VectorCapabilityProbe] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VectorCapabilityProbeTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VectorCapabilityProbe>(
      where: where(VectorCapabilityProbe.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
