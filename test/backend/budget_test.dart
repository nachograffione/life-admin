import 'package:life_admin/backend/finances/budget.dart';
import 'package:life_admin/backend/finances/budget_entry.dart';
import 'package:life_admin/backend/finances/budget_entry_type.dart';
import 'package:life_admin/backend/finances/budget_filter.dart';
import 'package:life_admin/backend/finances/catalog_entry.dart';
import 'package:life_admin/backend/finances/catalog_entry_item.dart';
import 'package:life_admin/backend/finances/price.dart';
import 'package:life_admin/backend/shared/metadata.dart';
import 'package:life_admin/backend/shared/tag.dart';
import 'package:life_admin/backend/shared/tag_manager.dart';
import 'package:life_admin/backend/shared/tag_tree_node.dart';
import 'package:test/test.dart';

void main() {
  group('getEntries using filter', () {
    final root = TagTreeNode(data: Tag(name: 'root'));
    final tag1 = TagTreeNode(data: Tag(name: 'Tag1'));
    final tag2 = TagTreeNode(data: Tag(name: 'Tag2'));
    root.addChild(tag1);
    root.addChild(tag2);

    final catalogEntry = CatalogEntry(
      metadata: Metadata(
        name: 'a',
        description: '',
        tagManager: TagManager(),
      ),
      price: Price(value: 100, absoluteError: 10),
      lastPriceUpdate: DateTime.now(),
    );

    final budgetEntryA = BudgetEntry(
      metadata: Metadata(
        name: 'A',
        description: '',
        tagManager: TagManager(
          tags: [
            tag1,
            tag2,
          ],
        ),
      ),
      type: BudgetEntryType.income,
      catalogEntryItems: [
        CatalogEntryItem(
          catalogEntry: catalogEntry,
          factor: 1,
        )
      ],
    );

    final budgetEntry2A = BudgetEntry(
      metadata: Metadata(
        name: '2A',
        description: '',
        tagManager: TagManager(
          tags: [
            tag1,
          ],
        ),
      ),
      type: BudgetEntryType.income,
      catalogEntryItems: [
        CatalogEntryItem(
          catalogEntry: catalogEntry,
          factor: 2,
        )
      ],
    );

    final budgetEntry3A = BudgetEntry(
      metadata: Metadata(
        name: '3A',
        description: '',
        tagManager: TagManager(
          tags: [
            tag1,
          ],
        ),
      ),
      type: BudgetEntryType.expense,
      catalogEntryItems: [
        CatalogEntryItem(
          catalogEntry: catalogEntry,
          factor: 3,
        ),
      ],
    );
    final budgetEntry4A = BudgetEntry(
      metadata: Metadata(
        name: '4A',
        description: '',
        tagManager: TagManager(
          tags: [
            tag2,
          ],
        ),
      ),
      type: BudgetEntryType.expense,
      catalogEntryItems: [
        CatalogEntryItem(
          catalogEntry: catalogEntry,
          factor: 4,
        ),
      ],
    );

    final budget = Budget(
      entries: [budgetEntryA, budgetEntry2A, budgetEntry3A, budgetEntry4A],
    );

    test('Given minPrice, when getEntries, then get expected result', () {
      expect(budget.getEntries(budgetFilter: BudgetFilter(maxPrice: 350)),
          [budgetEntry4A]);
    });
    test('Given maxPrice, when getEntries, then get expected result', () {
      expect(budget.getEntries(budgetFilter: BudgetFilter(minPrice: 150)),
          [budgetEntryA]);
    });
    test('Given 1 type, when getEntries, then get expected result', () {
      expect(
          budget.getEntries(
              budgetFilter: BudgetFilter(types: [BudgetEntryType.income])),
          [budgetEntryA, budgetEntry2A]);
    });
    test('Given n types, when getEntries, then get expected result', () {
      expect(
          budget.getEntries(
              budgetFilter: BudgetFilter(
                  types: [BudgetEntryType.income, BudgetEntryType.expense])),
          [budgetEntryA, budgetEntry2A, budgetEntry3A, budgetEntry4A]);
    });
    test('Given 1 tag, when getEntries, then get expected result', () {
      expect(budget.getEntries(budgetFilter: BudgetFilter(tags: [tag2])),
          [budgetEntryA, budgetEntry4A]);
    });
    test('Given n tags, when getEntries, then get expected result', () {
      expect(budget.getEntries(budgetFilter: BudgetFilter(tags: [tag1, tag2])),
          [budgetEntryA, budgetEntry2A, budgetEntry3A, budgetEntry4A]);
    });
    test('Given all params, when getEntries, then get expected result', () {
      expect(
          budget.getEntries(
              budgetFilter: BudgetFilter(
                  maxPrice: 150,
                  types: [BudgetEntryType.income],
                  tags: [tag1])),
          [budgetEntry2A]);
    });
  });
}
