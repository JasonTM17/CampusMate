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

abstract class CourseOffering implements _i1.SerializableModel {
  CourseOffering._({
    this.id,
    required this.courseId,
    required this.semesterId,
    required this.section,
    required this.lecturerName,
    this.room,
  });

  factory CourseOffering({
    int? id,
    required int courseId,
    required int semesterId,
    required String section,
    required String lecturerName,
    String? room,
  }) = _CourseOfferingImpl;

  factory CourseOffering.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseOffering(
      id: jsonSerialization['id'] as int?,
      courseId: jsonSerialization['courseId'] as int,
      semesterId: jsonSerialization['semesterId'] as int,
      section: jsonSerialization['section'] as String,
      lecturerName: jsonSerialization['lecturerName'] as String,
      room: jsonSerialization['room'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int courseId;

  int semesterId;

  String section;

  String lecturerName;

  String? room;

  /// Returns a shallow copy of this [CourseOffering]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseOffering copyWith({
    int? id,
    int? courseId,
    int? semesterId,
    String? section,
    String? lecturerName,
    String? room,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseOffering',
      if (id != null) 'id': id,
      'courseId': courseId,
      'semesterId': semesterId,
      'section': section,
      'lecturerName': lecturerName,
      if (room != null) 'room': room,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseOfferingImpl extends CourseOffering {
  _CourseOfferingImpl({
    int? id,
    required int courseId,
    required int semesterId,
    required String section,
    required String lecturerName,
    String? room,
  }) : super._(
         id: id,
         courseId: courseId,
         semesterId: semesterId,
         section: section,
         lecturerName: lecturerName,
         room: room,
       );

  /// Returns a shallow copy of this [CourseOffering]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CourseOffering copyWith({
    Object? id = _Undefined,
    int? courseId,
    int? semesterId,
    String? section,
    String? lecturerName,
    Object? room = _Undefined,
  }) {
    return CourseOffering(
      id: id is int? ? id : this.id,
      courseId: courseId ?? this.courseId,
      semesterId: semesterId ?? this.semesterId,
      section: section ?? this.section,
      lecturerName: lecturerName ?? this.lecturerName,
      room: room is String? ? room : this.room,
    );
  }
}
