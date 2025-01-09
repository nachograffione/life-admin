import 'package:life_admin/backend/finances/catalog_entry_item.dart';
import 'package:life_admin/backend/finances/pay_period.dart';
import 'package:life_admin/backend/finances/price.dart';
import 'package:life_admin/backend/finances/priceable.dart';
import 'package:life_admin/backend/finances/work_arrangement.dart';
import 'package:life_admin/backend/finances/working_time_ratios.dart';
import 'package:life_admin/backend/shared/metadata.dart';

class Salary implements Priceable {
  final Metadata metadata;
  final WorkingTimeRatios workingTimeRatios;
  final PayPeriod payPeriod;
  final WorkArrangement workArrangement;
  final List<CatalogEntryItem> fullTimeMonthlySalaries;

  Salary({
    required this.metadata,
    required this.workingTimeRatios,
    required this.payPeriod,
    required this.workArrangement,
    required this.fullTimeMonthlySalaries,
  }) {
    if (workArrangement == WorkArrangement.freelance &&
        payPeriod != PayPeriod.hourly) {
      throw Exception('Freelance pay period must be hourly.');
    }
    for (CatalogEntryItem item in fullTimeMonthlySalaries) {
      if (item.factor != 1) {
        throw Exception('All catalog entry items must have a factor of 1.');
      }
    }
  }

  double get workingHours {
    if (workArrangement == WorkArrangement.freelance) {
      return 1;
    }
    return workingTimeRatios.getWorkingHoursOf(workArrangement, payPeriod);
  }

  @override
  Price getPrice() {
    final fullTimeMonthlySalariesPriceAvg = fullTimeMonthlySalaries
            .map((e) => e.catalogEntry.price)
            .reduce((value, element) => value + element) /
        fullTimeMonthlySalaries.length.toDouble();
    final hourPrice = fullTimeMonthlySalariesPriceAvg /
        workingTimeRatios.getWorkingHoursOf(
            WorkArrangement.fullTime, PayPeriod.monthly);
    return hourPrice * workingHours;
  }
}
