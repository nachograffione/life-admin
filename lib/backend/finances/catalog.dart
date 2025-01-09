import 'package:life_admin/backend/finances/catalog_entry.dart';
import 'package:life_admin/backend/finances/inflation_calculator.dart';

class Catalog {
  final List<CatalogEntry> entries;

  Catalog({required this.entries});

  void updatePrices(InflationCalculator inflationCalculator) {
    for (var entry in entries) {
      entry.updatePrice(inflationCalculator);
    }
  }

  List<CatalogEntry> getEntries() {
    return entries;
  }
}
