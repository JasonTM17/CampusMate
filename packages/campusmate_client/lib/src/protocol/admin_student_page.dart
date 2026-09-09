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
import 'admin_student_item.dart' as _i2;
import 'package:campusmate_client/src/protocol/protocol.dart' as _i3;

abstract class AdminStudentPage implements _i1.SerializableModel {
  AdminStudentPage._({
    required this.students,
    this.nextCursor,
    required this.totalCount,
  });

  factory AdminStudentPage({
    required List<_i2.AdminStudentItem> students,
    String? nextCursor,
    required int totalCount,
  }) = _AdminStudentPageImpl;

  factory AdminStudentPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminStudentPage(
      students: _i3.Protocol().deserialize<List<_i2.AdminStudentItem>>(
        jsonSerialization['students'],
      ),
      nextCursor: jsonSerialization['nextCursor'] as String?,
      totalCount: jsonSerialization['totalCount'] as int,
    );
  }

  List<_i2.AdminStudentItem> students;

  String? nextCursor;

  int totalCount;

  /// Returns a shallow copy of this [AdminStudentPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminStudentPage copyWith({
    List<_i2.AdminStudentItem>? students,
    String? nextCursor,
    int? totalCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminStudentPage',
      'students': students.toJson(valueToJson: (v) => v.toJson()),
      if (nextCursor != null) 'nextCursor': nextCursor,
      'totalCount': totalCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminStudentPageImpl extends AdminStudentPage {
  _AdminStudentPageImpl({
    required List<_i2.AdminStudentItem> students,
    String? nextCursor,
    required int totalCount,
  }) : super._(
         students: students,
         nextCursor: nextCursor,
         totalCount: totalCount,
       );

  /// Returns a shallow copy of this [AdminStudentPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminStudentPage copyWith({
    List<_i2.AdminStudentItem>? students,
    Object? nextCursor = _Undefined,
    int? totalCount,
  }) {
    return AdminStudentPage(
      students: students ?? this.students.map((e0) => e0.copyWith()).toList(),
      nextCursor: nextCursor is String? ? nextCursor : this.nextCursor,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}
