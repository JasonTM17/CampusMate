import 'package:flutter_test/flutter_test.dart';

import 'package:campusmate/core/errors/failures.dart';

void main() {
  group('Failure', () {
    test('every failure type has a user-safe default message', () {
      expect(const NetworkFailure().userMessage, 'Network error');
      expect(const OfflineFailure().userMessage, 'You are offline');
      expect(const UnauthorizedFailure().userMessage, 'Session expired');
      expect(const ForbiddenFailure().userMessage, 'Not allowed');
      expect(const ValidationFailure().userMessage, 'Invalid input');
      expect(const NotFoundFailure().userMessage, 'Not found');
      expect(const ServerFailure().userMessage, 'Server error');
    });

    test('custom messages are preserved', () {
      expect(
        const NetworkFailure(message: 'Wi-Fi bị ngắt').userMessage,
        'Wi-Fi bị ngắt',
      );
      expect(
        const ServerFailure(message: 'Không đọc được dữ liệu').userMessage,
        'Không đọc được dữ liệu',
      );
    });

    test('toString exposes type and message for logs', () {
      final text = const UnauthorizedFailure().toString();

      expect(text, contains('UnauthorizedFailure'));
      expect(text, contains('Session expired'));
    });

    test('failure subtypes stay distinct types', () {
      const failures = <Failure>[
        NetworkFailure(),
        OfflineFailure(),
        UnauthorizedFailure(),
        ForbiddenFailure(),
        ValidationFailure(),
        NotFoundFailure(),
        ServerFailure(),
      ];

      expect(failures.map((f) => f.runtimeType).toSet().length, 7);
    });
  });
}
