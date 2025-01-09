import 'package:life_admin/backend/finances/pay_period.dart';
import 'package:life_admin/backend/finances/work_arrangement.dart';

class WorkingTimeRatios {
  final double minPartTimeHoursADay;
  final double maxPartTimeHoursADay;
  final double fullTimeHoursADay;

  final double daysAWeek;
  final double weeksAMonth;
  final double monthsAYear;

  WorkingTimeRatios({
    required this.minPartTimeHoursADay,
    required this.maxPartTimeHoursADay,
    required this.fullTimeHoursADay,
    required this.daysAWeek,
    required this.weeksAMonth,
    required this.monthsAYear,
  });

  double getWorkingHoursOf(
      WorkArrangement workArrangement, PayPeriod payPeriod) {
    return _getDaysOf(payPeriod) * _getWorkingHoursADayOf(workArrangement);
  }

  double _getWorkingHoursADayOf(WorkArrangement workArrangement) {
    switch (workArrangement) {
      case WorkArrangement.freelance:
        throw Exception(
            'WorkArrangement.freelance doesn\'t have a specific working hours amount.');
      case WorkArrangement.minPartTime:
        return minPartTimeHoursADay;
      case WorkArrangement.maxPartTime:
        return maxPartTimeHoursADay;
      case WorkArrangement.fullTime:
        return fullTimeHoursADay;
    }
  }

  double _getDaysOf(PayPeriod payPeriod) {
    switch (payPeriod) {
      case PayPeriod.hourly:
        throw Exception(
            'PayPeriod.hourly doesn\'t have a specific days amount.');
      case PayPeriod.daily:
        return 1;
      case PayPeriod.weekly:
        return daysAWeek;
      case PayPeriod.monthly:
        return daysAWeek * weeksAMonth;
      case PayPeriod.annually:
        return daysAWeek * weeksAMonth * monthsAYear;
    }
  }
}
