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

abstract class ExamSchedule implements _i1.SerializableModel {
  ExamSchedule._({
    this.id,
    required this.offeringId,
    required this.examType,
    required this.startsAt,
    required this.endsAt,
    required this.room,
    this.notes,
  });

  factory ExamSchedule({
    int? id,
    required int offeringId,
    required String examType,
    required DateTime startsAt,
    required DateTime endsAt,
    required String room,
    String? notes,
  }) = _ExamScheduleImpl;

  factory ExamSchedule.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExamSchedule(
      id: jsonSerialization['id'] as int?,
      offeringId: jsonSerialization['offeringId'] as int,
      examType: jsonSerialization['examType'] as String,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      room: jsonSerialization['room'] as String,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int offeringId;

  String examType;

  DateTime startsAt;

  DateTime endsAt;

  String room;

  String? notes;

  /// Returns a shallow copy of this [ExamSchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExamSchedule copyWith({
    int? id,
    int? offeringId,
    String? examType,
    DateTime? startsAt,
    DateTime? endsAt,
    String? room,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExamSchedule',
      if (id != null) 'id': id,
      'offeringId': offeringId,
      'examType': examType,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'room': room,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExamScheduleImpl extends ExamSchedule {
  _ExamScheduleImpl({
    int? id,
    required int offeringId,
    required String examType,
    required DateTime startsAt,
    required DateTime endsAt,
    required String room,
    String? notes,
  }) : super._(
         id: id,
         offeringId: offeringId,
         examType: examType,
         startsAt: startsAt,
         endsAt: endsAt,
         room: room,
         notes: notes,
       );

  /// Returns a shallow copy of this [ExamSchedule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExamSchedule copyWith({
    Object? id = _Undefined,
    int? offeringId,
    String? examType,
    DateTime? startsAt,
    DateTime? endsAt,
    String? room,
    Object? notes = _Undefined,
  }) {
    return ExamSchedule(
      id: id is int? ? id : this.id,
      offeringId: offeringId ?? this.offeringId,
      examType: examType ?? this.examType,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      room: room ?? this.room,
      notes: notes is String? ? notes : this.notes,
    );
  }
}
