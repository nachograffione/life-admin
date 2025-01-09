import 'package:flutter/material.dart';
import 'package:life_admin/frontend/finances/budget/budget_aggregation.dart';
import 'package:life_admin/frontend/finances/budget/budget_filter/budget_filter.dart';
import 'package:life_admin/frontend/finances/budget/budget_table.dart';
import 'package:life_admin/frontend/shared/custom_scrollable.dart';
import 'package:life_admin/frontend/shared/heading.dart';

class BudgetView extends StatelessWidget {
  const BudgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollable(
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Heading(data: 'Budget', level: 1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: BudgetFilter(),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: BudgetTable(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: BudgetAggregation(),
        ),
      ],
    );
  }
}
