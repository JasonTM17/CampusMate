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

abstract class SemesterSummary
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SemesterSummary._({
    required this.id,
    required this.code,
    required this.name,
    required this.startsAt,
    required this.endsAt,
    required this.isCurrent,
  });

  factory SemesterSummary({
    required int id,
    required String code,
    required String name,
    required DateTime startsAt,
    required DateTime endsAt,
    required bool isCurrent,
  }) = _SemesterSummaryImpl;

  factory SemesterSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return SemesterSummary(
      id: jsonSerialization['id'] as int,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      isCurrent: _i1.BoolJsonExtension.fromJson(jsonSerialization['isCurrent']),
    );
  }

  int id;

  String code;

  String name;

  DateTime startsAt;

  DateTime endsAt;

  bool isCurrent;

  /// Returns a shallow copy of this [SemesterSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SemesterSummary copyWith({
    int? id,
    String? code,
    String? name,
    DateTime? startsAt,
    DateTime? endsAt,
    bool? isCurrent,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SemesterSummary',
      'id': id,
      'code': code,
      'name': name,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'isCurrent': isCurrent,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SemesterSummary',
      'id': id,
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

class _SemesterSummaryImpl extends SemesterSummary {
  _SemesterSummaryImpl({
    required int id,
    required String code,
    required String name,
    required DateTime startsAt,
    required DateTime endsAt,
    required bool isCurrent,
  }) : super._(
         id: id,
         code: code,
         name: name,
         startsAt: startsAt,
         endsAt: endsAt,
         isCurrent: isCurrent,
       );

  /// Returns a shallow copy of this [SemesterSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SemesterSummary copyWith({
    int? id,
    String? code,
    String? name,
    DateTime? startsAt,
    DateTime? endsAt,
    bool? isCurrent,
  }) {
    return SemesterSummary(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }
}
