import 'package:flutter/material.dart';
import 'package:life_admin/frontend/finances/budget/budget_filter/price_value_filter.dart';
import 'package:life_admin/frontend/finances/budget/budget_filter/tags_filter.dart';
import 'package:life_admin/frontend/finances/budget/budget_filter/type_filter.dart';

class BudgetFilter extends StatelessWidget {
  const BudgetFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 700,
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: PriceValueFilter(),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: TypeFilter(),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: TagsFilter(),
          ),
        ],
      ),
    );
  }
}
