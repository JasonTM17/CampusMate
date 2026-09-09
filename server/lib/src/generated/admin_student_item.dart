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

abstract class AdminStudentItem
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminStudentItem._({
    required this.id,
    required this.authUserId,
    this.studentCode,
    this.fullName,
    this.className,
    this.faculty,
    this.major,
    this.gpa,
    required this.role,
    required this.status,
    required this.createdAt,
  });

  factory AdminStudentItem({
    required int id,
    required _i1.UuidValue authUserId,
    String? studentCode,
    String? fullName,
    String? className,
    String? faculty,
    String? major,
    double? gpa,
    required String role,
    required String status,
    required DateTime createdAt,
  }) = _AdminStudentItemImpl;

  factory AdminStudentItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminStudentItem(
      id: jsonSerialization['id'] as int,
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      studentCode: jsonSerialization['studentCode'] as String?,
      fullName: jsonSerialization['fullName'] as String?,
      className: jsonSerialization['className'] as String?,
      faculty: jsonSerialization['faculty'] as String?,
      major: jsonSerialization['major'] as String?,
      gpa: (jsonSerialization['gpa'] as num?)?.toDouble(),
      role: jsonSerialization['role'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  int id;

  _i1.UuidValue authUserId;

  String? studentCode;

  String? fullName;

  String? className;

  String? faculty;

  String? major;

  double? gpa;

  String role;

  String status;

  DateTime createdAt;

  /// Returns a shallow copy of this [AdminStudentItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminStudentItem copyWith({
    int? id,
    _i1.UuidValue? authUserId,
    String? studentCode,
    String? fullName,
    String? className,
    String? faculty,
    String? major,
    double? gpa,
    String? role,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminStudentItem',
      'id': id,
      'authUserId': authUserId.toJson(),
      if (studentCode != null) 'studentCode': studentCode,
      if (fullName != null) 'fullName': fullName,
      if (className != null) 'className': className,
      if (faculty != null) 'faculty': faculty,
      if (major != null) 'major': major,
      if (gpa != null) 'gpa': gpa,
      'role': role,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminStudentItem',
      'id': id,
      'authUserId': authUserId.toJson(),
      if (studentCode != null) 'studentCode': studentCode,
      if (fullName != null) 'fullName': fullName,
      if (className != null) 'className': className,
      if (faculty != null) 'faculty': faculty,
      if (major != null) 'major': major,
      if (gpa != null) 'gpa': gpa,
      'role': role,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminStudentItemImpl extends AdminStudentItem {
  _AdminStudentItemImpl({
    required int id,
    required _i1.UuidValue authUserId,
    String? studentCode,
    String? fullName,
    String? className,
    String? faculty,
    String? major,
    double? gpa,
    required String role,
    required String status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         studentCode: studentCode,
         fullName: fullName,
         className: className,
         faculty: faculty,
         major: major,
         gpa: gpa,
         role: role,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AdminStudentItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminStudentItem copyWith({
    int? id,
    _i1.UuidValue? authUserId,
    Object? studentCode = _Undefined,
    Object? fullName = _Undefined,
    Object? className = _Undefined,
    Object? faculty = _Undefined,
    Object? major = _Undefined,
    Object? gpa = _Undefined,
    String? role,
    String? status,
    DateTime? createdAt,
  }) {
    return AdminStudentItem(
      id: id ?? this.id,
      authUserId: authUserId ?? this.authUserId,
      studentCode: studentCode is String? ? studentCode : this.studentCode,
      fullName: fullName is String? ? fullName : this.fullName,
      className: className is String? ? className : this.className,
      faculty: faculty is String? ? faculty : this.faculty,
      major: major is String? ? major : this.major,
      gpa: gpa is double? ? gpa : this.gpa,
      role: role ?? this.role,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
