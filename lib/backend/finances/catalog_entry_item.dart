import 'package:life_admin/backend/finances/catalog_entry.dart';
import 'package:life_admin/backend/finances/dtos.dart';

class CatalogEntryItem {
  final double factor;
  final CatalogEntry catalogEntry;

  CatalogEntryItem({required this.factor, required this.catalogEntry});

  CatalogEntryItemDto toDto() {
    return CatalogEntryItemDto(
      factor: factor,
      catalogEntry: catalogEntry.toDtoAsReference(),
    );
  }
}
