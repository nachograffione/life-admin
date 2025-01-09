import 'package:flutter/material.dart';
import 'package:life_admin/backend/shared/tree_node.dart';
import 'package:life_admin/frontend/app_state/app_state.dart';
import 'package:life_admin/frontend/app_state/tag_checkbox_state.dart';
import 'package:life_admin/frontend/finances/budget/budget_filter/custom_checkbox.dart';
import 'package:provider/provider.dart';

class TagsFilter extends StatelessWidget {
  const TagsFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        if (appState.financesManager == null ||
            appState.budgetFilter == null ||
            appState.financesRootTag == null ||
            appState.rootTagState == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tags', style: TextStyle(fontSize: 14)),
            Container(
                padding: const EdgeInsets.all(8),
                width: 280,
                child: createCheckboxTree(appState.rootTagState!, appState, 0)),
          ],
        );
      },
    );
  }

  Widget createCheckboxTree(
      TreeNode<TagCheckboxState> node, AppState appState, int indentLevel) {
    final listTile = CustomCheckbox(
      indentLevel: indentLevel,
      isChecked: node.data.isChecked,
      onChanged: (value) {
        node.data.isChecked = value!;
        node.apply((data) => data.isChecked = value);
        appState.onSetTagState();
        appState.onSetBudgetFilter();
      },
      child: Text(node.data.tag.name),
    );

    if (node.isLeaf()) {
      return listTile;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listTile,
        ...node.children
            .map(
                (child) => createCheckboxTree(child, appState, indentLevel + 1))
            .toList(),
      ],
    );
  }
}
