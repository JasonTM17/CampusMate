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
import 'curriculum_block_progress.dart' as _i2;
import 'package:campusmate_server/src/generated/protocol.dart' as _i3;

abstract class CurriculumProgress
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CurriculumProgress._({
    required this.blocks,
    required this.creditsEarned,
    required this.creditsRequired,
    required this.percentComplete,
  });

  factory CurriculumProgress({
    required List<_i2.CurriculumBlockProgress> blocks,
    required int creditsEarned,
    required int creditsRequired,
    required double percentComplete,
  }) = _CurriculumProgressImpl;

  factory CurriculumProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return CurriculumProgress(
      blocks: _i3.Protocol().deserialize<List<_i2.CurriculumBlockProgress>>(
        jsonSerialization['blocks'],
      ),
      creditsEarned: jsonSerialization['creditsEarned'] as int,
      creditsRequired: jsonSerialization['creditsRequired'] as int,
      percentComplete: (jsonSerialization['percentComplete'] as num).toDouble(),
    );
  }

  List<_i2.CurriculumBlockProgress> blocks;

  int creditsEarned;

  int creditsRequired;

  double percentComplete;

  /// Returns a shallow copy of this [CurriculumProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CurriculumProgress copyWith({
    List<_i2.CurriculumBlockProgress>? blocks,
    int? creditsEarned,
    int? creditsRequired,
    double? percentComplete,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CurriculumProgress',
      'blocks': blocks.toJson(valueToJson: (v) => v.toJson()),
      'creditsEarned': creditsEarned,
      'creditsRequired': creditsRequired,
      'percentComplete': percentComplete,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CurriculumProgress',
      'blocks': blocks.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'creditsEarned': creditsEarned,
      'creditsRequired': creditsRequired,
      'percentComplete': percentComplete,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CurriculumProgressImpl extends CurriculumProgress {
  _CurriculumProgressImpl({
    required List<_i2.CurriculumBlockProgress> blocks,
    required int creditsEarned,
    required int creditsRequired,
    required double percentComplete,
  }) : super._(
         blocks: blocks,
         creditsEarned: creditsEarned,
         creditsRequired: creditsRequired,
         percentComplete: percentComplete,
       );

  /// Returns a shallow copy of this [CurriculumProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CurriculumProgress copyWith({
    List<_i2.CurriculumBlockProgress>? blocks,
    int? creditsEarned,
    int? creditsRequired,
    double? percentComplete,
  }) {
    return CurriculumProgress(
      blocks: blocks ?? this.blocks.map((e0) => e0.copyWith()).toList(),
      creditsEarned: creditsEarned ?? this.creditsEarned,
      creditsRequired: creditsRequired ?? this.creditsRequired,
      percentComplete: percentComplete ?? this.percentComplete,
    );
  }
}
