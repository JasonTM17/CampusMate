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

abstract class CurriculumBlockProgress implements _i1.SerializableModel {
  CurriculumBlockProgress._({
    required this.name,
    required this.creditsEarned,
    required this.creditsRequired,
  });

  factory CurriculumBlockProgress({
    required String name,
    required int creditsEarned,
    required int creditsRequired,
  }) = _CurriculumBlockProgressImpl;

  factory CurriculumBlockProgress.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CurriculumBlockProgress(
      name: jsonSerialization['name'] as String,
      creditsEarned: jsonSerialization['creditsEarned'] as int,
      creditsRequired: jsonSerialization['creditsRequired'] as int,
    );
  }

  String name;

  int creditsEarned;

  int creditsRequired;

  /// Returns a shallow copy of this [CurriculumBlockProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CurriculumBlockProgress copyWith({
    String? name,
    int? creditsEarned,
    int? creditsRequired,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CurriculumBlockProgress',
      'name': name,
      'creditsEarned': creditsEarned,
      'creditsRequired': creditsRequired,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CurriculumBlockProgressImpl extends CurriculumBlockProgress {
  _CurriculumBlockProgressImpl({
    required String name,
    required int creditsEarned,
    required int creditsRequired,
  }) : super._(
         name: name,
         creditsEarned: creditsEarned,
         creditsRequired: creditsRequired,
       );

  /// Returns a shallow copy of this [CurriculumBlockProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CurriculumBlockProgress copyWith({
    String? name,
    int? creditsEarned,
    int? creditsRequired,
  }) {
    return CurriculumBlockProgress(
      name: name ?? this.name,
      creditsEarned: creditsEarned ?? this.creditsEarned,
      creditsRequired: creditsRequired ?? this.creditsRequired,
    );
  }
}
