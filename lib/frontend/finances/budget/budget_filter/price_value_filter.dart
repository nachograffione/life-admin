import 'package:flutter/material.dart';
import 'package:life_admin/frontend/app_state/app_state.dart';
import 'package:provider/provider.dart';

class PriceValueFilter extends StatelessWidget {
  const PriceValueFilter({super.key});

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
            const Text('Price value', style: TextStyle(fontSize: 14)),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 70,
                  padding: const EdgeInsets.only(right: 2),
                  child: TextFormField(
                    initialValue: appState.budgetFilter!.maxPrice == null
                        ? ''
                        : appState.budgetFilter!.maxPrice.toString(),
                    style: const TextStyle(fontSize: 14),
                    decoration: const InputDecoration(hintText: 'From'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      appState.budgetFilter!.maxPrice = double.tryParse(value);
                      appState.onSetBudgetFilter();
                    },
                  ),
                ),
                Container(
                  height: 40,
                  width: 70,
                  padding: const EdgeInsets.only(left: 2),
                  child: TextFormField(
                    initialValue: appState.budgetFilter!.minPrice == null
                        ? ''
                        : appState.budgetFilter!.minPrice.toString(),
                    style: const TextStyle(fontSize: 14),
                    decoration: const InputDecoration(hintText: 'To'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      appState.budgetFilter!.minPrice = double.tryParse(value);
                      appState.onSetBudgetFilter();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
