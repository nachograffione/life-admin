import 'package:life_admin/backend/finances/inflation_index_provider.dart';
import 'package:life_admin/backend/finances/inflation_rate_interval.dart';

class InflationCalculator {
  final InflationIndexProvider inflationIndexProvider;
  InflationCalculator({
    required this.inflationIndexProvider,
  });

  double getInflationRateFromDatetimes(DateTime from, DateTime to) {
    final fromValue = inflationIndexProvider.getInflationIndex(from);
    final toValue = inflationIndexProvider.getInflationIndex(to);
    return (toValue - fromValue) / fromValue;
  }

  double getInflationRateFromReferenceAndInterval(
      DateTime reference, InflationRateInterval interval) {
    final fromDateTime = _getIntervalStart(reference, interval);
    return getInflationRateFromDatetimes(
      fromDateTime,
      reference,
    );
  }

  DateTime _getIntervalStart(
      DateTime reference, InflationRateInterval interval) {
    switch (interval) {
      case InflationRateInterval.mtd:
        return DateTime(reference.year, reference.month, 1);
      case InflationRateInterval.ytd:
        return DateTime(reference.year, 1, 1);
      case InflationRateInterval.interAnnual:
        return DateTime(reference.year - 1, reference.month, reference.day);
    }
  }
}
