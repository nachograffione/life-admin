import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:life_admin/backend/finances/dtos.dart';
import 'package:life_admin/backend/finances/finances_manager.dart';
import 'package:life_admin/backend/shared/db.dart';
import 'package:life_admin/backend/shared/dtos.dart';
import 'package:life_admin/backend/shared/tree_node.dart';
import 'package:life_admin/backend/tasks/dtos.dart';
import 'package:life_admin/backend/tasks/tasks_manager.dart';
import 'package:life_admin/frontend/app_state/tag_checkbox_state.dart';

class AppState extends ChangeNotifier {
  int activeViewIndex = 0;

  FinancesManager? financesManager;
  BudgetFilterDto? budgetFilter;
  TagTreeNodeDto? financesRootTag;

  // This is necessary because budgetFilter only stores leaves
  TreeNode<TagCheckboxState>? rootTagState;

  TasksManager? tasksManager;
  TagTreeNodeDto? tasksRootTag;

  Map<String, bool> taskIsDone = {};

  AppState();

  Future<void> init() async {
    notifyListeners();
    Future.delayed(const Duration(seconds: 1));
    financesManager = await Db().createFinancesManager();
    budgetFilter = BudgetFilterDto();
    financesRootTag = financesManager!.getBudgetTags();
    rootTagState = TreeNode.from(
      financesRootTag!,
      (tag) => TagCheckboxState(
        tag: tag,
        isChecked: true,
      ),
    );
    tasksManager = await Db().createTasksManager();
    tasksRootTag = tasksManager!.getTasksTags();
    taskIsDone.addEntries(tasksManager!
        .getTasks()
        .map((task) => MapEntry(task.metadata.name, false)));
    notifyListeners();
  }

  void onSetBudgetFilter() {
    notifyListeners();
  }

  void onSetTagState() {
    budgetFilter!.tags = rootTagState!.leaves
        .where((leaf) => leaf.data.isChecked)
        .map((node) => TagTreeNodeDto.from<TagCheckboxState, TagDto>(
            node, (tagCheckboxState) => tagCheckboxState.tag))
        .toList();
    log(budgetFilter!.tags.toString());
  }

  void onSetActiveViewIndex(int index) {
    if (index == 4) {
      init();
    } else {
      activeViewIndex = index;
    }
    notifyListeners();
  }

  void onToggleTask(TaskDto task) {
    taskIsDone[task.metadata.name] = !taskIsDone[task.metadata.name]!;
    notifyListeners();
  }
}
