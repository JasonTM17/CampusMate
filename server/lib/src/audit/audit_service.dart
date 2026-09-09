import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class AuditService {
  Future<AuditLog> record(
    Session session, {
    required UuidValue actorUserId,
    required String action,
    required String resourceType,
    required String resourceId,
    required Map<String, Object?> metadata,
    Transaction? transaction,
  }) {
    final now = DateTime.now().toUtc();
    return AuditLog.db.insertRow(
      session,
      AuditLog(
        actorUserId: actorUserId,
        action: action,
        resourceType: resourceType,
        resourceId: resourceId,
        metadataJson: jsonEncode(sanitizeMetadata(metadata)),
        createdAt: now,
      ),
      transaction: transaction,
    );
  }

  /// Sanitizes [input] map to ensure no passwords, tokens, or credentials are stored.
  static Map<String, Object?> sanitizeMetadata(Map<String, Object?> input) =>
      _sanitizeMap(input);

  static Map<String, Object?> _sanitizeMap(Map<String, Object?> input) {
    final output = <String, Object?>{};
    for (final entry in input.entries) {
      if (_sensitiveKey.hasMatch(entry.key)) continue;
      output[entry.key] = _sanitizeValue(entry.value);
    }
    return output;
  }

  static Object? _sanitizeValue(Object? value) {
    if (value == null || value is num || value is bool || value is String) {
      return value;
    }
    if (value is DateTime) return value.toUtc().toIso8601String();
    if (value is Enum) return value.name;
    if (value is Iterable) {
      return [for (final item in value) _sanitizeValue(item as Object?)];
    }
    if (value is Map) {
      return _sanitizeMap({
        for (final entry in value.entries)
          entry.key.toString(): entry.value as Object?,
      });
    }
    return value.toString();
  }
}

final _sensitiveKey = RegExp(
  r'(password|passphrase|token|secret|credential|api[_-]?key|private[_-]?key|auth|bearer|cookie|session[_-]?key|hash)',
  caseSensitive: false,
);
