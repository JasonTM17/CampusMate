/// Pure Dart GPA calculation utilities shared by server and mobile tests.
///
/// The UI receives already-computed values from the backend, but keeping this
/// policy injectable makes it impossible to hard-code GPA behavior in screens.
class GpaCalculator {
  const GpaCalculator({this.policy = const StandardFourPointPolicy()});

  final GradingPolicy policy;

  GpaResult calculate(Iterable<GradeCourseInput> courses) {
    var attemptedCredits = 0;
    var earnedCredits = 0;
    var weightedPoints = 0.0;

    for (final course in courses) {
      if (course.credits <= 0) continue;
      final gradePoint = policy.gradePointFor(course.finalScore);
      attemptedCredits += course.credits;
      if (policy.isPassing(course.finalScore)) {
        earnedCredits += course.credits;
      }
      weightedPoints += gradePoint * course.credits;
    }

    final gpa = attemptedCredits == 0 ? 0.0 : weightedPoints / attemptedCredits;
    return GpaResult(
      gpa: double.parse(gpa.toStringAsFixed(2)),
      attemptedCredits: attemptedCredits,
      earnedCredits: earnedCredits,
    );
  }
}

abstract interface class GradingPolicy {
  double gradePointFor(double score);
  bool isPassing(double score);
  String letterFor(double score);
}

class StandardFourPointPolicy implements GradingPolicy {
  const StandardFourPointPolicy();

  @override
  double gradePointFor(double score) {
    if (score >= 8.5) return 4.0;
    if (score >= 8.0) return 3.5;
    if (score >= 7.0) return 3.0;
    if (score >= 6.5) return 2.5;
    if (score >= 5.5) return 2.0;
    if (score >= 5.0) return 1.5;
    if (score >= 4.0) return 1.0;
    return 0.0;
  }

  @override
  bool isPassing(double score) => score >= 4.0;

  @override
  String letterFor(double score) {
    if (score >= 8.5) return 'A';
    if (score >= 8.0) return 'B+';
    if (score >= 7.0) return 'B';
    if (score >= 6.5) return 'C+';
    if (score >= 5.5) return 'C';
    if (score >= 5.0) return 'D+';
    if (score >= 4.0) return 'D';
    return 'F';
  }
}

class StrictFourPointPolicy implements GradingPolicy {
  const StrictFourPointPolicy();

  @override
  double gradePointFor(double score) {
    if (score >= 9.0) return 4.0;
    if (score >= 8.0) return 3.0;
    if (score >= 7.0) return 2.0;
    if (score >= 6.0) return 1.0;
    return 0.0;
  }

  @override
  bool isPassing(double score) => score >= 6.0;

  @override
  String letterFor(double score) {
    if (score >= 9.0) return 'A';
    if (score >= 8.0) return 'B';
    if (score >= 7.0) return 'C';
    if (score >= 6.0) return 'D';
    return 'F';
  }
}

class GradeCourseInput {
  const GradeCourseInput({required this.credits, required this.finalScore});

  final int credits;
  final double finalScore;
}

class GpaResult {
  const GpaResult({
    required this.gpa,
    required this.attemptedCredits,
    required this.earnedCredits,
  });

  final double gpa;
  final int attemptedCredits;
  final int earnedCredits;
}
