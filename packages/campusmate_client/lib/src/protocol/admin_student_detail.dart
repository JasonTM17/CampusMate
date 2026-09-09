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
import 'student_profile.dart' as _i2;
import 'package:campusmate_client/src/protocol/protocol.dart' as _i3;

abstract class AdminStudentDetail implements _i1.SerializableModel {
  AdminStudentDetail._({
    required this.profile,
    required this.activeLoanCount,
    required this.enrolledCourseCount,
  });

  factory AdminStudentDetail({
    required _i2.StudentProfile profile,
    required int activeLoanCount,
    required int enrolledCourseCount,
  }) = _AdminStudentDetailImpl;

  factory AdminStudentDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminStudentDetail(
      profile: _i3.Protocol().deserialize<_i2.StudentProfile>(
        jsonSerialization['profile'],
      ),
      activeLoanCount: jsonSerialization['activeLoanCount'] as int,
      enrolledCourseCount: jsonSerialization['enrolledCourseCount'] as int,
    );
  }

  _i2.StudentProfile profile;

  int activeLoanCount;

  int enrolledCourseCount;

  /// Returns a shallow copy of this [AdminStudentDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminStudentDetail copyWith({
    _i2.StudentProfile? profile,
    int? activeLoanCount,
    int? enrolledCourseCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminStudentDetail',
      'profile': profile.toJson(),
      'activeLoanCount': activeLoanCount,
      'enrolledCourseCount': enrolledCourseCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AdminStudentDetailImpl extends AdminStudentDetail {
  _AdminStudentDetailImpl({
    required _i2.StudentProfile profile,
    required int activeLoanCount,
    required int enrolledCourseCount,
  }) : super._(
         profile: profile,
         activeLoanCount: activeLoanCount,
         enrolledCourseCount: enrolledCourseCount,
       );

  /// Returns a shallow copy of this [AdminStudentDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminStudentDetail copyWith({
    _i2.StudentProfile? profile,
    int? activeLoanCount,
    int? enrolledCourseCount,
  }) {
    return AdminStudentDetail(
      profile: profile ?? this.profile.copyWith(),
      activeLoanCount: activeLoanCount ?? this.activeLoanCount,
      enrolledCourseCount: enrolledCourseCount ?? this.enrolledCourseCount,
    );
  }
}
