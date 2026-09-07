class CampusClock {
  const CampusClock._();

  static const vietnamOffset = Duration(hours: 7);

  static DateTime nowUtc() => DateTime.now().toUtc();

  static int campusWeekday(DateTime value, {Duration offset = vietnamOffset}) =>
      value.toUtc().add(offset).weekday;

  static int campusMinuteOfDay(
    DateTime value, {
    Duration offset = vietnamOffset,
  }) {
    final campus = value.toUtc().add(offset);
    return campus.hour * 60 + campus.minute;
  }

  static DateTime startOfCampusDayUtc(
    DateTime value, {
    Duration offset = vietnamOffset,
  }) {
    final campus = value.toUtc().add(offset);
    return DateTime.utc(campus.year, campus.month, campus.day).subtract(offset);
  }

  static DateTime startOfCampusWeekUtc(
    DateTime value, {
    Duration offset = vietnamOffset,
  }) {
    final day = startOfCampusDayUtc(value, offset: offset);
    return day.subtract(Duration(days: campusWeekday(day, offset: offset) - 1));
  }

  static DateTime dateForCampusWeekday(
    DateTime campusWeekStartUtc, {
    required int weekday,
    required int minuteOfDay,
  }) =>
      campusWeekStartUtc.add(Duration(days: weekday - 1, minutes: minuteOfDay));

  static bool isSameCampusDay(
    DateTime left,
    DateTime right, {
    Duration offset = vietnamOffset,
  }) =>
      startOfCampusDayUtc(left, offset: offset) ==
      startOfCampusDayUtc(right, offset: offset);

  static String campusDateKey(
    DateTime value, {
    Duration offset = vietnamOffset,
  }) {
    final campus = value.toUtc().add(offset);
    final year = campus.year.toString().padLeft(4, '0');
    final month = campus.month.toString().padLeft(2, '0');
    final day = campus.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
