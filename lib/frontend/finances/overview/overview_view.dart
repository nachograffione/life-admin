import 'package:flutter/material.dart';
import 'package:life_admin/frontend/finances/overview/inflation_rate.dart';
import 'package:life_admin/frontend/shared/custom_scrollable.dart';
import 'package:life_admin/frontend/shared/heading.dart';
import 'package:life_admin/frontend/tasks/current_day_tasks_table.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollable(
      scrollDirection: Axis.vertical,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const InflationRate(),
        ),
        Heading(data: 'Current day', level: 1),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: CurrentDayTasksTable(),
        ),
      ],
    );
  }
}
