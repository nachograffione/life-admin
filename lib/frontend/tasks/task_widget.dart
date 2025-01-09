import 'package:flutter/material.dart';
import 'package:life_admin/backend/tasks/dtos.dart';
import 'package:life_admin/frontend/shared/metadata_description.dart';
import 'package:life_admin/frontend/shared/metadata_name.dart';
import 'package:life_admin/frontend/utils.dart';

class TaskWidget extends StatelessWidget {
  final TaskDto data;
  const TaskWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 420, child: MetadataName(data.metadata.name)),
          SizedBox(
            width: 170,
            child: _buildWeekdays(data.datetimeRule.weekdays),
          ),
          SizedBox(
            width: 150,
            child: _buildMonthweeks(data.datetimeRule.monthweeks),
          ),
          SizedBox(
              width: 100,
              child: Text(
                  '${data.datetimeRule.startsAt.format(context)} - ${data.datetimeRule.endsAt.format(context)}')),
          Expanded(child: MetadataDescription(data.metadata.description)),
        ],
      ),
    );
  }

  Widget _buildWeekdays(List<WeekdayDto> weekdays) {
    return Row(
      children: WeekdayDto.values.map((weekday) {
        return _buildLetter(
            shortForm(enumToString(weekday)), weekdays.contains(weekday));
      }).toList(),
    );
  }

  Widget _buildMonthweeks(List<MonthweekDto> monthweeks) {
    return Row(
      children: monthweekDtoValues()
          .map((monthweek) => _buildLetter(
              monthweek.toString(), monthweeks.contains(monthweek)))
          .toList(),
    );
  }

  Widget _buildLetter(String letter, bool active) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: active ? Colors.grey.shade200 : Colors.transparent,
        ),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
              color: active ? Colors.black : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
