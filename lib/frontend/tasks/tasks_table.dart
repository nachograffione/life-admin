import 'package:flutter/material.dart';
import 'package:life_admin/frontend/app_state/app_state.dart';
import 'package:life_admin/frontend/tasks/task_widget.dart';
import 'package:provider/provider.dart';

class TasksTable extends StatelessWidget {
  const TasksTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      if (appState.financesManager == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final tasks = appState.tasksManager!.getTasks(sortedBy: 'startsAt');

      return Column(
        children: tasks.map((task) => TaskWidget(data: task)).toList(),
      );
    });
  }
}
