import 'package:life_admin/backend/finances/budget.dart';
import 'package:life_admin/backend/finances/budget_filter.dart';
import 'package:life_admin/backend/finances/catalog.dart';
import 'package:life_admin/backend/finances/dtos.dart';
import 'package:life_admin/backend/finances/inflation_calculator.dart';
import 'package:life_admin/backend/finances/inflation_rate_interval.dart';
import 'package:life_admin/backend/shared/dtos.dart';
import 'package:life_admin/backend/shared/tag_tree_node.dart';
import 'package:life_admin/backend/shared/tree_node.dart';

class FinancesManager {
  final Budget budget;
  final Catalog catalog;
  final InflationCalculator inflationCalculator;
  final TagTreeNode tagsTree;

  FinancesManager(
      {required this.budget,
      required this.catalog,
      required this.inflationCalculator,
      required this.tagsTree}) {
    catalog.updatePrices(inflationCalculator);
  }

  double getInflationRate(DateTime reference, InflationRateInterval interval) {
    return inflationCalculator.getInflationRateFromReferenceAndInterval(
        reference, interval);
  }

  List<CatalogEntryDto> getCatalogEntries() {
    return catalog.getEntries().map((e) => e.toDto()).toList();
  }

  List<BudgetEntryDto> getBudgetEntries({BudgetFilterDto? budgetFilter}) {
    late final BudgetFilter? budgetFilterDomain;
    if (budgetFilter != null) {
      budgetFilterDomain = BudgetFilter.fromDto(budgetFilter);
    }

    return budget
        .getEntries(budgetFilter: budgetFilterDomain)
        .map((e) => e.toDto())
        .toList();
  }

  PriceDto getBudgetEntriesSum({BudgetFilterDto? filter}) {
    late final BudgetFilter? budgetFilterDomain;
    if (filter != null) {
      budgetFilterDomain = BudgetFilter.fromDto(filter);
    }

    return budget.getEntriesPriceSum(filter: budgetFilterDomain).toDto();
  }

  TagTreeNodeDto getBudgetTags() {
    return TreeNode.from(tagsTree, (data) => data.toDto());
  }
}
