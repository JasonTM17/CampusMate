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

abstract class AdminDashboardStats implements _i1.SerializableModel {
  AdminDashboardStats._({
    required this.totalStudents,
    required this.activeStudents,
    required this.totalBooks,
    required this.activeLoans,
    required this.aiRequestsToday,
  });

  factory AdminDashboardStats({
    required int totalStudents,
    required int activeStudents,
    required int totalBooks,
    required int activeLoans,
    required int aiRequestsToday,
  }) = _AdminDashboardStatsImpl;

  factory AdminDashboardStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminDashboardStats(
      totalStudents: jsonSerialization['totalStudents'] as int,
      activeStudents: jsonSerialization['activeStudents'] as int,
      totalBooks: jsonSerialization['totalBooks'] as int,
      activeLoans: jsonSerialization['activeLoans'] as int,
      aiRequestsToday: jsonSerialization['aiRequestsToday'] as int,
    );
  }

  int totalStudents;

  int activeStudents;

  int totalBooks;

  int activeLoans;

  int aiRequestsToday;

  /// Returns a shallow copy of this [AdminDashboardStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminDashboardStats copyWith({
    int? totalStudents,
    int? activeStudents,
    int? totalBooks,
    int? activeLoans,
    int? aiRequestsToday,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminDashboardStats',
      'totalStudents': totalStudents,
      'activeStudents': activeStudents,
      'totalBooks': totalBooks,
      'activeLoans': activeLoans,
      'aiRequestsToday': aiRequestsToday,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AdminDashboardStatsImpl extends AdminDashboardStats {
  _AdminDashboardStatsImpl({
    required int totalStudents,
    required int activeStudents,
    required int totalBooks,
    required int activeLoans,
    required int aiRequestsToday,
  }) : super._(
         totalStudents: totalStudents,
         activeStudents: activeStudents,
         totalBooks: totalBooks,
         activeLoans: activeLoans,
         aiRequestsToday: aiRequestsToday,
       );

  /// Returns a shallow copy of this [AdminDashboardStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminDashboardStats copyWith({
    int? totalStudents,
    int? activeStudents,
    int? totalBooks,
    int? activeLoans,
    int? aiRequestsToday,
  }) {
    return AdminDashboardStats(
      totalStudents: totalStudents ?? this.totalStudents,
      activeStudents: activeStudents ?? this.activeStudents,
      totalBooks: totalBooks ?? this.totalBooks,
      activeLoans: activeLoans ?? this.activeLoans,
      aiRequestsToday: aiRequestsToday ?? this.aiRequestsToday,
    );
  }
}
