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

abstract class AiUsage implements _i1.SerializableModel {
  AiUsage._({
    this.id,
    required this.userId,
    required this.day,
    required this.requestCount,
    required this.inputTokens,
    required this.outputTokens,
    required this.estimatedCost,
  });

  factory AiUsage({
    int? id,
    required String userId,
    required DateTime day,
    required int requestCount,
    required int inputTokens,
    required int outputTokens,
    required int estimatedCost,
  }) = _AiUsageImpl;

  factory AiUsage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiUsage(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      day: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['day']),
      requestCount: jsonSerialization['requestCount'] as int,
      inputTokens: jsonSerialization['inputTokens'] as int,
      outputTokens: jsonSerialization['outputTokens'] as int,
      estimatedCost: jsonSerialization['estimatedCost'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userId;

  DateTime day;

  int requestCount;

  int inputTokens;

  int outputTokens;

  int estimatedCost;

  /// Returns a shallow copy of this [AiUsage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiUsage copyWith({
    int? id,
    String? userId,
    DateTime? day,
    int? requestCount,
    int? inputTokens,
    int? outputTokens,
    int? estimatedCost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiUsage',
      if (id != null) 'id': id,
      'userId': userId,
      'day': day.toJson(),
      'requestCount': requestCount,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'estimatedCost': estimatedCost,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiUsageImpl extends AiUsage {
  _AiUsageImpl({
    int? id,
    required String userId,
    required DateTime day,
    required int requestCount,
    required int inputTokens,
    required int outputTokens,
    required int estimatedCost,
  }) : super._(
         id: id,
         userId: userId,
         day: day,
         requestCount: requestCount,
         inputTokens: inputTokens,
         outputTokens: outputTokens,
         estimatedCost: estimatedCost,
       );

  /// Returns a shallow copy of this [AiUsage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiUsage copyWith({
    Object? id = _Undefined,
    String? userId,
    DateTime? day,
    int? requestCount,
    int? inputTokens,
    int? outputTokens,
    int? estimatedCost,
  }) {
    return AiUsage(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      day: day ?? this.day,
      requestCount: requestCount ?? this.requestCount,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      estimatedCost: estimatedCost ?? this.estimatedCost,
    );
  }
}
