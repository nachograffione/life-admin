import 'package:flutter/material.dart';
import 'package:life_admin/backend/finances/dtos.dart';

class BudgetEntryTypeWidget extends StatelessWidget {
  final BudgetEntryTypeDto data;
  const BudgetEntryTypeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    switch (data) {
      case BudgetEntryTypeDto.income:
        return Icon(
          Icons.input,
          color: Colors.green[800],
        );
      case BudgetEntryTypeDto.expense:
        return Icon(
          Icons.output,
          color: Colors.red[800],
        );
      default:
        throw Exception('Unknown budget entry type: $data');
    }
  }
}
