import 'package:flutter/material.dart';
import 'package:life_admin/backend/tasks/time_of_day.dart' as tod;

class TimetableHourRow extends StatelessWidget {
  final tod.TimeOfDay startsAt;
  final double fontSize;

  const TimetableHourRow({
    super.key,
    required this.startsAt,
    this.fontSize = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withAlpha(98),
        border: Border.all(width: 1, color: Colors.grey.shade400.withAlpha(98)),
      ),
      child: Text(
        '$startsAt',
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
    );
  }
}
