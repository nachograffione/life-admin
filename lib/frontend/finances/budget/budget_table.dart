import 'package:flutter/material.dart';
import 'package:life_admin/frontend/app_state/app_state.dart';
import 'package:life_admin/frontend/finances/budget/budget_entry_widget.dart';
import 'package:provider/provider.dart';

class BudgetTable extends StatelessWidget {
  const BudgetTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      if (appState.financesManager == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final entries = appState.financesManager!
          .getBudgetEntries(budgetFilter: appState.budgetFilter);

      return Column(
        children:
            entries.map((entry) => BudgetEntryWidget(data: entry)).toList(),
      );
    });
  }
}
