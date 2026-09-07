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

abstract class Course implements _i1.SerializableModel {
  Course._({
    this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.credits,
    required this.faculty,
    required this.department,
  });

  factory Course({
    int? id,
    required String code,
    required String title,
    required String description,
    required int credits,
    required String faculty,
    required String department,
  }) = _CourseImpl;

  factory Course.fromJson(Map<String, dynamic> jsonSerialization) {
    return Course(
      id: jsonSerialization['id'] as int?,
      code: jsonSerialization['code'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      credits: jsonSerialization['credits'] as int,
      faculty: jsonSerialization['faculty'] as String,
      department: jsonSerialization['department'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String code;

  String title;

  String description;

  int credits;

  String faculty;

  String department;

  /// Returns a shallow copy of this [Course]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Course copyWith({
    int? id,
    String? code,
    String? title,
    String? description,
    int? credits,
    String? faculty,
    String? department,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Course',
      if (id != null) 'id': id,
      'code': code,
      'title': title,
      'description': description,
      'credits': credits,
      'faculty': faculty,
      'department': department,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseImpl extends Course {
  _CourseImpl({
    int? id,
    required String code,
    required String title,
    required String description,
    required int credits,
    required String faculty,
    required String department,
  }) : super._(
         id: id,
         code: code,
         title: title,
         description: description,
         credits: credits,
         faculty: faculty,
         department: department,
       );

  /// Returns a shallow copy of this [Course]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Course copyWith({
    Object? id = _Undefined,
    String? code,
    String? title,
    String? description,
    int? credits,
    String? faculty,
    String? department,
  }) {
    return Course(
      id: id is int? ? id : this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      credits: credits ?? this.credits,
      faculty: faculty ?? this.faculty,
      department: department ?? this.department,
    );
  }
}
