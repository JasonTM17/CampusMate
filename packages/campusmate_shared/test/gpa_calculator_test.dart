import 'package:campusmate_shared/campusmate_shared.dart';
import 'package:test/test.dart';

void main() {
  group('CampusClock', () {
    test('derives campus week from Vietnam time instead of UTC midnight', () {
      final earlyMondayInVietnam = DateTime.utc(2026, 9, 6, 18);

      expect(CampusClock.campusWeekday(earlyMondayInVietnam), DateTime.monday);
      expect(
        CampusClock.startOfCampusWeekUtc(earlyMondayInVietnam),
        DateTime.utc(2026, 9, 6, 17),
      );
    });

    test('projects schedule minutes from campus local midnight', () {
      final weekStart = CampusClock.startOfCampusWeekUtc(
        DateTime.utc(2026, 9, 7),
      );

      expect(
        CampusClock.dateForCampusWeekday(
          weekStart,
          weekday: DateTime.monday,
          minuteOfDay: 570,
        ),
        DateTime.utc(2026, 9, 7, 2, 30),
      );
    });
  });

  group('GpaCalculator', () {
    test(
      'calculates weighted GPA and earned credits with the standard policy',
      () {
        final result = const GpaCalculator().calculate([
          const GradeCourseInput(credits: 3, finalScore: 8.7),
          const GradeCourseInput(credits: 4, finalScore: 7.2),
          const GradeCourseInput(credits: 2, finalScore: 3.9),
        ]);

        expect(result.gpa, 2.67);
        expect(result.attemptedCredits, 9);
        expect(result.earnedCredits, 7);
      },
    );

    test('changing grading policy changes GPA without changing UI code', () {
      const courses = [
        GradeCourseInput(credits: 3, finalScore: 8.7),
        GradeCourseInput(credits: 3, finalScore: 5.9),
      ];

      final standard = const GpaCalculator().calculate(courses);
      final strict = const GpaCalculator(
        policy: StrictFourPointPolicy(),
      ).calculate(courses);

      expect(standard.gpa, isNot(strict.gpa));
      expect(standard.earnedCredits, 6);
      expect(strict.earnedCredits, 3);
    });

    test('ignores zero-credit courses and handles an empty semester', () {
      final result = const GpaCalculator().calculate([
        const GradeCourseInput(credits: 0, finalScore: 10),
      ]);

      expect(result.gpa, 0);
      expect(result.attemptedCredits, 0);
      expect(result.earnedCredits, 0);
    });
  });
}
