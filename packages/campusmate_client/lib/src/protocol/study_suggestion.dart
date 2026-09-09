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

abstract class StudySuggestion implements _i1.SerializableModel {
  StudySuggestion._({
    required this.title,
    required this.message,
    required this.priority,
    this.actionLabel,
    this.actionRoute,
  });

  factory StudySuggestion({
    required String title,
    required String message,
    required String priority,
    String? actionLabel,
    String? actionRoute,
  }) = _StudySuggestionImpl;

  factory StudySuggestion.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudySuggestion(
      title: jsonSerialization['title'] as String,
      message: jsonSerialization['message'] as String,
      priority: jsonSerialization['priority'] as String,
      actionLabel: jsonSerialization['actionLabel'] as String?,
      actionRoute: jsonSerialization['actionRoute'] as String?,
    );
  }

  String title;

  String message;

  String priority;

  String? actionLabel;

  String? actionRoute;

  /// Returns a shallow copy of this [StudySuggestion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StudySuggestion copyWith({
    String? title,
    String? message,
    String? priority,
    String? actionLabel,
    String? actionRoute,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudySuggestion',
      'title': title,
      'message': message,
      'priority': priority,
      if (actionLabel != null) 'actionLabel': actionLabel,
      if (actionRoute != null) 'actionRoute': actionRoute,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudySuggestionImpl extends StudySuggestion {
  _StudySuggestionImpl({
    required String title,
    required String message,
    required String priority,
    String? actionLabel,
    String? actionRoute,
  }) : super._(
         title: title,
         message: message,
         priority: priority,
         actionLabel: actionLabel,
         actionRoute: actionRoute,
       );

  /// Returns a shallow copy of this [StudySuggestion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StudySuggestion copyWith({
    String? title,
    String? message,
    String? priority,
    Object? actionLabel = _Undefined,
    Object? actionRoute = _Undefined,
  }) {
    return StudySuggestion(
      title: title ?? this.title,
      message: message ?? this.message,
      priority: priority ?? this.priority,
      actionLabel: actionLabel is String? ? actionLabel : this.actionLabel,
      actionRoute: actionRoute is String? ? actionRoute : this.actionRoute,
    );
  }
}
