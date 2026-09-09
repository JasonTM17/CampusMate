import 'package:campusmate_server/src/audit/audit_service.dart';
import 'package:campusmate_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('AuditService.sanitizeMetadata', () {
    test('removes sensitive keys case-insensitively', () {
      final input = {
        'bookId': 42,
        'action': 'borrow',
        'password': 'super-secret-password',
        'PASSWORD': 'another-password',
        'api_key': 'secret-api-key',
        'apiKey': 'my-api-key',
        'authToken': 'jwt.token.here',
        'clientSecret': 'client-secret-value',
        'sessionKey': 'session-12345',
        'hash': 'bcrypt_sample_hash',
        'privateKey': '-----BEGIN RSA PRIVATE KEY-----',
      };

      final sanitized = AuditService.sanitizeMetadata(input);

      expect(sanitized, {
        'bookId': 42,
        'action': 'borrow',
      });
      expect(sanitized.containsKey('password'), isFalse);
      expect(sanitized.containsKey('PASSWORD'), isFalse);
      expect(sanitized.containsKey('api_key'), isFalse);
      expect(sanitized.containsKey('apiKey'), isFalse);
      expect(sanitized.containsKey('authToken'), isFalse);
      expect(sanitized.containsKey('clientSecret'), isFalse);
      expect(sanitized.containsKey('sessionKey'), isFalse);
      expect(sanitized.containsKey('hash'), isFalse);
      expect(sanitized.containsKey('privateKey'), isFalse);
    });

    test('recursively sanitizes nested maps', () {
      final input = {
        'outer': 'safe',
        'nested': {
          'innerSafe': 'valid-data',
          'token': 'bearer-secret',
          'deeper': {
            'deepSecret': 'deep-value',
            'safeNumber': 100,
          },
        },
      };

      final sanitized = AuditService.sanitizeMetadata(input);

      expect(sanitized, {
        'outer': 'safe',
        'nested': {
          'innerSafe': 'valid-data',
          'deeper': {
            'safeNumber': 100,
          },
        },
      });
    });

    test('recursively sanitizes maps inside lists', () {
      final input = {
        'items': [
          {'name': 'item1', 'token': 'abc'},
          {'name': 'item2', 'secret': 'xyz'},
          'primitive-string',
          42,
        ],
      };

      final sanitized = AuditService.sanitizeMetadata(input);

      expect(sanitized, {
        'items': [
          {'name': 'item1'},
          {'name': 'item2'},
          'primitive-string',
          42,
        ],
      });
    });

    test('formats DateTime values to UTC ISO-8601 strings', () {
      final date = DateTime.utc(2026, 9, 9, 8, 30, 0);
      final input = {'timestamp': date};

      final sanitized = AuditService.sanitizeMetadata(input);

      expect(sanitized['timestamp'], '2026-09-09T08:30:00.000Z');
    });

    test('converts enum values to their names', () {
      final input = {
        'accessType': BookAccessType.borrowRequired,
        'copyStatus': BookCopyStatus.available,
      };

      final sanitized = AuditService.sanitizeMetadata(input);

      expect(sanitized['accessType'], 'borrowRequired');
      expect(sanitized['copyStatus'], 'available');
    });

    test('preserves primitives (null, bool, num, string)', () {
      final input = {
        'nullVal': null,
        'boolVal': true,
        'intVal': 123,
        'doubleVal': 45.67,
        'stringVal': 'hello world',
      };

      final sanitized = AuditService.sanitizeMetadata(input);

      expect(sanitized, input);
    });
  });
}
