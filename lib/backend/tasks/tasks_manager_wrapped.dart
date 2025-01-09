import 'package:life_admin/backend/shared/datetime_manager.dart';
import 'package:life_admin/backend/shared/tag_tree_node.dart';
import 'package:life_admin/backend/tasks/monthweek.dart';
import 'package:life_admin/backend/tasks/task.dart';
import 'package:life_admin/backend/tasks/tasks_filter.dart';
import 'package:life_admin/backend/tasks/weekday.dart';

class TasksManagerWrapped {
  final List<Task> tasks;
  final TagTreeNode tagsTree;
  late final DateTimeManager dateTimeManager;

  TasksManagerWrapped({
    required this.tasks,
    required this.tagsTree,
    DateTimeManager? dateTimeManager,
  }) {
    this.dateTimeManager = dateTimeManager ?? DefaultDateTimeManager();
  }

  List<Task> getTasks(TasksFilter? filter, {String? sortedBy}) {
    if (filter == null) {
      return tasks;
    }

    final selectedTasks = tasks.where((task) => filter.matches(task)).toList();

    if (sortedBy == 'startsAt') {
      selectedTasks.sort(
          (a, b) => a.datetimeRule.startsAt.compareTo(b.datetimeRule.startsAt));
    } else if (sortedBy == 'duration') {
      selectedTasks.sort(
          (a, b) => a.datetimeRule.duration.compareTo(b.datetimeRule.duration));
    }

    return selectedTasks;
  }

  Duration getTasksSum(TasksFilter? filter) {
    return getTasks(filter).fold(
      Duration.zero,
      (previousDuration, task) {
        return previousDuration + task.datetimeRule.duration;
      },
    );
  }

  TagTreeNode getTasksTags() {
    return tagsTree;
  }

  Weekday getCurrentWeekday() {
    return weekdayFromInt(dateTimeManager.now().weekday);
  }

  Monthweek getCurrentMonthweek() {
    final now = dateTimeManager.now();
    final firstMondayOfMonth = getFirstMondayOfMonth(now.year, now.month);

    final nowMonthWeek =
        (now.difference(firstMondayOfMonth).inDays / 7).truncate() + 1;

    return nowMonthWeek;
  }

  DateTime getFirstMondayOfMonth(int year, int month) {
    final firstMonthday = DateTime(year, month, 1);

    // Amount of days after previous monday
    final weekdayOffset = firstMonthday.weekday - 1;

    // If firstMonthday weekday is in [monday, thursday] takes previous monday
    // Else (it's in [friday, sunday]) takes next monday
    final nearestMonday = weekdayOffset <= 3
        ? firstMonthday.subtract(Duration(days: weekdayOffset))
        : firstMonthday.add(Duration(days: 7 - weekdayOffset));

    return nearestMonday;
  }
}
