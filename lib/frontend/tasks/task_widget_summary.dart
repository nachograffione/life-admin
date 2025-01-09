import 'package:flutter/material.dart';
import 'package:life_admin/backend/tasks/dtos.dart';
import 'package:life_admin/frontend/shared/metadata_name.dart';
import 'package:life_admin/frontend/utils.dart';

class TaskWidgetSummary extends StatelessWidget {
  final TaskDto data;
  const TaskWidgetSummary({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 230, child: MetadataName(data.metadata.name)),
          SizedBox(
              width: 40,
              child: Text(durationToString(data.datetimeRule.duration))),
        ],
      ),
    );
  }
}
