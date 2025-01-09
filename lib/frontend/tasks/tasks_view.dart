import 'package:flutter/material.dart';
import 'package:life_admin/frontend/shared/custom_scrollable.dart';
import 'package:life_admin/frontend/shared/heading.dart';
import 'package:life_admin/frontend/tasks/by_day_sum_chart.dart';
import 'package:life_admin/frontend/tasks/current_day_tasks_table.dart';
import 'package:life_admin/frontend/tasks/monthly_tasks_table.dart';
import 'package:life_admin/frontend/tasks/tasks_timetables_carousel.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollable(
      scrollDirection: Axis.vertical,
      children: [
        Heading(data: 'Tasks', level: 1),
        Heading(data: 'Current day', level: 2),
        const CurrentDayTasksTable(),
        const Divider(),
        Heading(data: 'By day sums', level: 2),
        const Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 300,
            width: 1000,
            child: ByDaySumChart(),
          ),
        ),
        const SizedBox(
          height: 600 + 150,
          child: TasksTimetablesCarousel(
            timetablesHeight: 600,
            timetablesWidth: 270,
          ),
        ),
        const SizedBox(
          height: 1000,
          width: 1000,
          child: CustomScrollable(
            scrollDirection: Axis.horizontal,
            children: [
              MonthlyTasksTable(),
            ],
          ),
        ),
      ],
    );
  }
}
