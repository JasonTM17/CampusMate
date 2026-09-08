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

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'book_access_type.dart' as _i2;

abstract class LibraryBook implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
