import 'package:flutter/material.dart';
import 'package:life_admin/frontend/tasks/timetable/timetable_block_data.dart';

class TimetableDescription extends StatelessWidget {
  final TimetableBlockData block;
  final double fontSize;

  const TimetableDescription({
    super.key,
    required this.block,
    this.fontSize = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${block.startsAt} ${block.name}',
      style: TextStyle(
        fontSize: fontSize,
      ),
    );
  }
}
