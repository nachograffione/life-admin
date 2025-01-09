import 'package:life_admin/backend/finances/pay_period.dart';
import 'package:life_admin/backend/finances/work_arrangement.dart';
import 'package:life_admin/backend/finances/working_time_ratios.dart';
import 'package:test/test.dart';

void main() {
  group('getWorkingHoursOf', () {
    final WorkingTimeRatios workingTimeRatios = WorkingTimeRatios(
      minPartTimeHoursADay: 4,
      maxPartTimeHoursADay: 6,
      fullTimeHoursADay: 8,
      daysAWeek: 5,
      weeksAMonth: 4.3,
      monthsAYear: 12,
    );

    test(
        'Given invalid workArrangement value, when getWorkingHoursOf, then get exception',
        () {
      expect(
          () => workingTimeRatios.getWorkingHoursOf(
              WorkArrangement.freelance, PayPeriod.weekly),
          throwsException);
    });
    test(
        'Given invalid payPeriod value, when getWorkingHoursOf, then get exception',
        () {
      expect(
          () => workingTimeRatios.getWorkingHoursOf(
              WorkArrangement.minPartTime, PayPeriod.hourly),
          throwsException);
    });
    test('Given valid values, when getWorkingHoursOf, then get expected result',
        () {
      expect(
          workingTimeRatios.getWorkingHoursOf(
              WorkArrangement.minPartTime, PayPeriod.monthly),
          4 * 5 * 4.3);
    });
  });
}
