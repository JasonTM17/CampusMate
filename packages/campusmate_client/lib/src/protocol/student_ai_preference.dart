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

abstract class StudentAiPreference implements _i1.SerializableModel {
  StudentAiPreference._({
    this.id,
    required this.userId,
    required this.explanationStyle,
    required this.personalizationEnabled,
    required this.memoryEnabled,
    required this.updatedAt,
  });

  factory StudentAiPreference({
    int? id,
    required _i1.UuidValue userId,
    required String explanationStyle,
    required bool personalizationEnabled,
    required bool memoryEnabled,
    required DateTime updatedAt,
  }) = _StudentAiPreferenceImpl;

  factory StudentAiPreference.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentAiPreference(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      explanationStyle: jsonSerialization['explanationStyle'] as String,
      personalizationEnabled: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['personalizationEnabled'],
      ),
      memoryEnabled: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['memoryEnabled'],
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

  _i1.UuidValue userId;

  String explanationStyle;

  bool personalizationEnabled;

  bool memoryEnabled;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StudentAiPreference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StudentAiPreference copyWith({
    int? id,
    _i1.UuidValue? userId,
    String? explanationStyle,
    bool? personalizationEnabled,
    bool? memoryEnabled,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentAiPreference',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'explanationStyle': explanationStyle,
      'personalizationEnabled': personalizationEnabled,
      'memoryEnabled': memoryEnabled,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentAiPreferenceImpl extends StudentAiPreference {
  _StudentAiPreferenceImpl({
    int? id,
    required _i1.UuidValue userId,
    required String explanationStyle,
    required bool personalizationEnabled,
    required bool memoryEnabled,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         explanationStyle: explanationStyle,
         personalizationEnabled: personalizationEnabled,
         memoryEnabled: memoryEnabled,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StudentAiPreference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StudentAiPreference copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    String? explanationStyle,
    bool? personalizationEnabled,
    bool? memoryEnabled,
    DateTime? updatedAt,
  }) {
    return StudentAiPreference(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      explanationStyle: explanationStyle ?? this.explanationStyle,
      personalizationEnabled:
          personalizationEnabled ?? this.personalizationEnabled,
      memoryEnabled: memoryEnabled ?? this.memoryEnabled,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
