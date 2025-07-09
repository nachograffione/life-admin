import 'package:life_admin/backend/tasks/monthweek.dart';
import 'package:life_admin/backend/tasks/weekday.dart';

class RepetitionKindFeatures {
  static const List<Weekday> dailyWeekdays = [
    Weekday.monday,
    Weekday.tuesday,
    Weekday.wednesday,
    Weekday.thursday,
    Weekday.friday,
    Weekday.saturday,
    Weekday.sunday,
  ];

  static const List<Monthweek> dailyMonthweeks = [1, 2, 3, 4, 5];

  static const List<Weekday> workdayWeekdays = [
    Weekday.monday,
    Weekday.tuesday,
    Weekday.wednesday,
    Weekday.thursday,
    Weekday.friday,
  ];

  static const List<Monthweek> workdayMonthweeks = [1, 2, 3, 4, 5];

  static const List<Monthweek> weeklyMonthweeks = [1, 2, 3, 4, 5];
}
