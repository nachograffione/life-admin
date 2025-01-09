import 'package:life_admin/backend/finances/budget_entry.dart';
import 'package:life_admin/backend/finances/budget_filter.dart';
import 'package:life_admin/backend/finances/price.dart';

class Budget {
  final List<BudgetEntry> entries;

  Budget({required this.entries});

  List<BudgetEntry> getEntries({BudgetFilter? budgetFilter}) {
    if (budgetFilter == null) {
      return entries;
    }

    return entries.where((entry) => budgetFilter.matches(entry)).toList();
  }

  Price getEntriesPriceSum({BudgetFilter? filter}) {
    final filteredEntries = getEntries(budgetFilter: filter);
    return filteredEntries.fold(Price(),
        (previousPrice, entry) => previousPrice + entry.getSignedPrice());
  }
}
