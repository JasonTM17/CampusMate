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

abstract class VectorCapabilityProbe implements _i1.SerializableModel {
  VectorCapabilityProbe._({
    this.id,
    required this.embedding,
  });

  factory VectorCapabilityProbe({
    int? id,
    required _i1.Vector embedding,
  }) = _VectorCapabilityProbeImpl;

  factory VectorCapabilityProbe.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return VectorCapabilityProbe(
      id: jsonSerialization['id'] as int?,
      embedding: _i1.VectorJsonExtension.fromJson(
        jsonSerialization['embedding'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.Vector embedding;

  /// Returns a shallow copy of this [VectorCapabilityProbe]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VectorCapabilityProbe copyWith({
    int? id,
    _i1.Vector? embedding,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VectorCapabilityProbe',
      if (id != null) 'id': id,
      'embedding': embedding.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VectorCapabilityProbeImpl extends VectorCapabilityProbe {
  _VectorCapabilityProbeImpl({
    int? id,
    required _i1.Vector embedding,
  }) : super._(
         id: id,
         embedding: embedding,
       );

  /// Returns a shallow copy of this [VectorCapabilityProbe]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VectorCapabilityProbe copyWith({
    Object? id = _Undefined,
    _i1.Vector? embedding,
  }) {
    return VectorCapabilityProbe(
      id: id is int? ? id : this.id,
      embedding: embedding ?? this.embedding.clone(),
    );
  }
}
