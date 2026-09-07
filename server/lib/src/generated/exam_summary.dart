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

import 'package:serverpod/serverpod.dart' as _i1;

abstract class ExamSummary
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ExamSummary._({
    required this.examId,
    required this.offeringId,
    required this.courseCode,
    required this.title,
    required this.examType,
    required this.startsAt,
    required this.endsAt,
    required this.room,
    this.notes,
    required this.daysUntil,
  });

  factory ExamSummary({
    required int examId,
    required int offeringId,
    required String courseCode,
    required String title,
    required String examType,
    required DateTime startsAt,
    required DateTime endsAt,
    required String room,
    String? notes,
    required int daysUntil,
  }) = _ExamSummaryImpl;

  factory ExamSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExamSummary(
      examId: jsonSerialization['examId'] as int,
      offeringId: jsonSerialization['offeringId'] as int,
      courseCode: jsonSerialization['courseCode'] as String,
      title: jsonSerialization['title'] as String,
      examType: jsonSerialization['examType'] as String,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      room: jsonSerialization['room'] as String,
      notes: jsonSerialization['notes'] as String?,
      daysUntil: jsonSerialization['daysUntil'] as int,
    );
  }

  int examId;

  int offeringId;

  String courseCode;

  String title;

  String examType;

  DateTime startsAt;

  DateTime endsAt;

  String room;

  String? notes;

  int daysUntil;

  /// Returns a shallow copy of this [ExamSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExamSummary copyWith({
    int? examId,
    int? offeringId,
    String? courseCode,
    String? title,
    String? examType,
    DateTime? startsAt,
    DateTime? endsAt,
    String? room,
    String? notes,
    int? daysUntil,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExamSummary',
      'examId': examId,
      'offeringId': offeringId,
      'courseCode': courseCode,
      'title': title,
      'examType': examType,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'room': room,
      if (notes != null) 'notes': notes,
      'daysUntil': daysUntil,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExamSummary',
      'examId': examId,
      'offeringId': offeringId,
      'courseCode': courseCode,
      'title': title,
      'examType': examType,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'room': room,
      if (notes != null) 'notes': notes,
      'daysUntil': daysUntil,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExamSummaryImpl extends ExamSummary {
  _ExamSummaryImpl({
    required int examId,
    required int offeringId,
    required String courseCode,
    required String title,
    required String examType,
    required DateTime startsAt,
    required DateTime endsAt,
    required String room,
    String? notes,
    required int daysUntil,
  }) : super._(
         examId: examId,
         offeringId: offeringId,
         courseCode: courseCode,
         title: title,
         examType: examType,
         startsAt: startsAt,
         endsAt: endsAt,
         room: room,
         notes: notes,
         daysUntil: daysUntil,
       );

  /// Returns a shallow copy of this [ExamSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExamSummary copyWith({
    int? examId,
    int? offeringId,
    String? courseCode,
    String? title,
    String? examType,
    DateTime? startsAt,
    DateTime? endsAt,
    String? room,
    Object? notes = _Undefined,
    int? daysUntil,
  }) {
    return ExamSummary(
      examId: examId ?? this.examId,
      offeringId: offeringId ?? this.offeringId,
      courseCode: courseCode ?? this.courseCode,
      title: title ?? this.title,
      examType: examType ?? this.examType,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      room: room ?? this.room,
      notes: notes is String? ? notes : this.notes,
      daysUntil: daysUntil ?? this.daysUntil,
    );
  }
}
