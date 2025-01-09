import 'package:life_admin/backend/tasks/dtos.dart';
import 'package:life_admin/backend/tasks/monthweek.dart';
import 'package:life_admin/backend/tasks/repetition_kind.dart';
import 'package:life_admin/backend/tasks/task.dart';
import 'package:life_admin/backend/tasks/weekday.dart';

class TasksFilter {
  RepetitionKind repetitionKind;
  Weekday? weekday;
  Monthweek? monthweek;

  TasksFilter({
    required this.repetitionKind,
    this.weekday,
    this.monthweek,
  }) {
    assert(
      repetitionKind == RepetitionKind.daily &&
              (weekday == null && monthweek == null) ||
          repetitionKind == RepetitionKind.workday &&
              (weekday == null && monthweek == null) ||
          repetitionKind == RepetitionKind.weekly &&
              (weekday != null && monthweek == null) ||
          repetitionKind == RepetitionKind.monthly &&
              (weekday != null && monthweek != null),
    );
  }

  static TasksFilter fromDto(TasksFilterDto dto) {
    return TasksFilter(
      repetitionKind: repetitionKindFromDto(dto.repetitionKind),
      weekday: dto.weekday == null ? null : weekdayFromDto(dto.weekday!),
      monthweek:
          dto.monthweek == null ? null : monthweekFromDto(dto.monthweek!),
    );
  }

  bool matches(Task task) {
    if (task.datetimeRule.repetitionKind != repetitionKind) {
      return false;
    }
    if (repetitionKind == RepetitionKind.weekly ||
        repetitionKind == RepetitionKind.monthly) {
      if (weekday != null && !task.datetimeRule.weekdays.contains(weekday)) {
        return false;
      }
    }
    if (repetitionKind == RepetitionKind.monthly) {
      if (monthweek != null &&
          !task.datetimeRule.monthweeks.contains(monthweek)) {
        return false;
      }
    }

    return true;
  }
}
