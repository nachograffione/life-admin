import 'package:flutter/material.dart';
import 'package:life_admin/backend/tasks/dtos.dart';
import 'package:life_admin/frontend/app_state/app_state.dart';
import 'package:life_admin/frontend/shared/heading.dart';
import 'package:life_admin/frontend/tasks/task_widget_summary.dart';
import 'package:life_admin/frontend/utils.dart';
import 'package:provider/provider.dart';

class MonthlyTasksTable extends StatelessWidget {
  const MonthlyTasksTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      if (appState.tasksManager == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final List<List<Widget>> subtables = [];
      for (var monthweek in monthweekDtoValues()) {
        subtables.add([]);
        for (var weekday in WeekdayDto.values) {
          final tasksByWeekdayAndMonthweek = appState.tasksManager!.getTasks(
            filter: TasksFilterDto(
              repetitionKind: RepetitionKindDto.monthly,
              weekday: weekday,
              monthweek: monthweek,
            ),
            sortedBy: 'startsAt',
          );

          subtables.last.add(_buildTasksByWeekdayAndMonthweek(
            tasksByWeekdayAndMonthweek,
            weekday,
            monthweek,
          ));
        }
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: subtables
            .map((subtable) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: subtable,
                ))
            .toList(),
      );
    });
  }

  Widget _buildTasksByWeekdayAndMonthweek(
          List<TaskDto> tasks, WeekdayDto weekday, MonthweekDto monthweek) =>
      SizedBox(
        height: 200,
        width: 270,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Heading(
                data:
                    "${monthweek.toString()}|${shortForm(enumToString(weekday))}",
                level: 3,
              ),
            ),
            ...tasks.map((task) => TaskWidgetSummary(data: task)).toList(),
          ],
        ),
      );
}
