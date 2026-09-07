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

abstract class GradeComponent implements _i1.SerializableModel {
  GradeComponent._({
    this.id,
    required this.offeringId,
    required this.name,
    required this.weight,
    required this.maxScore,
  });

  factory GradeComponent({
    int? id,
    required int offeringId,
    required String name,
    required double weight,
    required double maxScore,
  }) = _GradeComponentImpl;

  factory GradeComponent.fromJson(Map<String, dynamic> jsonSerialization) {
    return GradeComponent(
      id: jsonSerialization['id'] as int?,
      offeringId: jsonSerialization['offeringId'] as int,
      name: jsonSerialization['name'] as String,
      weight: (jsonSerialization['weight'] as num).toDouble(),
      maxScore: (jsonSerialization['maxScore'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int offeringId;

  String name;

  double weight;

  double maxScore;

  /// Returns a shallow copy of this [GradeComponent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GradeComponent copyWith({
    int? id,
    int? offeringId,
    String? name,
    double? weight,
    double? maxScore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GradeComponent',
      if (id != null) 'id': id,
      'offeringId': offeringId,
      'name': name,
      'weight': weight,
      'maxScore': maxScore,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GradeComponentImpl extends GradeComponent {
  _GradeComponentImpl({
    int? id,
    required int offeringId,
    required String name,
    required double weight,
    required double maxScore,
  }) : super._(
         id: id,
         offeringId: offeringId,
         name: name,
         weight: weight,
         maxScore: maxScore,
       );

  /// Returns a shallow copy of this [GradeComponent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GradeComponent copyWith({
    Object? id = _Undefined,
    int? offeringId,
    String? name,
    double? weight,
    double? maxScore,
  }) {
    return GradeComponent(
      id: id is int? ? id : this.id,
      offeringId: offeringId ?? this.offeringId,
      name: name ?? this.name,
      weight: weight ?? this.weight,
      maxScore: maxScore ?? this.maxScore,
    );
  }
}
