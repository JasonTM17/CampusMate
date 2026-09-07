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

abstract class TimetableEntry
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TimetableEntry._({
    required this.scheduleId,
    required this.offeringId,
    required this.courseCode,
    required this.title,
    required this.lecturerName,
    required this.weekday,
    required this.startMinute,
    required this.endMinute,
    required this.room,
    required this.campus,
    required this.status,
    required this.startsAt,
    required this.endsAt,
    required this.isCurrent,
  });

  factory TimetableEntry({
    required int scheduleId,
    required int offeringId,
    required String courseCode,
    required String title,
    required String lecturerName,
    required int weekday,
    required int startMinute,
    required int endMinute,
    required String room,
    required String campus,
    required String status,
    required DateTime startsAt,
    required DateTime endsAt,
    required bool isCurrent,
  }) = _TimetableEntryImpl;

  factory TimetableEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return TimetableEntry(
      scheduleId: jsonSerialization['scheduleId'] as int,
      offeringId: jsonSerialization['offeringId'] as int,
      courseCode: jsonSerialization['courseCode'] as String,
      title: jsonSerialization['title'] as String,
      lecturerName: jsonSerialization['lecturerName'] as String,
      weekday: jsonSerialization['weekday'] as int,
      startMinute: jsonSerialization['startMinute'] as int,
      endMinute: jsonSerialization['endMinute'] as int,
      room: jsonSerialization['room'] as String,
      campus: jsonSerialization['campus'] as String,
      status: jsonSerialization['status'] as String,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      isCurrent: _i1.BoolJsonExtension.fromJson(jsonSerialization['isCurrent']),
    );
  }

  int scheduleId;

  int offeringId;

  String courseCode;

  String title;

  String lecturerName;

  int weekday;

  int startMinute;

  int endMinute;

  String room;

  String campus;

  String status;

  DateTime startsAt;

  DateTime endsAt;

  bool isCurrent;

  /// Returns a shallow copy of this [TimetableEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TimetableEntry copyWith({
    int? scheduleId,
    int? offeringId,
    String? courseCode,
    String? title,
    String? lecturerName,
    int? weekday,
    int? startMinute,
    int? endMinute,
    String? room,
    String? campus,
    String? status,
    DateTime? startsAt,
    DateTime? endsAt,
    bool? isCurrent,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TimetableEntry',
      'scheduleId': scheduleId,
      'offeringId': offeringId,
      'courseCode': courseCode,
      'title': title,
      'lecturerName': lecturerName,
      'weekday': weekday,
      'startMinute': startMinute,
      'endMinute': endMinute,
      'room': room,
      'campus': campus,
      'status': status,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'isCurrent': isCurrent,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TimetableEntry',
      'scheduleId': scheduleId,
      'offeringId': offeringId,
      'courseCode': courseCode,
      'title': title,
      'lecturerName': lecturerName,
      'weekday': weekday,
      'startMinute': startMinute,
      'endMinute': endMinute,
      'room': room,
      'campus': campus,
      'status': status,
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

class _TimetableEntryImpl extends TimetableEntry {
  _TimetableEntryImpl({
    required int scheduleId,
    required int offeringId,
    required String courseCode,
    required String title,
    required String lecturerName,
    required int weekday,
    required int startMinute,
    required int endMinute,
    required String room,
    required String campus,
    required String status,
    required DateTime startsAt,
    required DateTime endsAt,
    required bool isCurrent,
  }) : super._(
         scheduleId: scheduleId,
         offeringId: offeringId,
         courseCode: courseCode,
         title: title,
         lecturerName: lecturerName,
         weekday: weekday,
         startMinute: startMinute,
         endMinute: endMinute,
         room: room,
         campus: campus,
         status: status,
         startsAt: startsAt,
         endsAt: endsAt,
         isCurrent: isCurrent,
       );

  /// Returns a shallow copy of this [TimetableEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TimetableEntry copyWith({
    int? scheduleId,
    int? offeringId,
    String? courseCode,
    String? title,
    String? lecturerName,
    int? weekday,
    int? startMinute,
    int? endMinute,
    String? room,
    String? campus,
    String? status,
    DateTime? startsAt,
    DateTime? endsAt,
    bool? isCurrent,
  }) {
    return TimetableEntry(
      scheduleId: scheduleId ?? this.scheduleId,
      offeringId: offeringId ?? this.offeringId,
      courseCode: courseCode ?? this.courseCode,
      title: title ?? this.title,
      lecturerName: lecturerName ?? this.lecturerName,
      weekday: weekday ?? this.weekday,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      room: room ?? this.room,
      campus: campus ?? this.campus,
      status: status ?? this.status,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }
}
