import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:campusmate/features/auth/data/auth_token_storage.dart';

void main() {
  group('AuthTokenStorage', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('saves and restores a valid session', () async {
      final storage = AuthTokenStorage();
      final expiresAt = DateTime.utc(2026, 9, 6, 12);

      await storage.save(
        StoredSession(
          accessToken: 'access-token',
          accessTokenExpiresAt: expiresAt,
          refreshToken: 'refresh-token',
          email: 'student001@campusmate.local',
          authUserId: 'user-123',
        ),
      );

      final restored = await storage.read();

      expect(restored, isNotNull);
      expect(restored!.accessToken, 'access-token');
      expect(restored.accessTokenExpiresAt, expiresAt);
      expect(restored.refreshToken, 'refresh-token');
      expect(restored.email, 'student001@campusmate.local');
      expect(restored.authUserId, 'user-123');
    });

    test('clears corrupted expiry data and returns null', () async {
      SharedPreferences.setMockInitialValues({
        'auth.accessToken': 'access-token',
        'auth.accessTokenExpiresAt': 'not-a-date',
        'auth.refreshToken': 'refresh-token',
        'auth.email': 'student001@campusmate.local',
        'auth.authUserId': 'user-123',
      });

      final storage = AuthTokenStorage();
      final restored = await storage.read();
      final prefs = await SharedPreferences.getInstance();

      expect(restored, isNull);
      expect(prefs.getString('auth.accessToken'), isNull);
      expect(prefs.getString('auth.accessTokenExpiresAt'), isNull);
      expect(prefs.getString('auth.refreshToken'), isNull);
      expect(prefs.getString('auth.email'), isNull);
      expect(prefs.getString('auth.authUserId'), isNull);
    });

    test('clears sessions missing identity fields and returns null', () async {
      SharedPreferences.setMockInitialValues({
        'auth.accessToken': 'access-token',
        'auth.accessTokenExpiresAt': '2026-09-06T12:00:00.000Z',
        'auth.refreshToken': 'refresh-token',
        'auth.email': '',
        'auth.authUserId': 'user-123',
      });

      final storage = AuthTokenStorage();
      final restored = await storage.read();
      final prefs = await SharedPreferences.getInstance();

      expect(restored, isNull);
      expect(prefs.getString('auth.accessToken'), isNull);
      expect(prefs.getString('auth.accessTokenExpiresAt'), isNull);
      expect(prefs.getString('auth.refreshToken'), isNull);
      expect(prefs.getString('auth.email'), isNull);
      expect(prefs.getString('auth.authUserId'), isNull);
    });
  });
}
