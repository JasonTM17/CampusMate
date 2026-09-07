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

abstract class Semester implements _i1.SerializableModel {
  Semester._({
    this.id,
    required this.academicYearId,
    required this.code,
    required this.name,
    required this.startsAt,
    required this.endsAt,
    required this.isCurrent,
  });

  factory Semester({
    int? id,
    required int academicYearId,
    required String code,
    required String name,
    required DateTime startsAt,
    required DateTime endsAt,
    required bool isCurrent,
  }) = _SemesterImpl;

  factory Semester.fromJson(Map<String, dynamic> jsonSerialization) {
    return Semester(
      id: jsonSerialization['id'] as int?,
      academicYearId: jsonSerialization['academicYearId'] as int,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      isCurrent: _i1.BoolJsonExtension.fromJson(jsonSerialization['isCurrent']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int academicYearId;

  String code;

  String name;

  DateTime startsAt;

  DateTime endsAt;

  bool isCurrent;

  /// Returns a shallow copy of this [Semester]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Semester copyWith({
    int? id,
    int? academicYearId,
    String? code,
    String? name,
    DateTime? startsAt,
    DateTime? endsAt,
    bool? isCurrent,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Semester',
      if (id != null) 'id': id,
      'academicYearId': academicYearId,
      'code': code,
      'name': name,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'isCurrent': isCurrent,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SemesterImpl extends Semester {
  _SemesterImpl({
    int? id,
    required int academicYearId,
    required String code,
    required String name,
    required DateTime startsAt,
    required DateTime endsAt,
    required bool isCurrent,
  }) : super._(
         id: id,
         academicYearId: academicYearId,
         code: code,
         name: name,
         startsAt: startsAt,
         endsAt: endsAt,
         isCurrent: isCurrent,
       );

  /// Returns a shallow copy of this [Semester]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Semester copyWith({
    Object? id = _Undefined,
    int? academicYearId,
    String? code,
    String? name,
    DateTime? startsAt,
    DateTime? endsAt,
    bool? isCurrent,
  }) {
    return Semester(
      id: id is int? ? id : this.id,
      academicYearId: academicYearId ?? this.academicYearId,
      code: code ?? this.code,
      name: name ?? this.name,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }
}
