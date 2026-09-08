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

abstract class DashboardGreeting implements _i1.SerializableModel {
  DashboardGreeting._({
    required this.message,
    this.studentName,
    required this.generatedAt,
  });

  factory DashboardGreeting({
    required String message,
    String? studentName,
    required DateTime generatedAt,
  }) = _DashboardGreetingImpl;

  factory DashboardGreeting.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardGreeting(
      message: jsonSerialization['message'] as String,
      studentName: jsonSerialization['studentName'] as String?,
      generatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
    );
  }

  String message;

  String? studentName;

  DateTime generatedAt;

  /// Returns a shallow copy of this [DashboardGreeting]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DashboardGreeting copyWith({
    String? message,
    String? studentName,
    DateTime? generatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardGreeting',
      'message': message,
      if (studentName != null) 'studentName': studentName,
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DashboardGreetingImpl extends DashboardGreeting {
  _DashboardGreetingImpl({
    required String message,
    String? studentName,
    required DateTime generatedAt,
  }) : super._(
         message: message,
         studentName: studentName,
         generatedAt: generatedAt,
       );

  /// Returns a shallow copy of this [DashboardGreeting]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DashboardGreeting copyWith({
    String? message,
    Object? studentName = _Undefined,
    DateTime? generatedAt,
  }) {
    return DashboardGreeting(
      message: message ?? this.message,
      studentName: studentName is String? ? studentName : this.studentName,
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }
}
