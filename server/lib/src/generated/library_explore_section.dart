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
import 'book_summary.dart' as _i2;
import 'package:campusmate_server/src/generated/protocol.dart' as _i3;

abstract class LibraryExploreSection
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  LibraryExploreSection._({
    required this.key,
    required this.title,
    required this.items,
  });

  factory LibraryExploreSection({
    required String key,
    required String title,
    required List<_i2.BookSummary> items,
  }) = _LibraryExploreSectionImpl;

  factory LibraryExploreSection.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return LibraryExploreSection(
      key: jsonSerialization['key'] as String,
      title: jsonSerialization['title'] as String,
      items: _i3.Protocol().deserialize<List<_i2.BookSummary>>(
        jsonSerialization['items'],
      ),
    );
  }

  String key;

  String title;

  List<_i2.BookSummary> items;

  /// Returns a shallow copy of this [LibraryExploreSection]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryExploreSection copyWith({
    String? key,
    String? title,
    List<_i2.BookSummary>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LibraryExploreSection',
      'key': key,
      'title': title,
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LibraryExploreSection',
      'key': key,
      'title': title,
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _LibraryExploreSectionImpl extends LibraryExploreSection {
  _LibraryExploreSectionImpl({
    required String key,
    required String title,
    required List<_i2.BookSummary> items,
  }) : super._(
         key: key,
         title: title,
         items: items,
       );

  /// Returns a shallow copy of this [LibraryExploreSection]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryExploreSection copyWith({
    String? key,
    String? title,
    List<_i2.BookSummary>? items,
  }) {
    return LibraryExploreSection(
      key: key ?? this.key,
      title: title ?? this.title,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
