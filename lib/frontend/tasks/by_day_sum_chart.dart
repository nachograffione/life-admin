import 'package:flutter/material.dart';
import 'package:life_admin/backend/tasks/dtos.dart';
import 'package:life_admin/frontend/app_state/app_state.dart';
import 'package:life_admin/frontend/utils.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DayData {
  final MonthweekDto monthweek;
  final WeekdayDto weekday;
  final List<Duration> values;

  DayData(
    this.monthweek,
    this.weekday,
    this.values,
  );
}

class ByDaySumChart extends StatelessWidget {
  static final stackLabels = ['Daily', 'Workday', 'Weekly', 'Monthly', 'Free'];
  static final stackColors = [
    Colors.blue.shade200,
    Colors.blue.shade500,
    Colors.amber.shade500,
    Colors.deepOrange.shade500,
    Colors.green.shade100,
  ];

  const ByDaySumChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      if (appState.financesManager == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final dayDatas = getDayDatas(appState);

      return SfCartesianChart(
          primaryYAxis: const NumericAxis(
            desiredIntervals: 12,
            minimum: 0,
            maximum: 24,
          ),
          primaryXAxis: const CategoryAxis(
            labelStyle: TextStyle(fontSize: 10),
            desiredIntervals: 31,
          ),
          tooltipBehavior: TooltipBehavior(
            tooltipPosition: TooltipPosition.pointer,
            enable: true,
            format: 'point.y',
            decimalPlaces: 1,
            duration: 1000,
            animationDuration: 100,
          ),
          series: <CartesianSeries>[
            ...List.generate(
              5,
              (i) => StackedColumnSeries<DayData, String>(
                name: stackLabels[i],
                animationDuration: 0,
                color: ByDaySumChart.stackColors[i],
                dataSource: dayDatas,
                enableTooltip: true,
                xValueMapper: (DayData dayData, _) =>
                    "${dayData.monthweek.toString()}\n${shortForm(enumToString(dayData.weekday))}",
                yValueMapper: (DayData dayData, _) =>
                    getValueInHours(dayData.values[i]),
              ),
            )
          ]);
    });
  }

  double getValueInHours(Duration value) {
    return value.inMinutes / 60.0;
  }

  List<DayData> getDayDatas(AppState appState) {
    final dayDatas = <DayData>[];

    final dailyTasksSum = appState.tasksManager!.getTasksSum(
        filter: TasksFilterDto(
      repetitionKind: RepetitionKindDto.daily,
    ));

    for (MonthweekDto monthweek in monthweekDtoValues()) {
      for (WeekdayDto weekday in WeekdayDto.values) {
        final Duration workdayTasksSum;
        if (appState.tasksManager!.getWorkdayWeekdays().contains(weekday)) {
          workdayTasksSum = appState.tasksManager!.getTasksSum(
            filter: TasksFilterDto(
              repetitionKind: RepetitionKindDto.workday,
            ),
          );
        } else {
          workdayTasksSum = Duration.zero;
        }

        final weeklyTasksSum = appState.tasksManager!.getTasksSum(
          filter: TasksFilterDto(
            repetitionKind: RepetitionKindDto.weekly,
            weekday: weekday,
          ),
        );

        final monthlyTasksSum = appState.tasksManager!.getTasksSum(
          filter: TasksFilterDto(
            repetitionKind: RepetitionKindDto.monthly,
            weekday: weekday,
            monthweek: monthweek,
          ),
        );

        final freeTimeSum = const Duration(days: 1) -
            dailyTasksSum -
            workdayTasksSum -
            weeklyTasksSum -
            monthlyTasksSum;

        final dayData = DayData(
          monthweek,
          weekday,
          [
            dailyTasksSum,
            workdayTasksSum,
            weeklyTasksSum,
            monthlyTasksSum,
            freeTimeSum,
          ],
        );
        dayDatas.add(dayData);
      }
    }

    return dayDatas.sublist(0, 32);
  }
}
