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

abstract class StudentProfile implements _i1.SerializableModel {
  StudentProfile._({
    this.id,
    required this.authUserId,
    this.studentCode,
    this.fullName,
    this.faculty,
    this.major,
    this.className,
    this.gpa,
    this.credits,
    this.conductScore,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentProfile({
    int? id,
    required _i1.UuidValue authUserId,
    String? studentCode,
    String? fullName,
    String? faculty,
    String? major,
    String? className,
    double? gpa,
    int? credits,
    double? conductScore,
    required String role,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _StudentProfileImpl;

  factory StudentProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentCode: jsonSerialization['studentCode'] as String?,
      fullName: jsonSerialization['fullName'] as String?,
      faculty: jsonSerialization['faculty'] as String?,
      major: jsonSerialization['major'] as String?,
      className: jsonSerialization['className'] as String?,
      gpa: (jsonSerialization['gpa'] as num?)?.toDouble(),
      credits: jsonSerialization['credits'] as int?,
      conductScore: (jsonSerialization['conductScore'] as num?)?.toDouble(),
      role: jsonSerialization['role'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue authUserId;

  String? studentCode;

  String? fullName;

  String? faculty;

  String? major;

  String? className;

  double? gpa;

  int? credits;

  double? conductScore;

  String role;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StudentProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StudentProfile copyWith({
    int? id,
    _i1.UuidValue? authUserId,
    String? studentCode,
    String? fullName,
    String? faculty,
    String? major,
    String? className,
    double? gpa,
    int? credits,
    double? conductScore,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (studentCode != null) 'studentCode': studentCode,
      if (fullName != null) 'fullName': fullName,
      if (faculty != null) 'faculty': faculty,
      if (major != null) 'major': major,
      if (className != null) 'className': className,
      if (gpa != null) 'gpa': gpa,
      if (credits != null) 'credits': credits,
      if (conductScore != null) 'conductScore': conductScore,
      'role': role,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentProfileImpl extends StudentProfile {
  _StudentProfileImpl({
    int? id,
    required _i1.UuidValue authUserId,
    String? studentCode,
    String? fullName,
    String? faculty,
    String? major,
    String? className,
    double? gpa,
    int? credits,
    double? conductScore,
    required String role,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         studentCode: studentCode,
         fullName: fullName,
         faculty: faculty,
         major: major,
         className: className,
         gpa: gpa,
         credits: credits,
         conductScore: conductScore,
         role: role,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StudentProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StudentProfile copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? authUserId,
    Object? studentCode = _Undefined,
    Object? fullName = _Undefined,
    Object? faculty = _Undefined,
    Object? major = _Undefined,
    Object? className = _Undefined,
    Object? gpa = _Undefined,
    Object? credits = _Undefined,
    Object? conductScore = _Undefined,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      studentCode: studentCode is String? ? studentCode : this.studentCode,
      fullName: fullName is String? ? fullName : this.fullName,
      faculty: faculty is String? ? faculty : this.faculty,
      major: major is String? ? major : this.major,
      className: className is String? ? className : this.className,
      gpa: gpa is double? ? gpa : this.gpa,
      credits: credits is int? ? credits : this.credits,
      conductScore: conductScore is double? ? conductScore : this.conductScore,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
