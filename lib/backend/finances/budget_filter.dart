import 'package:life_admin/backend/finances/budget_entry.dart';
import 'package:life_admin/backend/finances/budget_entry_type.dart';
import 'package:life_admin/backend/finances/dtos.dart';
import 'package:life_admin/backend/shared/dtos.dart';
import 'package:life_admin/backend/shared/tag.dart';
import 'package:life_admin/backend/shared/tag_tree_node.dart';

class BudgetFilter {
  List<TagTreeNode>? tags;
  List<BudgetEntryType>? types;
  double? minPrice;
  double? maxPrice;

  BudgetFilter({
    this.tags,
    this.types,
    this.minPrice,
    this.maxPrice,
  });

  factory BudgetFilter.fromDto(BudgetFilterDto dto) {
    return BudgetFilter(
      tags: dto.tags
          ?.map((treeNodeTagDto) => TagTreeNode.from<TagDto, Tag>(
              treeNodeTagDto, (tagDto) => Tag.fromDto(tagDto)))
          .toList(),
      types: dto.types?.map((e) => budgetEntryTypeFromDto(e)).toList(),
      minPrice: dto.minPrice,
      maxPrice: dto.maxPrice,
    );
  }

  bool matches(BudgetEntry entry) {
    if (types != null && !types!.contains(entry.type)) {
      return false;
    }

    if (tags != null &&
        !tags!.any((tag) => entry.metadata.tagManager.hasTag(tag))) {
      return false;
    }

    if (minPrice != null && !(entry.getPrice().value < minPrice!)) {
      return false;
    }

    if (maxPrice != null && !(entry.getPrice().value > maxPrice!)) {
      return false;
    }

    return true;
  }
}
