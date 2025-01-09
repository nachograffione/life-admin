import 'package:life_admin/backend/shared/dtos.dart';

class PriceDto {
  final double value;
  final double absoluteError;

  PriceDto({required this.value, required this.absoluteError});
}

class InflationIndexDto {
  final DateTime datetime;
  final double value;

  InflationIndexDto({required this.datetime, required this.value});
}

class BudgetEntryDto {
  final MetadataDto metadata;
  final BudgetEntryTypeDto type;
  final PriceDto price;
  final List<CatalogEntryItemDto> catalogEntryItems;

  BudgetEntryDto({
    required this.metadata,
    required this.type,
    required this.price,
    required this.catalogEntryItems,
  });
}

class CatalogEntryDto {
  final MetadataDto metadata;
  final PriceDto price;
  final DateTime lastPriceUpdate;
  final bool adjustForInflation;

  CatalogEntryDto({
    required this.metadata,
    required this.price,
    required this.lastPriceUpdate,
    this.adjustForInflation = false,
  });
}

class CatalogEntryItemDto {
  final double factor;
  final String catalogEntry;

  CatalogEntryItemDto({required this.factor, required this.catalogEntry});
}

class BudgetFilterDto {
  List<TagTreeNodeDto>? tags;
  List<BudgetEntryTypeDto>? types;
  double? minPrice;
  double? maxPrice;

  BudgetFilterDto({
    this.tags,
    this.types,
    this.minPrice,
    this.maxPrice,
  });
}

enum BudgetEntryTypeDto { income, expense }
