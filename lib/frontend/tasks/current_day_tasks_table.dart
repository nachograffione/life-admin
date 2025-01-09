import 'package:flutter/material.dart';
import 'package:life_admin/backend/tasks/dtos.dart';
import 'package:life_admin/backend/tasks/time_of_day.dart' as tod;
import 'package:life_admin/frontend/app_state/app_state.dart';
import 'package:life_admin/frontend/shared/heading.dart';
import 'package:life_admin/frontend/tasks/task_checkbox.dart';
import 'package:life_admin/frontend/tasks/task_widget_summary.dart';
import 'package:life_admin/frontend/tasks/timetable/timetable.dart';
import 'package:life_admin/frontend/tasks/timetable/timetable_block_data.dart';
import 'package:life_admin/frontend/utils.dart';
import 'package:provider/provider.dart';

class CurrentDayTasksTable extends StatelessWidget {
  const CurrentDayTasksTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      if (appState.tasksManager == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final dailyTasks = appState.tasksManager!.getTasks(
        filter: TasksFilterDto(
          repetitionKind: RepetitionKindDto.daily,
        ),
        sortedBy: 'startsAt',
      );

      final weeklyTasks = appState.tasksManager!.getTasks(
        filter: TasksFilterDto(
          repetitionKind: RepetitionKindDto.weekly,
          weekday: appState.tasksManager!.getCurrentWeekday(),
        ),
        sortedBy: 'startsAt',
      );

      final monthlyTasks = appState.tasksManager!.getTasks(
        filter: TasksFilterDto(
          repetitionKind: RepetitionKindDto.monthly,
          weekday: appState.tasksManager!.getCurrentWeekday(),
          monthweek: appState.tasksManager!.getCurrentMonthweek(),
        ),
        sortedBy: 'startsAt',
      );

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Heading(data: 'Daily', level: 3),
              ..._generateTaskWidgets(dailyTasks),
              Heading(
                  data:
                      'Weekly (${shortForm(enumToString(appState.tasksManager!.getCurrentWeekday()))})',
                  level: 3),
              ..._generateTaskWidgets(weeklyTasks),
              Heading(
                  data:
                      'Monthly (${appState.tasksManager!.getCurrentMonthweek().toString()})',
                  level: 3),
              ..._generateTaskWidgets(monthlyTasks),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 256),
            child: Timetable(
              blocks: _getBlocks([
                ...dailyTasks,
                ...weeklyTasks,
                ...monthlyTasks,
              ]),
              height: 680,
              width: 270,
              timetableStartsAt: const tod.TimeOfDay(hour: 8, minute: 0),
            ),
          )
        ],
      );
    });
  }

  List<Widget> _generateTaskWidgets(List<TaskDto> tasks) {
    return tasks
        .map(
          (task) => Row(
            children: [
              TaskCheckbox(task: task),
              TaskWidgetSummary(data: task),
            ],
          ),
        )
        .toList();
  }

  List<TimetableBlockData> _getBlocks(
    List<TaskDto> tasks,
  ) {
    // TODO: Probably it's not needed
    tasks.sort(
        (a, b) => a.datetimeRule.startsAt.compareTo(b.datetimeRule.startsAt));

    return tasks
        .map((task) => TimetableBlockData(
            name: task.metadata.name,
            startsAt: task.datetimeRule.startsAt,
            endsAt: task.datetimeRule.endsAt))
        .toList();
  }
}
