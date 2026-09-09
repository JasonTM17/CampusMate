import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:test/test.dart';

void main() {
  group('ReadingProgressSync', () {
    final baseTime = DateTime.utc(2026, 9, 9, 10, 0, 0);

    test('shouldClientWin returns true when client is strictly newer', () {
      final clientTime = baseTime.add(const Duration(minutes: 5));
      final serverTime = baseTime;

      expect(
        ReadingProgressSync.shouldClientWin(
          clientUpdatedAt: clientTime,
          serverUpdatedAt: serverTime,
        ),
        isTrue,
      );
    });

    test('shouldClientWin returns false when client is older or equal', () {
      final clientTime = baseTime.subtract(const Duration(minutes: 5));
      final serverTime = baseTime;

      expect(
        ReadingProgressSync.shouldClientWin(
          clientUpdatedAt: clientTime,
          serverUpdatedAt: serverTime,
        ),
        isFalse,
      );

      // Equal timestamps: server wins (idempotent / no unnecessary write)
      expect(
        ReadingProgressSync.shouldClientWin(
          clientUpdatedAt: baseTime,
          serverUpdatedAt: baseTime,
        ),
        isFalse,
      );
    });

    test('resolveLww chooses the record with the latest timestamp', () {
      final olderState = ReadingProgressState(
        bookId: 10,
        progressPercent: 35.0,
        currentLocation: 'chapter-2',
        updatedAt: baseTime,
      );

      final newerState = ReadingProgressState(
        bookId: 10,
        progressPercent: 65.0,
        currentLocation: 'chapter-5',
        updatedAt: baseTime.add(const Duration(hours: 1)),
      );

      // Local newer -> local wins
      expect(
        ReadingProgressSync.resolveLww(local: newerState, remote: olderState),
        newerState,
      );

      // Remote newer -> remote wins
      expect(
        ReadingProgressSync.resolveLww(local: olderState, remote: newerState),
        newerState,
      );
    });
  });
}
