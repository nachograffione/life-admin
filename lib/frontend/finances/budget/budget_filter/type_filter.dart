import 'package:flutter/material.dart';
import 'package:life_admin/backend/finances/dtos.dart';
import 'package:life_admin/frontend/app_state/app_state.dart';
import 'package:life_admin/frontend/finances/budget/budget_entry_type_widget.dart';
import 'package:life_admin/frontend/finances/budget/budget_filter/custom_checkbox.dart';
import 'package:provider/provider.dart';

class TypeFilter extends StatelessWidget {
  const TypeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        if (appState.financesManager == null || appState.budgetFilter == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Type', style: TextStyle(fontSize: 14)),
            Container(
              padding: const EdgeInsets.all(8),
              width: 180,
              child: Column(
                children: BudgetEntryTypeDto.values
                    .map(
                      (e) => CustomCheckbox(
                        indentLevel: 0,
                        isChecked: appState.budgetFilter!.types == null ||
                            appState.budgetFilter!.types!.contains(e),
                        onChanged: (value) {
                          if (appState.budgetFilter!.types == null) {
                            appState.budgetFilter!.types =
                                BudgetEntryTypeDto.values.toList();
                          }
                          if (value!) {
                            appState.budgetFilter!.types!.add(e);
                          } else {
                            appState.budgetFilter!.types!.remove(e);
                          }
                          appState.onSetBudgetFilter();
                        },
                        child: BudgetEntryTypeWidget(data: e),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
