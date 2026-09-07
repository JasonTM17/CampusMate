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

abstract class StudentGrade implements _i1.SerializableModel {
  StudentGrade._({
    this.id,
    required this.enrollmentId,
    required this.componentName,
    required this.weight,
    required this.score,
    required this.maxScore,
    this.letter,
    this.gradedAt,
  });

  factory StudentGrade({
    int? id,
    required int enrollmentId,
    required String componentName,
    required double weight,
    required double score,
    required double maxScore,
    String? letter,
    DateTime? gradedAt,
  }) = _StudentGradeImpl;

  factory StudentGrade.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentGrade(
      id: jsonSerialization['id'] as int?,
      enrollmentId: jsonSerialization['enrollmentId'] as int,
      componentName: jsonSerialization['componentName'] as String,
      weight: (jsonSerialization['weight'] as num).toDouble(),
      score: (jsonSerialization['score'] as num).toDouble(),
      maxScore: (jsonSerialization['maxScore'] as num).toDouble(),
      letter: jsonSerialization['letter'] as String?,
      gradedAt: jsonSerialization['gradedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['gradedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int enrollmentId;

  String componentName;

  double weight;

  double score;

  double maxScore;

  String? letter;

  DateTime? gradedAt;

  /// Returns a shallow copy of this [StudentGrade]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StudentGrade copyWith({
    int? id,
    int? enrollmentId,
    String? componentName,
    double? weight,
    double? score,
    double? maxScore,
    String? letter,
    DateTime? gradedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentGrade',
      if (id != null) 'id': id,
      'enrollmentId': enrollmentId,
      'componentName': componentName,
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

class _StudentGradeImpl extends StudentGrade {
  _StudentGradeImpl({
    int? id,
    required int enrollmentId,
    required String componentName,
    required double weight,
    required double score,
    required double maxScore,
    String? letter,
    DateTime? gradedAt,
  }) : super._(
         id: id,
         enrollmentId: enrollmentId,
         componentName: componentName,
         weight: weight,
         score: score,
         maxScore: maxScore,
         letter: letter,
         gradedAt: gradedAt,
       );

  /// Returns a shallow copy of this [StudentGrade]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StudentGrade copyWith({
    Object? id = _Undefined,
    int? enrollmentId,
    String? componentName,
    double? weight,
    double? score,
    double? maxScore,
    Object? letter = _Undefined,
    Object? gradedAt = _Undefined,
  }) {
    return StudentGrade(
      id: id is int? ? id : this.id,
      enrollmentId: enrollmentId ?? this.enrollmentId,
      componentName: componentName ?? this.componentName,
      weight: weight ?? this.weight,
      score: score ?? this.score,
      maxScore: maxScore ?? this.maxScore,
      letter: letter is String? ? letter : this.letter,
      gradedAt: gradedAt is DateTime? ? gradedAt : this.gradedAt,
    );
  }
}
