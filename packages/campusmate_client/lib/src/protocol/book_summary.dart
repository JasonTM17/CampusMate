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
import 'book_access_decision.dart' as _i3;
import 'package:campusmate_client/src/protocol/protocol.dart' as _i4;

abstract class BookSummary implements _i1.SerializableModel {
  BookSummary._({
    required this.id,
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
    required this.authors,
    required this.categories,
    required this.courseCodes,
    required this.availableFormats,
    required this.isFavorite,
    required this.access,
  });

  factory BookSummary({
    required int id,
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
    required List<String> authors,
    required List<String> categories,
    required List<String> courseCodes,
    required List<String> availableFormats,
    required bool isFavorite,
    required _i3.BookAccessDecision access,
  }) = _BookSummaryImpl;

  factory BookSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookSummary(
      id: jsonSerialization['id'] as int,
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
      authors: _i4.Protocol().deserialize<List<String>>(
        jsonSerialization['authors'],
      ),
      categories: _i4.Protocol().deserialize<List<String>>(
        jsonSerialization['categories'],
      ),
      courseCodes: _i4.Protocol().deserialize<List<String>>(
        jsonSerialization['courseCodes'],
      ),
      availableFormats: _i4.Protocol().deserialize<List<String>>(
        jsonSerialization['availableFormats'],
      ),
      isFavorite: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isFavorite'],
      ),
      access: _i4.Protocol().deserialize<_i3.BookAccessDecision>(
        jsonSerialization['access'],
      ),
    );
  }

  int id;

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

  List<String> authors;

  List<String> categories;

  List<String> courseCodes;

  List<String> availableFormats;

  bool isFavorite;

  _i3.BookAccessDecision access;

  /// Returns a shallow copy of this [BookSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookSummary copyWith({
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
    List<String>? authors,
    List<String>? categories,
    List<String>? courseCodes,
    List<String>? availableFormats,
    bool? isFavorite,
    _i3.BookAccessDecision? access,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookSummary',
      'id': id,
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
      'authors': authors.toJson(),
      'categories': categories.toJson(),
      'courseCodes': courseCodes.toJson(),
      'availableFormats': availableFormats.toJson(),
      'isFavorite': isFavorite,
      'access': access.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookSummaryImpl extends BookSummary {
  _BookSummaryImpl({
    required int id,
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
    required List<String> authors,
    required List<String> categories,
    required List<String> courseCodes,
    required List<String> availableFormats,
    required bool isFavorite,
    required _i3.BookAccessDecision access,
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
         authors: authors,
         categories: categories,
         courseCodes: courseCodes,
         availableFormats: availableFormats,
         isFavorite: isFavorite,
         access: access,
       );

  /// Returns a shallow copy of this [BookSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookSummary copyWith({
    int? id,
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
    List<String>? authors,
    List<String>? categories,
    List<String>? courseCodes,
    List<String>? availableFormats,
    bool? isFavorite,
    _i3.BookAccessDecision? access,
  }) {
    return BookSummary(
      id: id ?? this.id,
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
      authors: authors ?? this.authors.map((e0) => e0).toList(),
      categories: categories ?? this.categories.map((e0) => e0).toList(),
      courseCodes: courseCodes ?? this.courseCodes.map((e0) => e0).toList(),
      availableFormats:
          availableFormats ?? this.availableFormats.map((e0) => e0).toList(),
      isFavorite: isFavorite ?? this.isFavorite,
      access: access ?? this.access.copyWith(),
    );
  }
}
