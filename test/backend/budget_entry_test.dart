import 'package:life_admin/backend/finances/budget_entry.dart';
import 'package:life_admin/backend/finances/budget_entry_type.dart';
import 'package:life_admin/backend/finances/catalog_entry.dart';
import 'package:life_admin/backend/finances/catalog_entry_item.dart';
import 'package:life_admin/backend/finances/price.dart';
import 'package:life_admin/backend/shared/metadata.dart';
import 'package:life_admin/backend/shared/tag.dart';
import 'package:life_admin/backend/shared/tag_manager.dart';
import 'package:life_admin/backend/shared/tag_tree_node.dart';
import 'package:test/test.dart';

void main() {
  test(
      'Given a composite budget entry, when getPrice, then get the expected result',
      () {
    final root = TagTreeNode(data: Tag(name: 'root'));
    final catalogEntryA = CatalogEntry(
      metadata: Metadata(
        name: 'A',
        description: '',
      ),
      price: Price(
        value: 10,
        absoluteError: 1,
      ),
      lastPriceUpdate: DateTime.now(),
    );
    final catalogEntryB = CatalogEntry(
      metadata: Metadata(
        name: 'B',
        description: '',
      ),
      price: Price(
        value: 20,
        absoluteError: 2,
      ),
      lastPriceUpdate: DateTime.now(),
    );

    final budgetEntry = BudgetEntry(
      metadata: Metadata(
        name: 'AB',
        description: 'A + 2B',
        tagManager: TagManager(
          tags: [root],
        ),
      ),
      type: BudgetEntryType.expense,
      catalogEntryItems: [
        CatalogEntryItem(
          factor: 1,
          catalogEntry: catalogEntryA,
        ),
        CatalogEntryItem(
          factor: 2,
          catalogEntry: catalogEntryB,
        )
      ],
    );

    expect(budgetEntry.getPrice(), Price(value: 50, absoluteError: 5));
  });
}
