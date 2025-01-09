import 'package:life_admin/backend/shared/dtos.dart';
import 'package:life_admin/backend/tasks/time_of_day.dart';

class TaskDto {
  MetadataDto metadata;
  DatetimeRuleDto datetimeRule;

  TaskDto({
    required this.metadata,
    required this.datetimeRule,
  });
}

class TasksFilterDto {
  RepetitionKindDto repetitionKind;
  WeekdayDto? weekday;
  MonthweekDto? monthweek;

  TasksFilterDto({
    required this.repetitionKind,
    this.weekday,
    this.monthweek,
  });
}

enum RepetitionKindDto {
  daily,
  workday,
  weekly,
  monthly,
}

class DatetimeRuleDto {
  TimeOfDay startsAt;
  Duration duration;
  TimeOfDay endsAt;
  List<WeekdayDto> weekdays;
  List<MonthweekDto> monthweeks;

  DatetimeRuleDto({
    required this.duration,
    required this.startsAt,
    required this.endsAt,
    required this.weekdays,
    required this.monthweeks,
  });
}

enum WeekdayDto {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

WeekdayDto weekdayDtoFromInt(int value) => WeekdayDto.values[value - 1];

typedef MonthweekDto = int;

List<MonthweekDto> monthweekDtoValues() => [1, 2, 3, 4, 5];
