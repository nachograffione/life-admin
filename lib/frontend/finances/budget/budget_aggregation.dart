import 'package:flutter/material.dart';
import 'package:life_admin/frontend/app_state/app_state.dart';
import 'package:life_admin/frontend/shared/price_widget.dart';
import 'package:provider/provider.dart';

class BudgetAggregation extends StatelessWidget {
  const BudgetAggregation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        if (appState.financesManager == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final entriesPriceSum = appState.financesManager!
            .getBudgetEntriesSum(filter: appState.budgetFilter);

        return Container(
          color: Colors.yellow.shade100,
          child: Row(
            children: [
              const SizedBox(width: 300),
              PriceWidget(price: entriesPriceSum),
            ],
          ),
        );
      },
    );
  }
}
