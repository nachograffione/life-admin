import 'package:life_admin/backend/finances/dtos.dart';

enum BudgetEntryType {
  expense,
  income,
}

BudgetEntryTypeDto budgetEntryTypeToDto(BudgetEntryType value) {
  switch (value) {
    case BudgetEntryType.expense:
      return BudgetEntryTypeDto.expense;
    case BudgetEntryType.income:
      return BudgetEntryTypeDto.income;
    default:
      throw Exception('Unknown budget entry type: $value');
  }
}

BudgetEntryType budgetEntryTypeFromDto(BudgetEntryTypeDto value) {
  switch (value) {
    case BudgetEntryTypeDto.expense:
      return BudgetEntryType.expense;
    case BudgetEntryTypeDto.income:
      return BudgetEntryType.income;
    default:
      throw Exception('Unknown budget entry type: $value');
  }
}
