import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:test/test.dart';

void main() {
  group('CampusClock', () {
    test('vietnamOffset is UTC+7', () {
      expect(CampusClock.vietnamOffset, const Duration(hours: 7));
    });

    test('campusDateKey formats YYYY-MM-DD in Vietnam local time', () {
      // 2026-09-09 18:00 UTC is 2026-09-10 01:00 in Vietnam (+7)
      final utcEvening = DateTime.utc(2026, 9, 9, 18, 0, 0);
      expect(CampusClock.campusDateKey(utcEvening), '2026-09-10');

      // 2026-09-09 16:59 UTC is 2026-09-09 23:59 in Vietnam (+7)
      final utcBeforMidnight = DateTime.utc(2026, 9, 9, 16, 59, 0);
      expect(CampusClock.campusDateKey(utcBeforMidnight), '2026-09-09');
    });

    test('isSameCampusDay checks calendar equality in campus time', () {
      final t1 = DateTime.utc(2026, 9, 9, 2, 0, 0); // 09:00 VN
      final t2 = DateTime.utc(2026, 9, 9, 16, 0, 0); // 23:00 VN
      final t3 = DateTime.utc(2026, 9, 9, 18, 0, 0); // 01:00 VN next day

      expect(CampusClock.isSameCampusDay(t1, t2), isTrue);
      expect(CampusClock.isSameCampusDay(t2, t3), isFalse);
    });

    test(
      'campusMinuteOfDay calculates minutes since campus local midnight',
      () {
        // 2026-09-09 01:30 UTC is 08:30 in Vietnam (+7)
        final time = DateTime.utc(2026, 9, 9, 1, 30, 0);
        expect(CampusClock.campusMinuteOfDay(time), 8 * 60 + 30);
      },
    );

    test('startOfCampusDayUtc returns UTC timestamp representing 00:00 VN', () {
      final time = DateTime.utc(2026, 9, 9, 10, 0, 0); // 17:00 VN
      final startOfDay = CampusClock.startOfCampusDayUtc(time);

      // 00:00 VN on Sep 9 is 17:00 UTC on Sep 8
      expect(startOfDay, DateTime.utc(2026, 9, 8, 17, 0, 0));
      expect(startOfDay.toUtc().add(CampusClock.vietnamOffset).hour, 0);
      expect(startOfDay.toUtc().add(CampusClock.vietnamOffset).minute, 0);
    });

    test(
      'dateForCampusWeekday projects weekday and minutes onto campus week',
      () {
        // Week starts on Monday
        final campusWeekStartUtc = DateTime.utc(
          2026,
          9,
          6,
          17,
          0,
          0,
        ); // Monday 00:00 VN

        // Wednesday (weekday = 3) at 09:15 VN (555 minutes)
        final classTime = CampusClock.dateForCampusWeekday(
          campusWeekStartUtc,
          weekday: DateTime.wednesday,
          minuteOfDay: 9 * 60 + 15,
        );

        final vnTime = classTime.toUtc().add(CampusClock.vietnamOffset);
        expect(vnTime.weekday, DateTime.wednesday);
        expect(vnTime.hour, 9);
        expect(vnTime.minute, 15);
      },
    );
  });
}
