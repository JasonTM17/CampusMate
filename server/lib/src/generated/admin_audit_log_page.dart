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
import 'audit_log.dart' as _i2;
import 'package:campusmate_server/src/generated/protocol.dart' as _i3;

abstract class AdminAuditLogPage
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminAuditLogPage._({
    required this.logs,
    this.nextCursor,
    required this.totalCount,
  });

  factory AdminAuditLogPage({
    required List<_i2.AuditLog> logs,
    String? nextCursor,
    required int totalCount,
  }) = _AdminAuditLogPageImpl;

  factory AdminAuditLogPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminAuditLogPage(
      logs: _i3.Protocol().deserialize<List<_i2.AuditLog>>(
        jsonSerialization['logs'],
      ),
      nextCursor: jsonSerialization['nextCursor'] as String?,
      totalCount: jsonSerialization['totalCount'] as int,
    );
  }

  List<_i2.AuditLog> logs;

  String? nextCursor;

  int totalCount;

  /// Returns a shallow copy of this [AdminAuditLogPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminAuditLogPage copyWith({
    List<_i2.AuditLog>? logs,
    String? nextCursor,
    int? totalCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminAuditLogPage',
      'logs': logs.toJson(valueToJson: (v) => v.toJson()),
      if (nextCursor != null) 'nextCursor': nextCursor,
      'totalCount': totalCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminAuditLogPage',
      'logs': logs.toJson(valueToJson: (v) => v.toJsonForProtocol()),
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

class _AdminAuditLogPageImpl extends AdminAuditLogPage {
  _AdminAuditLogPageImpl({
    required List<_i2.AuditLog> logs,
    String? nextCursor,
    required int totalCount,
  }) : super._(
         logs: logs,
         nextCursor: nextCursor,
         totalCount: totalCount,
       );

  /// Returns a shallow copy of this [AdminAuditLogPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminAuditLogPage copyWith({
    List<_i2.AuditLog>? logs,
    Object? nextCursor = _Undefined,
    int? totalCount,
  }) {
    return AdminAuditLogPage(
      logs: logs ?? this.logs.map((e0) => e0.copyWith()).toList(),
      nextCursor: nextCursor is String? ? nextCursor : this.nextCursor,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}
