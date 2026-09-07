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

abstract class AcademicYear implements _i1.SerializableModel {
  AcademicYear._({
    this.id,
    required this.code,
    required this.name,
    required this.startsAt,
    required this.endsAt,
  });

  factory AcademicYear({
    int? id,
    required String code,
    required String name,
    required DateTime startsAt,
    required DateTime endsAt,
  }) = _AcademicYearImpl;

  factory AcademicYear.fromJson(Map<String, dynamic> jsonSerialization) {
    return AcademicYear(
      id: jsonSerialization['id'] as int?,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String code;

  String name;

  DateTime startsAt;

  DateTime endsAt;

  /// Returns a shallow copy of this [AcademicYear]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AcademicYear copyWith({
    int? id,
    String? code,
    String? name,
    DateTime? startsAt,
    DateTime? endsAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AcademicYear',
      if (id != null) 'id': id,
      'code': code,
      'name': name,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AcademicYearImpl extends AcademicYear {
  _AcademicYearImpl({
    int? id,
    required String code,
    required String name,
    required DateTime startsAt,
    required DateTime endsAt,
  }) : super._(
         id: id,
         code: code,
         name: name,
         startsAt: startsAt,
         endsAt: endsAt,
       );

  /// Returns a shallow copy of this [AcademicYear]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AcademicYear copyWith({
    Object? id = _Undefined,
    String? code,
    String? name,
    DateTime? startsAt,
    DateTime? endsAt,
  }) {
    return AcademicYear(
      id: id is int? ? id : this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
    );
  }
}
