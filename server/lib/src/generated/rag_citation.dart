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

abstract class RagCitation
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  RagCitation._({
    required this.documentId,
    this.chunkId,
    this.bookId,
    required this.title,
    this.chapter,
    this.page,
    this.quote,
  });

  factory RagCitation({
    required int documentId,
    int? chunkId,
    int? bookId,
    required String title,
    String? chapter,
    int? page,
    String? quote,
  }) = _RagCitationImpl;

  factory RagCitation.fromJson(Map<String, dynamic> jsonSerialization) {
    return RagCitation(
      documentId: jsonSerialization['documentId'] as int,
      chunkId: jsonSerialization['chunkId'] as int?,
      bookId: jsonSerialization['bookId'] as int?,
      title: jsonSerialization['title'] as String,
      chapter: jsonSerialization['chapter'] as String?,
      page: jsonSerialization['page'] as int?,
      quote: jsonSerialization['quote'] as String?,
    );
  }

  int documentId;

  int? chunkId;

  int? bookId;

  String title;

  String? chapter;

  int? page;

  String? quote;

  /// Returns a shallow copy of this [RagCitation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RagCitation copyWith({
    int? documentId,
    int? chunkId,
    int? bookId,
    String? title,
    String? chapter,
    int? page,
    String? quote,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RagCitation',
      'documentId': documentId,
      if (chunkId != null) 'chunkId': chunkId,
      if (bookId != null) 'bookId': bookId,
      'title': title,
      if (chapter != null) 'chapter': chapter,
      if (page != null) 'page': page,
      if (quote != null) 'quote': quote,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RagCitation',
      'documentId': documentId,
      if (chunkId != null) 'chunkId': chunkId,
      if (bookId != null) 'bookId': bookId,
      'title': title,
      if (chapter != null) 'chapter': chapter,
      if (page != null) 'page': page,
      if (quote != null) 'quote': quote,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RagCitationImpl extends RagCitation {
  _RagCitationImpl({
    required int documentId,
    int? chunkId,
    int? bookId,
    required String title,
    String? chapter,
    int? page,
    String? quote,
  }) : super._(
         documentId: documentId,
         chunkId: chunkId,
         bookId: bookId,
         title: title,
         chapter: chapter,
         page: page,
         quote: quote,
       );

  /// Returns a shallow copy of this [RagCitation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RagCitation copyWith({
    int? documentId,
    Object? chunkId = _Undefined,
    Object? bookId = _Undefined,
    String? title,
    Object? chapter = _Undefined,
    Object? page = _Undefined,
    Object? quote = _Undefined,
  }) {
    return RagCitation(
      documentId: documentId ?? this.documentId,
      chunkId: chunkId is int? ? chunkId : this.chunkId,
      bookId: bookId is int? ? bookId : this.bookId,
      title: title ?? this.title,
      chapter: chapter is String? ? chapter : this.chapter,
      page: page is int? ? page : this.page,
      quote: quote is String? ? quote : this.quote,
    );
  }
}
