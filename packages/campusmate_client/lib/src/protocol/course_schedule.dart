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

abstract class CourseSchedule implements _i1.SerializableModel {
  CourseSchedule._({
    this.id,
    required this.offeringId,
    required this.weekday,
    required this.startMinute,
    required this.endMinute,
    required this.room,
    required this.campus,
    required this.startsAt,
    required this.endsAt,
    required this.status,
  });

  factory CourseSchedule({
    int? id,
    required int offeringId,
    required int weekday,
    required int startMinute,
    required int endMinute,
    required String room,
    required String campus,
    required DateTime startsAt,
    required DateTime endsAt,
    required String status,
  }) = _CourseScheduleImpl;

  factory CourseSchedule.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseSchedule(
      id: jsonSerialization['id'] as int?,
      offeringId: jsonSerialization['offeringId'] as int,
      weekday: jsonSerialization['weekday'] as int,
      startMinute: jsonSerialization['startMinute'] as int,
      endMinute: jsonSerialization['endMinute'] as int,
      room: jsonSerialization['room'] as String,
      campus: jsonSerialization['campus'] as String,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      status: jsonSerialization['status'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int offeringId;

  int weekday;

  int startMinute;

  int endMinute;

  String room;

  String campus;

  DateTime startsAt;

  DateTime endsAt;

  String status;

  /// Returns a shallow copy of this [CourseSchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CourseSchedule copyWith({
    int? id,
    int? offeringId,
    int? weekday,
    int? startMinute,
    int? endMinute,
    String? room,
    String? campus,
    DateTime? startsAt,
    DateTime? endsAt,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseSchedule',
      if (id != null) 'id': id,
      'offeringId': offeringId,
      'weekday': weekday,
      'startMinute': startMinute,
      'endMinute': endMinute,
      'room': room,
      'campus': campus,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'status': status,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseScheduleImpl extends CourseSchedule {
  _CourseScheduleImpl({
    int? id,
    required int offeringId,
    required int weekday,
    required int startMinute,
    required int endMinute,
    required String room,
    required String campus,
    required DateTime startsAt,
    required DateTime endsAt,
    required String status,
  }) : super._(
         id: id,
         offeringId: offeringId,
         weekday: weekday,
         startMinute: startMinute,
         endMinute: endMinute,
         room: room,
         campus: campus,
         startsAt: startsAt,
         endsAt: endsAt,
         status: status,
       );

  /// Returns a shallow copy of this [CourseSchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CourseSchedule copyWith({
    Object? id = _Undefined,
    int? offeringId,
    int? weekday,
    int? startMinute,
    int? endMinute,
    String? room,
    String? campus,
    DateTime? startsAt,
    DateTime? endsAt,
    String? status,
  }) {
    return CourseSchedule(
      id: id is int? ? id : this.id,
      offeringId: offeringId ?? this.offeringId,
      weekday: weekday ?? this.weekday,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      room: room ?? this.room,
      campus: campus ?? this.campus,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      status: status ?? this.status,
    );
  }
}
