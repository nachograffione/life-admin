import 'package:life_admin/backend/finances/dtos.dart';
import 'package:life_admin/backend/finances/inflation_calculator.dart';
import 'package:life_admin/backend/finances/price.dart';
import 'package:life_admin/backend/finances/priceable.dart';
import 'package:life_admin/backend/shared/datetime_manager.dart';
import 'package:life_admin/backend/shared/metadata.dart';

class CatalogEntry implements Priceable {
  final bool adjustForInflation;
  final Metadata metadata;
  late DateTime lastPriceUpdate;
  Price price;

  CatalogEntry({
    required this.metadata,
    required this.price,
    required this.lastPriceUpdate,
    this.adjustForInflation = false,
  });

  @override
  Price getPrice() {
    return price;
  }

  void updatePrice(InflationCalculator inflationCalculator) {
    if (adjustForInflation) {
      final value = price.value *
          (1 +
              inflationCalculator.getInflationRateFromDatetimes(
                lastPriceUpdate,
                DefaultDateTimeManager().now(),
              ));
      final absoluteError = price.absoluteError *
          (1 +
              inflationCalculator.getInflationRateFromDatetimes(
                lastPriceUpdate,
                DefaultDateTimeManager().now(),
              ));

      price = Price(
        value: value,
        absoluteError: absoluteError,
      );
    }
  }

  String toDtoAsReference() {
    return metadata.name;
  }

  CatalogEntryDto toDto() {
    return CatalogEntryDto(
      metadata: metadata.toDto(),
      price: getPrice().toDto(),
      lastPriceUpdate: lastPriceUpdate,
      adjustForInflation: adjustForInflation,
    );
  }
}
