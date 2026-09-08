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
import 'package:campusmate_server/src/generated/protocol.dart' as _i3;

abstract class LibraryFilterOptions
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  LibraryFilterOptions._({
    required this.languages,
    required this.categories,
    required this.authors,
    required this.years,
    required this.accessTypes,
    required this.formats,
  });

  factory LibraryFilterOptions({
    required List<String> languages,
    required List<String> categories,
    required List<String> authors,
    required List<int> years,
    required List<_i2.BookAccessType> accessTypes,
    required List<String> formats,
  }) = _LibraryFilterOptionsImpl;

  factory LibraryFilterOptions.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return LibraryFilterOptions(
      languages: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['languages'],
      ),
      categories: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['categories'],
      ),
      authors: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['authors'],
      ),
      years: _i3.Protocol().deserialize<List<int>>(jsonSerialization['years']),
      accessTypes: _i3.Protocol().deserialize<List<_i2.BookAccessType>>(
        jsonSerialization['accessTypes'],
      ),
      formats: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['formats'],
      ),
    );
  }

  List<String> languages;

  List<String> categories;

  List<String> authors;

  List<int> years;

  List<_i2.BookAccessType> accessTypes;

  List<String> formats;

  /// Returns a shallow copy of this [LibraryFilterOptions]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryFilterOptions copyWith({
    List<String>? languages,
    List<String>? categories,
    List<String>? authors,
    List<int>? years,
    List<_i2.BookAccessType>? accessTypes,
    List<String>? formats,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LibraryFilterOptions',
      'languages': languages.toJson(),
      'categories': categories.toJson(),
      'authors': authors.toJson(),
      'years': years.toJson(),
      'accessTypes': accessTypes.toJson(valueToJson: (v) => v.toJson()),
      'formats': formats.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LibraryFilterOptions',
      'languages': languages.toJson(),
      'categories': categories.toJson(),
      'authors': authors.toJson(),
      'years': years.toJson(),
      'accessTypes': accessTypes.toJson(valueToJson: (v) => v.toJson()),
      'formats': formats.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _LibraryFilterOptionsImpl extends LibraryFilterOptions {
  _LibraryFilterOptionsImpl({
    required List<String> languages,
    required List<String> categories,
    required List<String> authors,
    required List<int> years,
    required List<_i2.BookAccessType> accessTypes,
    required List<String> formats,
  }) : super._(
         languages: languages,
         categories: categories,
         authors: authors,
         years: years,
         accessTypes: accessTypes,
         formats: formats,
       );

  /// Returns a shallow copy of this [LibraryFilterOptions]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryFilterOptions copyWith({
    List<String>? languages,
    List<String>? categories,
    List<String>? authors,
    List<int>? years,
    List<_i2.BookAccessType>? accessTypes,
    List<String>? formats,
  }) {
    return LibraryFilterOptions(
      languages: languages ?? this.languages.map((e0) => e0).toList(),
      categories: categories ?? this.categories.map((e0) => e0).toList(),
      authors: authors ?? this.authors.map((e0) => e0).toList(),
      years: years ?? this.years.map((e0) => e0).toList(),
      accessTypes: accessTypes ?? this.accessTypes.map((e0) => e0).toList(),
      formats: formats ?? this.formats.map((e0) => e0).toList(),
    );
  }
}
