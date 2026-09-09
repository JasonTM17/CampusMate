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
import 'announcement.dart' as _i2;
import 'package:campusmate_server/src/generated/protocol.dart' as _i3;

abstract class AdminAnnouncementPage
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminAnnouncementPage._({
    required this.announcements,
    this.nextCursor,
    required this.totalCount,
  });

  factory AdminAnnouncementPage({
    required List<_i2.Announcement> announcements,
    String? nextCursor,
    required int totalCount,
  }) = _AdminAnnouncementPageImpl;

  factory AdminAnnouncementPage.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminAnnouncementPage(
      announcements: _i3.Protocol().deserialize<List<_i2.Announcement>>(
        jsonSerialization['announcements'],
      ),
      nextCursor: jsonSerialization['nextCursor'] as String?,
      totalCount: jsonSerialization['totalCount'] as int,
    );
  }

  List<_i2.Announcement> announcements;

  String? nextCursor;

  int totalCount;

  /// Returns a shallow copy of this [AdminAnnouncementPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminAnnouncementPage copyWith({
    List<_i2.Announcement>? announcements,
    String? nextCursor,
    int? totalCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminAnnouncementPage',
      'announcements': announcements.toJson(valueToJson: (v) => v.toJson()),
      if (nextCursor != null) 'nextCursor': nextCursor,
      'totalCount': totalCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminAnnouncementPage',
      'announcements': announcements.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
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

class _AdminAnnouncementPageImpl extends AdminAnnouncementPage {
  _AdminAnnouncementPageImpl({
    required List<_i2.Announcement> announcements,
    String? nextCursor,
    required int totalCount,
  }) : super._(
         announcements: announcements,
         nextCursor: nextCursor,
         totalCount: totalCount,
       );

  /// Returns a shallow copy of this [AdminAnnouncementPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminAnnouncementPage copyWith({
    List<_i2.Announcement>? announcements,
    Object? nextCursor = _Undefined,
    int? totalCount,
  }) {
    return AdminAnnouncementPage(
      announcements:
          announcements ??
          this.announcements.map((e0) => e0.copyWith()).toList(),
      nextCursor: nextCursor is String? ? nextCursor : this.nextCursor,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}
