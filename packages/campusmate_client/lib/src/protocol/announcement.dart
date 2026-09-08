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

abstract class Announcement implements _i1.SerializableModel {
  Announcement._({
    this.id,
    required this.title,
    required this.body,
    required this.audience,
    required this.publishAt,
    this.expiresAt,
    required this.archived,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Announcement({
    int? id,
    required String title,
    required String body,
    required String audience,
    required DateTime publishAt,
    DateTime? expiresAt,
    required bool archived,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AnnouncementImpl;

  factory Announcement.fromJson(Map<String, dynamic> jsonSerialization) {
    return Announcement(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      audience: jsonSerialization['audience'] as String,
      publishAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['publishAt'],
      ),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      archived: _i1.BoolJsonExtension.fromJson(jsonSerialization['archived']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String body;

  String audience;

  DateTime publishAt;

  DateTime? expiresAt;

  bool archived;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Announcement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Announcement copyWith({
    int? id,
    String? title,
    String? body,
    String? audience,
    DateTime? publishAt,
    DateTime? expiresAt,
    bool? archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Announcement',
      if (id != null) 'id': id,
      'title': title,
      'body': body,
      'audience': audience,
      'publishAt': publishAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'archived': archived,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnnouncementImpl extends Announcement {
  _AnnouncementImpl({
    int? id,
    required String title,
    required String body,
    required String audience,
    required DateTime publishAt,
    DateTime? expiresAt,
    required bool archived,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         title: title,
         body: body,
         audience: audience,
         publishAt: publishAt,
         expiresAt: expiresAt,
         archived: archived,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Announcement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Announcement copyWith({
    Object? id = _Undefined,
    String? title,
    String? body,
    String? audience,
    DateTime? publishAt,
    Object? expiresAt = _Undefined,
    bool? archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Announcement(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      audience: audience ?? this.audience,
      publishAt: publishAt ?? this.publishAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
