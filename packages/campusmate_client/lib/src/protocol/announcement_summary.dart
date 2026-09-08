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

abstract class AnnouncementSummary implements _i1.SerializableModel {
  AnnouncementSummary._({
    required this.id,
    required this.title,
    required this.body,
    required this.audience,
    required this.publishAt,
    this.expiresAt,
  });

  factory AnnouncementSummary({
    required int id,
    required String title,
    required String body,
    required String audience,
    required DateTime publishAt,
    DateTime? expiresAt,
  }) = _AnnouncementSummaryImpl;

  factory AnnouncementSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnnouncementSummary(
      id: jsonSerialization['id'] as int,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      audience: jsonSerialization['audience'] as String,
      publishAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['publishAt'],
      ),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
    );
  }

  int id;

  String title;

  String body;

  String audience;

  DateTime publishAt;

  DateTime? expiresAt;

  /// Returns a shallow copy of this [AnnouncementSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AnnouncementSummary copyWith({
    int? id,
    String? title,
    String? body,
    String? audience,
    DateTime? publishAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnnouncementSummary',
      'id': id,
      'title': title,
      'body': body,
      'audience': audience,
      'publishAt': publishAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnnouncementSummaryImpl extends AnnouncementSummary {
  _AnnouncementSummaryImpl({
    required int id,
    required String title,
    required String body,
    required String audience,
    required DateTime publishAt,
    DateTime? expiresAt,
  }) : super._(
         id: id,
         title: title,
         body: body,
         audience: audience,
         publishAt: publishAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [AnnouncementSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AnnouncementSummary copyWith({
    int? id,
    String? title,
    String? body,
    String? audience,
    DateTime? publishAt,
    Object? expiresAt = _Undefined,
  }) {
    return AnnouncementSummary(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      audience: audience ?? this.audience,
      publishAt: publishAt ?? this.publishAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
    );
  }
}
