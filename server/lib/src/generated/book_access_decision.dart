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

abstract class BookAccessDecision
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  BookAccessDecision._({
    required this.role,
    required this.canRead,
    required this.canDownload,
    required this.canBorrow,
    this.reason,
  });

  factory BookAccessDecision({
    required String role,
    required bool canRead,
    required bool canDownload,
    required bool canBorrow,
    String? reason,
  }) = _BookAccessDecisionImpl;

  factory BookAccessDecision.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookAccessDecision(
      role: jsonSerialization['role'] as String,
      canRead: _i1.BoolJsonExtension.fromJson(jsonSerialization['canRead']),
      canDownload: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['canDownload'],
      ),
      canBorrow: _i1.BoolJsonExtension.fromJson(jsonSerialization['canBorrow']),
      reason: jsonSerialization['reason'] as String?,
    );
  }

  String role;

  bool canRead;

  bool canDownload;

  bool canBorrow;

  String? reason;

  /// Returns a shallow copy of this [BookAccessDecision]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BookAccessDecision copyWith({
    String? role,
    bool? canRead,
    bool? canDownload,
    bool? canBorrow,
    String? reason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookAccessDecision',
      'role': role,
      'canRead': canRead,
      'canDownload': canDownload,
      'canBorrow': canBorrow,
      if (reason != null) 'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookAccessDecision',
      'role': role,
      'canRead': canRead,
      'canDownload': canDownload,
      'canBorrow': canBorrow,
      if (reason != null) 'reason': reason,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookAccessDecisionImpl extends BookAccessDecision {
  _BookAccessDecisionImpl({
    required String role,
    required bool canRead,
    required bool canDownload,
    required bool canBorrow,
    String? reason,
  }) : super._(
         role: role,
         canRead: canRead,
         canDownload: canDownload,
         canBorrow: canBorrow,
         reason: reason,
       );

  /// Returns a shallow copy of this [BookAccessDecision]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BookAccessDecision copyWith({
    String? role,
    bool? canRead,
    bool? canDownload,
    bool? canBorrow,
    Object? reason = _Undefined,
  }) {
    return BookAccessDecision(
      role: role ?? this.role,
      canRead: canRead ?? this.canRead,
      canDownload: canDownload ?? this.canDownload,
      canBorrow: canBorrow ?? this.canBorrow,
      reason: reason is String? ? reason : this.reason,
    );
  }
}
