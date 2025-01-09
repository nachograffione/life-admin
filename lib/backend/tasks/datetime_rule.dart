import 'package:collection/collection.dart';
import 'package:life_admin/backend/tasks/dtos.dart';
import 'package:life_admin/backend/tasks/monthweek.dart';
import 'package:life_admin/backend/tasks/repetition_kind.dart';
import 'package:life_admin/backend/tasks/repetition_kind_features.dart';
import 'package:life_admin/backend/tasks/time_of_day.dart';
import 'package:life_admin/backend/tasks/weekday.dart';

class DatetimeRule {
  TimeOfDay startsAt;
  Duration duration;
  List<Weekday> weekdays;
  List<Monthweek> monthweeks;

  DatetimeRule({
    required this.startsAt,
    required this.duration,
    required this.weekdays,
    required this.monthweeks,
  });

  TimeOfDay get endsAt {
    return startsAt.add(duration);
  }

  RepetitionKind get repetitionKind {
    if (const ListEquality<Weekday>()
            .equals(weekdays, RepetitionKindFeatures.dailyWeekdays) &&
        const ListEquality<Monthweek>()
            .equals(monthweeks, RepetitionKindFeatures.dailyMonthweeks)) {
      return RepetitionKind.daily;
    }
    if (const ListEquality<Weekday>()
            .equals(weekdays, RepetitionKindFeatures.workdayWeekdays) &&
        const ListEquality<Monthweek>()
            .equals(monthweeks, RepetitionKindFeatures.workdayMonthweeks)) {
      return RepetitionKind.workday;
    }
    if (const ListEquality<Monthweek>()
        .equals(monthweeks, RepetitionKindFeatures.weeklyMonthweeks)) {
      return RepetitionKind.weekly;
    }
    return RepetitionKind.monthly;
  }

  DatetimeRuleDto toDto() {
    return DatetimeRuleDto(
      duration: duration,
      startsAt: startsAt,
      endsAt: endsAt,
      weekdays: weekdays.map((e) => weekdayToDto(e)).toList(),
      monthweeks: monthweeks.map((e) => monthweekToDto(e)).toList(),
    );
  }
}
