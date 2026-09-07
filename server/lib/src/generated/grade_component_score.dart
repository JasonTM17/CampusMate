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

abstract class GradeComponentScore
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  GradeComponentScore._({
    required this.name,
    required this.weight,
    required this.score,
    required this.maxScore,
    this.letter,
    this.gradedAt,
  });

  factory GradeComponentScore({
    required String name,
    required double weight,
    required double score,
    required double maxScore,
    String? letter,
    DateTime? gradedAt,
  }) = _GradeComponentScoreImpl;

  factory GradeComponentScore.fromJson(Map<String, dynamic> jsonSerialization) {
    return GradeComponentScore(
      name: jsonSerialization['name'] as String,
      weight: (jsonSerialization['weight'] as num).toDouble(),
      score: (jsonSerialization['score'] as num).toDouble(),
      maxScore: (jsonSerialization['maxScore'] as num).toDouble(),
      letter: jsonSerialization['letter'] as String?,
      gradedAt: jsonSerialization['gradedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['gradedAt']),
    );
  }

  String name;

  double weight;

  double score;

  double maxScore;

  String? letter;

  DateTime? gradedAt;

  /// Returns a shallow copy of this [GradeComponentScore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GradeComponentScore copyWith({
    String? name,
    double? weight,
    double? score,
    double? maxScore,
    String? letter,
    DateTime? gradedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GradeComponentScore',
      'name': name,
      'weight': weight,
      'score': score,
      'maxScore': maxScore,
      if (letter != null) 'letter': letter,
      if (gradedAt != null) 'gradedAt': gradedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GradeComponentScore',
      'name': name,
      'weight': weight,
      'score': score,
      'maxScore': maxScore,
      if (letter != null) 'letter': letter,
      if (gradedAt != null) 'gradedAt': gradedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GradeComponentScoreImpl extends GradeComponentScore {
  _GradeComponentScoreImpl({
    required String name,
    required double weight,
    required double score,
    required double maxScore,
    String? letter,
    DateTime? gradedAt,
  }) : super._(
         name: name,
         weight: weight,
         score: score,
         maxScore: maxScore,
         letter: letter,
         gradedAt: gradedAt,
       );

  /// Returns a shallow copy of this [GradeComponentScore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GradeComponentScore copyWith({
    String? name,
    double? weight,
    double? score,
    double? maxScore,
    Object? letter = _Undefined,
    Object? gradedAt = _Undefined,
  }) {
    return GradeComponentScore(
      name: name ?? this.name,
      weight: weight ?? this.weight,
      score: score ?? this.score,
      maxScore: maxScore ?? this.maxScore,
      letter: letter is String? ? letter : this.letter,
      gradedAt: gradedAt is DateTime? ? gradedAt : this.gradedAt,
    );
  }
}
