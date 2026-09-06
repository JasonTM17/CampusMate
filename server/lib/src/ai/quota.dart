import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../config/runtime_environment.dart';

/// Server-side daily chat quota (phase-08 stage 6).
///
/// The limit is config-driven through `AI_DAILY_MESSAGE_QUOTA` (default 50
/// requests per user per calendar day — plan: "quota dev 50 messages/day,
/// config-driven, không hard-code"). [consume] runs a single atomic upsert:
/// the counter only advances while it is still below the limit, so two
/// concurrent requests cannot both squeeze past the gate.
class DailyMessageQuota {
  DailyMessageQuota({
    int? limit,
    Map<String, String>? environment,
    String? dotenvContent,
  }) : limit =
           limit ??
           _limitFromEnv(
             environment: environment,
             dotenvContent: dotenvContent,
           );

  /// Max assistant requests per user per calendar day.
  final int limit;

  static int _limitFromEnv({
    Map<String, String>? environment,
    String? dotenvContent,
  }) {
    final raw = readRuntimeEnvironmentValue(
      'AI_DAILY_MESSAGE_QUOTA',
      environment: environment,
      dotenvContent: dotenvContent,
    )?.trim();
    final parsed = (raw == null || raw.isEmpty) ? null : int.tryParse(raw);
    return (parsed == null || parsed < 1) ? 50 : parsed;
  }

  /// Consumes one request slot for [userId] today, or throws the friendly
  /// quota-exhausted error that the mobile app surfaces verbatim.
  ///
  /// Runs BEFORE context building and before the provider call (plan C6), so
  /// an exhausted user never reaches the AI and never persists a message.
  Future<void> consume(Session session, String userId) async {
    final now = DateTime.now();
    final day = DateTime(now.year, now.month, now.day);
    final result = await session.db.unsafeQuery(
      'INSERT INTO "ai_usage" '
      '("userId", "day", "requestCount", "inputTokens", "outputTokens", '
      '"estimatedCost") '
      'VALUES (@userId, @day, 1, 0, 0, 0) '
      'ON CONFLICT ("userId", "day") DO UPDATE SET '
      '"requestCount" = "ai_usage"."requestCount" + 1 '
      'WHERE "ai_usage"."requestCount" < @limit '
      'RETURNING "requestCount"',
      parameters: QueryParameters.named({
        'userId': userId,
        'day': day,
        'limit': limit,
      }),
    );
    if (result.isEmpty) {
      throw ServerpodClientException(
        'Bạn đã dùng hết hạn mức $limit tin nhắn trong ngày. '
        'Hạn mức sẽ được cấp lại vào ngày mai — hẹn gặp lại bạn!',
        429,
      );
    }
  }
}
