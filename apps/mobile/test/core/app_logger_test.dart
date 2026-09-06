import 'package:flutter_test/flutter_test.dart';

import 'package:campusmate/core/utils/app_logger.dart';

/// Captures everything emitted through the logger sink.
List<String> captureLogs(void Function(ConsoleAppLogger logger) body) {
  final lines = <String>[];
  final logger = ConsoleAppLogger(sink: lines.add);
  body(logger);
  return lines;
}

void main() {
  group('ConsoleAppLogger', () {
    test('emits an upper-cased level tag with the message', () {
      final lines = captureLogs((logger) => logger.info('server reached'));

      expect(lines, hasLength(1));
      expect(lines.single, startsWith('[INFO] server reached'));
    });

    test('scrubs sensitive context keys, keeps safe values', () {
      final lines = captureLogs(
        (logger) => logger.info(
          'login attempt',
          context: {
            'password': 'hunter2',
            'token': 'abc.def.ghi',
            'accessToken': 'at-123',
            'refreshToken': 'rt-123',
            'apiKey': 'sk-123',
            'signedUrl': 'https://minio/signed',
            'authorization': 'Bearer x',
            'email': 'student001@campusmate.local',
          },
        ),
      );

      final line = lines.single;
      expect(line, contains('«redacted»'));
      expect(line, isNot(contains('hunter2')));
      expect(line, isNot(contains('abc.def.ghi')));
      expect(line, isNot(contains('at-123')));
      expect(line, isNot(contains('rt-123')));
      expect(line, isNot(contains('sk-123')));
      expect(line, isNot(contains('https://minio/signed')));
      expect(line, isNot(contains('Bearer x')));
      // Non-sensitive context must survive so logs stay useful.
      expect(line, contains('student001@campusmate.local'));
    });

    test('scrubbing is case-insensitive on key names', () {
      final lines = captureLogs(
        (logger) => logger.warning(
          'flagged',
          context: {
            'PASSWORD': 'nope',
            'api_key': 'sk-456',
            'access_token': 'at-456',
            'refresh_token': 'rt-456',
          },
        ),
      );

      final line = lines.single;
      expect(line, isNot(contains('nope')));
      expect(line, isNot(contains('sk-456')));
      expect(line, isNot(contains('at-456')));
      expect(line, isNot(contains('rt-456')));
      expect(line, contains('«redacted»'));
    });

    test('appends the error when provided', () {
      final lines = captureLogs(
        (logger) => logger.error('save failed', error: StateError('boom')),
      );

      expect(lines.single, contains('error=Bad state: boom'));
    });

    test('emits the stack trace when provided', () {
      final stack = StackTrace.current;
      final lines = captureLogs(
        (logger) => logger.error(
          'save failed',
          error: StateError('boom'),
          stackTrace: stack,
        ),
      );

      final emitted = lines.join('\n');
      expect(emitted, contains('save failed'));
      // One print call carries the header plus the multi-line trace.
      expect(emitted, contains('\n'));
      expect(emitted, contains(stack.toString().split('\n').first));
    });

    test('omits the trace and error sections when absent', () {
      final lines = captureLogs((logger) => logger.debug('quiet line'));

      expect(lines, hasLength(1));
      expect(lines.single, '[DEBUG] quiet line');
    });

    test('warning forwards context, error and stack trace', () {
      final stack = StackTrace.current;
      final lines = captureLogs(
        (logger) => logger.warning(
          'retrying',
          context: {'attempt': 2},
          error: Exception('timeout'),
          stackTrace: stack,
        ),
      );

      expect(lines.single, startsWith('[WARNING] retrying'));
      expect(lines.single, contains('attempt: 2'));
      expect(lines.single, contains('error='));
    });
  });
}
