import 'package:life_admin/backend/shared/dtos.dart';
import 'package:life_admin/backend/shared/tree_node.dart';
import 'package:life_admin/backend/tasks/dtos.dart';
import 'package:life_admin/backend/tasks/monthweek.dart';
import 'package:life_admin/backend/tasks/repetition_kind_features.dart';
import 'package:life_admin/backend/tasks/tasks_filter.dart';
import 'package:life_admin/backend/tasks/tasks_manager_wrapped.dart';
import 'package:life_admin/backend/tasks/weekday.dart';

class TasksManager {
  final TasksManagerWrapped tasksManagerWrapped;

  TasksManager({
    required this.tasksManagerWrapped,
  });

  List<TaskDto> getTasks({TasksFilterDto? filter, String? sortedBy}) {
    late final TasksFilter? filterDomain;
    if (filter != null) {
      filterDomain = TasksFilter.fromDto(filter);
    } else {
      filterDomain = null;
    }

    return tasksManagerWrapped
        .getTasks(filterDomain, sortedBy: sortedBy)
        .map((e) => e.toDto())
        .toList();
  }

  Duration getTasksSum({TasksFilterDto? filter}) {
    late final TasksFilter? filterDomain;
    if (filter != null) {
      filterDomain = TasksFilter.fromDto(filter);
    } else {
      filterDomain = null;
    }

    return tasksManagerWrapped.getTasksSum(filterDomain);
  }

  List<WeekdayDto> getDailyWeekdays() => RepetitionKindFeatures.dailyWeekdays
      .map((weekday) => weekdayToDto(weekday))
      .toList();

  List<MonthweekDto> getDailyMonthweeks() =>
      RepetitionKindFeatures.dailyMonthweeks
          .map((monthweek) => monthweekToDto(monthweek))
          .toList();

  List<WeekdayDto> getWorkdayWeekdays() =>
      RepetitionKindFeatures.workdayWeekdays
          .map((weekday) => weekdayToDto(weekday))
          .toList();

  List<MonthweekDto> getWorkdayMonthweeks() =>
      RepetitionKindFeatures.workdayMonthweeks
          .map((monthweek) => monthweekToDto(monthweek))
          .toList();

  List<MonthweekDto> getWeeklyMonthweeks() =>
      RepetitionKindFeatures.weeklyMonthweeks
          .map((monthweek) => monthweekToDto(monthweek))
          .toList();

  TagTreeNodeDto getTasksTags() {
    return TreeNode.from(
        tasksManagerWrapped.getTasksTags(), (data) => data.toDto());
  }

  WeekdayDto getCurrentWeekday() {
    return weekdayToDto(tasksManagerWrapped.getCurrentWeekday());
  }

  MonthweekDto getCurrentMonthweek() {
    return monthweekToDto(tasksManagerWrapped.getCurrentMonthweek());
  }
}
