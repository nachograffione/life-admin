import 'package:life_admin/backend/finances/budget_entry_type.dart';
import 'package:life_admin/backend/finances/catalog_entry_item.dart';
import 'package:life_admin/backend/finances/dtos.dart';
import 'package:life_admin/backend/finances/price.dart';
import 'package:life_admin/backend/finances/priceable.dart';
import 'package:life_admin/backend/shared/metadata.dart';

class BudgetEntry implements Priceable {
  final Metadata metadata;
  final BudgetEntryType type;
  final List<CatalogEntryItem> catalogEntryItems;

  BudgetEntry({
    required this.metadata,
    required this.type,
    required this.catalogEntryItems,
  }) {
    if (metadata.tagManager.tags.isEmpty) {
      throw Exception('At least one tag must be assigned.');
    }
  }

  @override
  Price getPrice() {
    double priceValue = 0;
    double priceAbsoluteError = 0;
    for (CatalogEntryItem item in catalogEntryItems) {
      priceValue += item.factor * item.catalogEntry.getPrice().value;
      priceAbsoluteError +=
          item.factor * item.catalogEntry.getPrice().absoluteError;
    }
    return Price(value: priceValue, absoluteError: priceAbsoluteError);
  }

  Price getSignedPrice() {
    final price = getPrice();

    if (type == BudgetEntryType.expense) {
      return Price(value: -price.value, absoluteError: price.absoluteError);
    }

    return price;
  }

  BudgetEntryDto toDto() {
    return BudgetEntryDto(
      metadata: metadata.toDto(),
      type: budgetEntryTypeToDto(type),
      price: getPrice().toDto(),
      catalogEntryItems: catalogEntryItems.map((e) => e.toDto()).toList(),
    );
  }
}
