import 'package:flutter/material.dart';
import 'package:life_admin/backend/tasks/dtos.dart';
import 'package:life_admin/frontend/app_state/app_state.dart';
import 'package:provider/provider.dart';

class TaskCheckbox extends StatelessWidget {
  final TaskDto task;

  const TaskCheckbox({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      if (appState.taskIsDone.isEmpty) {
        return Container();
      }

      return Checkbox(
          value: appState.taskIsDone[task.metadata.name],
          onChanged: (_) {
            appState.onToggleTask(task);
          });
    });
  }
}
