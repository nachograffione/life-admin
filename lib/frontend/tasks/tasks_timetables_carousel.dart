import 'package:flutter/material.dart';
import 'package:life_admin/backend/tasks/dtos.dart';
import 'package:life_admin/backend/tasks/time_of_day.dart' as tod;
import 'package:life_admin/frontend/app_state/app_state.dart';
import 'package:life_admin/frontend/shared/custom_scrollable.dart';
import 'package:life_admin/frontend/shared/heading.dart';
import 'package:life_admin/frontend/tasks/timetable/timetable.dart';
import 'package:life_admin/frontend/tasks/timetable/timetable_block_data.dart';
import 'package:life_admin/frontend/utils.dart';
import 'package:provider/provider.dart';

class TasksTimetablesCarousel extends StatelessWidget {
  final double timetablesHeight;
  final double timetablesWidth;

  const TasksTimetablesCarousel(
      {super.key,
      required this.timetablesHeight,
      required this.timetablesWidth});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      if (appState.tasksManager == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final dailyBlocks = _getBlocks(appState, RepetitionKindDto.daily);

      return CustomScrollable(
        scrollDirection: Axis.horizontal,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Daily
              Heading(data: 'Daily', level: 2),
              Heading(data: '', level: 3), // Placeholder
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Timetable(
                  blocks: dailyBlocks,
                  height: timetablesHeight,
                  width: timetablesWidth,
                  timetableStartsAt: const tod.TimeOfDay(hour: 8, minute: 0),
                ),
              ),
            ],
          ),
          // Weekly
          ...WeekdayDto.values.map(
            (weekday) {
              final weeklyBlocks = _getBlocks(
                  appState, RepetitionKindDto.weekly,
                  weekday: weekday);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Heading(
                        data: weekday == WeekdayDto.monday ? 'Weekly' : '',
                        level: 2),
                    Heading(data: capitalize(weekday.name), level: 3),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Timetable(
                        blocks: weeklyBlocks,
                        height: timetablesHeight,
                        width: timetablesWidth,
                        timetableStartsAt:
                            const tod.TimeOfDay(hour: 8, minute: 0),
                      ),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        ],
      );
    });
  }

  List<TimetableBlockData> _getBlocks(
    AppState appState,
    RepetitionKindDto repetitionKind, {
    WeekdayDto? weekday,
    MonthweekDto? monthweek,
  }) {
    final tasks = appState.tasksManager!.getTasks(
      filter: TasksFilterDto(
        repetitionKind: repetitionKind,
        weekday: weekday,
        monthweek: monthweek,
      ),
      sortedBy: 'startsAt',
    );

    return tasks
        .map((task) => TimetableBlockData(
            name: task.metadata.name,
            startsAt: task.datetimeRule.startsAt,
            endsAt: task.datetimeRule.endsAt))
        .toList();
  }
}
