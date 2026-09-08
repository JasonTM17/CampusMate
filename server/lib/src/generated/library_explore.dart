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
import 'library_explore_section.dart' as _i2;
import 'library_filter_options.dart' as _i3;
import 'package:campusmate_server/src/generated/protocol.dart' as _i4;

abstract class LibraryExplore
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  LibraryExplore._({
    required this.sections,
    required this.filterOptions,
  });

  factory LibraryExplore({
    required List<_i2.LibraryExploreSection> sections,
    required _i3.LibraryFilterOptions filterOptions,
  }) = _LibraryExploreImpl;

  factory LibraryExplore.fromJson(Map<String, dynamic> jsonSerialization) {
    return LibraryExplore(
      sections: _i4.Protocol().deserialize<List<_i2.LibraryExploreSection>>(
        jsonSerialization['sections'],
      ),
      filterOptions: _i4.Protocol().deserialize<_i3.LibraryFilterOptions>(
        jsonSerialization['filterOptions'],
      ),
    );
  }

  List<_i2.LibraryExploreSection> sections;

  _i3.LibraryFilterOptions filterOptions;

  /// Returns a shallow copy of this [LibraryExplore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LibraryExplore copyWith({
    List<_i2.LibraryExploreSection>? sections,
    _i3.LibraryFilterOptions? filterOptions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LibraryExplore',
      'sections': sections.toJson(valueToJson: (v) => v.toJson()),
      'filterOptions': filterOptions.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LibraryExplore',
      'sections': sections.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'filterOptions': filterOptions.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _LibraryExploreImpl extends LibraryExplore {
  _LibraryExploreImpl({
    required List<_i2.LibraryExploreSection> sections,
    required _i3.LibraryFilterOptions filterOptions,
  }) : super._(
         sections: sections,
         filterOptions: filterOptions,
       );

  /// Returns a shallow copy of this [LibraryExplore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LibraryExplore copyWith({
    List<_i2.LibraryExploreSection>? sections,
    _i3.LibraryFilterOptions? filterOptions,
  }) {
    return LibraryExplore(
      sections: sections ?? this.sections.map((e0) => e0.copyWith()).toList(),
      filterOptions: filterOptions ?? this.filterOptions.copyWith(),
    );
  }
}
