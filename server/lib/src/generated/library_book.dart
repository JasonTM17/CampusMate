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
import 'book_access_type.dart' as _i2;

abstract class LibraryBook
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LibraryBook._({
    this.id,
    required this.title,
    this.subtitle,
    required this.description,
    this.isbn,
    required this.publisher,
    required this.publishedYear,
    required this.language,
    this.coverUrl,
    required this.accessType,
    required this.license,
    this.licenseExpiresAt,
    required this.keywords,
    required this.searchText,
    required this.popularityScore,
    this.featuredRank,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LibraryBook({
    int? id,
    required String title,
    String? subtitle,
    required String description,
    String? isbn,
    required String publisher,
    required int publishedYear,
    required String language,
    String? coverUrl,
    required _i2.BookAccessType accessType,
    required String license,
    DateTime? licenseExpiresAt,
    required String keywords,
    required String searchText,
    required int popularityScore,
    int? featuredRank,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _LibraryBookImpl;

  factory LibraryBook.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryBook(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      subtitle: jsonSerialization['subtitle'] as String?,
      description: jsonSerialization['description'] as String,
      isbn: jsonSerialization['isbn'] as String?,
      publisher: jsonSerialization['publisher'] as String,
      publishedYear: jsonSerialization['publishedYear'] as int,
      language: jsonSerialization['language'] as String,
      coverUrl: jsonSerialization['coverUrl'] as String?,
      accessType: _i2.BookAccessType.fromJson(
        (jsonSerialization['accessType'] as String),
      ),
      license: jsonSerialization['license'] as String,
      licenseExpiresAt: jsonSerialization['licenseExpiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['licenseExpiresAt'],
            ),
      keywords: jsonSerialization['keywords'] as String,
      searchText: jsonSerialization['searchText'] as String,
      popularityScore: jsonSerialization['popularityScore'] as int,
      featuredRank: jsonSerialization['featuredRank'] as int?,
      isActive: _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = LibraryBookTable();

  static const db = LibraryBookRepository._();

  @override
  int? id;

  String title;

  String? subtitle;

  String description;

  String? isbn;

  String publisher;

  int publishedYear;

  String language;

  String? coverUrl;

  _i2.BookAccessType accessType;

  String license;

  DateTime? licenseExpiresAt;

  String keywords;

  String searchText;

  int popularityScore;

  int? featuredRank;

  bool isActive;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LibraryBook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryBook copyWith({
    int? id,
    String? title,
    String? subtitle,
    String? description,
    String? isbn,
    String? publisher,
    int? publishedYear,
    String? language,
    String? coverUrl,
    _i2.BookAccessType? accessType,
    String? license,
    DateTime? licenseExpiresAt,
    String? keywords,
    String? searchText,
    int? popularityScore,
    int? featuredRank,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LibraryBook',
      if (id != null) 'id': id,
      'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      'description': description,
      if (isbn != null) 'isbn': isbn,
      'publisher': publisher,
      'publishedYear': publishedYear,
      'language': language,
      if (coverUrl != null) 'coverUrl': coverUrl,
      'accessType': accessType.toJson(),
      'license': license,
      if (licenseExpiresAt != null)
        'licenseExpiresAt': licenseExpiresAt?.toJson(),
      'keywords': keywords,
      'searchText': searchText,
      'popularityScore': popularityScore,
      if (featuredRank != null) 'featuredRank': featuredRank,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LibraryBook',
      if (id != null) 'id': id,
      'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      'description': description,
      if (isbn != null) 'isbn': isbn,
      'publisher': publisher,
      'publishedYear': publishedYear,
      'language': language,
      if (coverUrl != null) 'coverUrl': coverUrl,
      'accessType': accessType.toJson(),
      'license': license,
      if (licenseExpiresAt != null)
        'licenseExpiresAt': licenseExpiresAt?.toJson(),
      'keywords': keywords,
      'searchText': searchText,
      'popularityScore': popularityScore,
      if (featuredRank != null) 'featuredRank': featuredRank,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static LibraryBookInclude include() {
    return LibraryBookInclude._();
  }

  static LibraryBookIncludeList includeList({
    _i1.WhereExpressionBuilder<LibraryBookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookTable>? orderByList,
    LibraryBookInclude? include,
  }) {
    return LibraryBookIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryBook.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LibraryBook.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LibraryBookImpl extends LibraryBook {
  _LibraryBookImpl({
    int? id,
    required String title,
    String? subtitle,
    required String description,
    String? isbn,
    required String publisher,
    required int publishedYear,
    required String language,
    String? coverUrl,
    required _i2.BookAccessType accessType,
    required String license,
    DateTime? licenseExpiresAt,
    required String keywords,
    required String searchText,
    required int popularityScore,
    int? featuredRank,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         title: title,
         subtitle: subtitle,
         description: description,
         isbn: isbn,
         publisher: publisher,
         publishedYear: publishedYear,
         language: language,
         coverUrl: coverUrl,
         accessType: accessType,
         license: license,
         licenseExpiresAt: licenseExpiresAt,
         keywords: keywords,
         searchText: searchText,
         popularityScore: popularityScore,
         featuredRank: featuredRank,
         isActive: isActive,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [LibraryBook]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryBook copyWith({
    Object? id = _Undefined,
    String? title,
    Object? subtitle = _Undefined,
    String? description,
    Object? isbn = _Undefined,
    String? publisher,
    int? publishedYear,
    String? language,
    Object? coverUrl = _Undefined,
    _i2.BookAccessType? accessType,
    String? license,
    Object? licenseExpiresAt = _Undefined,
    String? keywords,
    String? searchText,
    int? popularityScore,
    Object? featuredRank = _Undefined,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LibraryBook(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      subtitle: subtitle is String? ? subtitle : this.subtitle,
      description: description ?? this.description,
      isbn: isbn is String? ? isbn : this.isbn,
      publisher: publisher ?? this.publisher,
      publishedYear: publishedYear ?? this.publishedYear,
      language: language ?? this.language,
      coverUrl: coverUrl is String? ? coverUrl : this.coverUrl,
      accessType: accessType ?? this.accessType,
      license: license ?? this.license,
      licenseExpiresAt: licenseExpiresAt is DateTime?
          ? licenseExpiresAt
          : this.licenseExpiresAt,
      keywords: keywords ?? this.keywords,
      searchText: searchText ?? this.searchText,
      popularityScore: popularityScore ?? this.popularityScore,
      featuredRank: featuredRank is int? ? featuredRank : this.featuredRank,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class LibraryBookUpdateTable extends _i1.UpdateTable<LibraryBookTable> {
  LibraryBookUpdateTable(super.table);

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> subtitle(String? value) => _i1.ColumnValue(
    table.subtitle,
    value,
  );

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> isbn(String? value) => _i1.ColumnValue(
    table.isbn,
    value,
  );

  _i1.ColumnValue<String, String> publisher(String value) => _i1.ColumnValue(
    table.publisher,
    value,
  );

  _i1.ColumnValue<int, int> publishedYear(int value) => _i1.ColumnValue(
    table.publishedYear,
    value,
  );

  _i1.ColumnValue<String, String> language(String value) => _i1.ColumnValue(
    table.language,
    value,
  );

  _i1.ColumnValue<String, String> coverUrl(String? value) => _i1.ColumnValue(
    table.coverUrl,
    value,
  );

  _i1.ColumnValue<_i2.BookAccessType, _i2.BookAccessType> accessType(
    _i2.BookAccessType value,
  ) => _i1.ColumnValue(
    table.accessType,
    value,
  );

  _i1.ColumnValue<String, String> license(String value) => _i1.ColumnValue(
    table.license,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> licenseExpiresAt(DateTime? value) =>
      _i1.ColumnValue(
        table.licenseExpiresAt,
        value,
      );

  _i1.ColumnValue<String, String> keywords(String value) => _i1.ColumnValue(
    table.keywords,
    value,
  );

  _i1.ColumnValue<String, String> searchText(String value) => _i1.ColumnValue(
    table.searchText,
    value,
  );

  _i1.ColumnValue<int, int> popularityScore(int value) => _i1.ColumnValue(
    table.popularityScore,
    value,
  );

  _i1.ColumnValue<int, int> featuredRank(int? value) => _i1.ColumnValue(
    table.featuredRank,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
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

class LibraryBookTable extends _i1.Table<int?> {
  LibraryBookTable({super.tableRelation}) : super(tableName: 'books') {
    updateTable = LibraryBookUpdateTable(this);
    title = _i1.ColumnString(
      'title',
      this,
    );
    subtitle = _i1.ColumnString(
      'subtitle',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    isbn = _i1.ColumnString(
      'isbn',
      this,
    );
    publisher = _i1.ColumnString(
      'publisher',
      this,
    );
    publishedYear = _i1.ColumnInt(
      'publishedYear',
      this,
    );
    language = _i1.ColumnString(
      'language',
      this,
    );
    coverUrl = _i1.ColumnString(
      'coverUrl',
      this,
    );
    accessType = _i1.ColumnEnum(
      'accessType',
      this,
      _i1.EnumSerialization.byName,
    );
    license = _i1.ColumnString(
      'license',
      this,
    );
    licenseExpiresAt = _i1.ColumnDateTime(
      'licenseExpiresAt',
      this,
    );
    keywords = _i1.ColumnString(
      'keywords',
      this,
    );
    searchText = _i1.ColumnString(
      'searchText',
      this,
    );
    popularityScore = _i1.ColumnInt(
      'popularityScore',
      this,
    );
    featuredRank = _i1.ColumnInt(
      'featuredRank',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
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

  late final LibraryBookUpdateTable updateTable;

  late final _i1.ColumnString title;

  late final _i1.ColumnString subtitle;

  late final _i1.ColumnString description;

  late final _i1.ColumnString isbn;

  late final _i1.ColumnString publisher;

  late final _i1.ColumnInt publishedYear;

  late final _i1.ColumnString language;

  late final _i1.ColumnString coverUrl;

  late final _i1.ColumnEnum<_i2.BookAccessType> accessType;

  late final _i1.ColumnString license;

  late final _i1.ColumnDateTime licenseExpiresAt;

  late final _i1.ColumnString keywords;

  late final _i1.ColumnString searchText;

  late final _i1.ColumnInt popularityScore;

  late final _i1.ColumnInt featuredRank;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    title,
    subtitle,
    description,
    isbn,
    publisher,
    publishedYear,
    language,
    coverUrl,
    accessType,
    license,
    licenseExpiresAt,
    keywords,
    searchText,
    popularityScore,
    featuredRank,
    isActive,
    createdAt,
    updatedAt,
  ];
}

class LibraryBookInclude extends _i1.IncludeObject {
  LibraryBookInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => LibraryBook.t;
}

class LibraryBookIncludeList extends _i1.IncludeList {
  LibraryBookIncludeList._({
    _i1.WhereExpressionBuilder<LibraryBookTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LibraryBook.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LibraryBook.t;
}

class LibraryBookRepository {
  const LibraryBookRepository._();

  /// Returns a list of [LibraryBook]s matching the given query parameters.
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
  Future<List<LibraryBook>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryBookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LibraryBook>(
      where: where?.call(LibraryBook.t),
      orderBy: orderBy?.call(LibraryBook.t),
      orderByList: orderByList?.call(LibraryBook.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LibraryBook] matching the given query parameters.
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
  Future<LibraryBook?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryBookTable>? where,
    int? offset,
    _i1.OrderByBuilder<LibraryBookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LibraryBookTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LibraryBook>(
      where: where?.call(LibraryBook.t),
      orderBy: orderBy?.call(LibraryBook.t),
      orderByList: orderByList?.call(LibraryBook.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LibraryBook] by its [id] or null if no such row exists.
  Future<LibraryBook?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LibraryBook>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LibraryBook]s in the list and returns the inserted rows.
  ///
  /// The returned [LibraryBook]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<LibraryBook>> insert(
    _i1.DatabaseSession session,
    List<LibraryBook> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<LibraryBook>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [LibraryBook] and returns the inserted row.
  ///
  /// The returned [LibraryBook] will have its `id` field set.
  Future<LibraryBook> insertRow(
    _i1.DatabaseSession session,
    LibraryBook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LibraryBook>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LibraryBook]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LibraryBook>> update(
    _i1.DatabaseSession session,
    List<LibraryBook> rows, {
    _i1.ColumnSelections<LibraryBookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LibraryBook>(
      rows,
      columns: columns?.call(LibraryBook.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryBook]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LibraryBook> updateRow(
    _i1.DatabaseSession session,
    LibraryBook row, {
    _i1.ColumnSelections<LibraryBookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LibraryBook>(
      row,
      columns: columns?.call(LibraryBook.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LibraryBook] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LibraryBook?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<LibraryBookUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<LibraryBook>(
      id,
      columnValues: columnValues(LibraryBook.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LibraryBook]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<LibraryBook>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<LibraryBookUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<LibraryBookTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LibraryBookTable>? orderBy,
    _i1.OrderByListBuilder<LibraryBookTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<LibraryBook>(
      columnValues: columnValues(LibraryBook.t.updateTable),
      where: where(LibraryBook.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LibraryBook.t),
      orderByList: orderByList?.call(LibraryBook.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [LibraryBook]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LibraryBook>> delete(
    _i1.DatabaseSession session,
    List<LibraryBook> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LibraryBook>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LibraryBook].
  Future<LibraryBook> deleteRow(
    _i1.DatabaseSession session,
    LibraryBook row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LibraryBook>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LibraryBook>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LibraryBookTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LibraryBook>(
      where: where(LibraryBook.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LibraryBookTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LibraryBook>(
      where: where?.call(LibraryBook.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LibraryBook] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LibraryBookTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LibraryBook>(
      where: where(LibraryBook.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
