import 'package:life_admin/backend/finances/inflation_calculator.dart';
import 'package:life_admin/backend/finances/inflation_index.dart';
import 'package:life_admin/backend/finances/inflation_index_provider.dart';
import 'package:life_admin/backend/finances/inflation_rate_interval.dart';
import 'package:test/test.dart';

void main() {
  group('inflationRate related classes', () {
    final inflationIndexProvider = InflationIndexProvider(inflationIndexSerie: [
      InflationIndex(
        datetime: DateTime(2022, 1, 1),
        value: 1,
      ),
      InflationIndex(
        datetime: DateTime(2022, 1, 3),
        value: 2,
      ),
      InflationIndex(
        datetime: DateTime(2022, 1, 4),
        value: 3,
      ),
      InflationIndex(
        datetime: DateTime(2022, 1, 5),
        value: 4,
      ),
      InflationIndex(
        datetime: DateTime(2022, 2, 6),
        value: 1,
      ),
      InflationIndex(
        datetime: DateTime(2023, 1, 1),
        value: 2,
      ),
      InflationIndex(
        datetime: DateTime(2023, 2, 1),
        value: 4,
      ),
      InflationIndex(
        datetime: DateTime(2023, 2, 6),
        value: 8,
      )
    ]);

    group('getInflationIndex', () {
      test(
          'Given a datetime after serie, when getInflationIndex, then get the last index value',
          () {
        expect(
            inflationIndexProvider.getInflationIndex(DateTime(2023, 2, 10)), 8);
      });

      test(
          'Given a datetime before serie, when getInflationIndex, then get the first index value',
          () {
        expect(inflationIndexProvider.getInflationIndex(DateTime(2021, 12, 31)),
            1);
      });

      test(
          'Given the first datetime, when getInflationIndex, then get the first index value',
          () {
        expect(
            inflationIndexProvider.getInflationIndex(DateTime(2022, 1, 1)), 1);
      });

      test(
          'Given the last datetime, when getInflationIndex, then get the last index value',
          () {
        expect(
            inflationIndexProvider.getInflationIndex(DateTime(2022, 1, 5)), 4);
      });

      test(
          'Given a datetime inside serie with index, when getInflationIndex, then get the corresponding index value',
          () {
        expect(
            inflationIndexProvider.getInflationIndex(DateTime(2022, 1, 4)), 3);
      });

      test(
          'Given a datetime inside serie with no index, when getInflationIndex, then get the avg of nearest index values',
          () {
        expect(inflationIndexProvider.getInflationIndex(DateTime(2022, 1, 2)),
            1.5);
      });
    });

    group('getInflationRateFromDatetimes', () {
      final inflationCalculator = InflationCalculator(
        inflationIndexProvider: inflationIndexProvider,
      );

      test(
          'Given datetimes inside serie and after last, when getInflationRate, then get the expected result',
          () {
        expect(
            inflationCalculator.getInflationRateFromDatetimes(
                DateTime(2023, 2, 1), DateTime(2023, 2, 10)),
            1.0);
      });

      test(
          'Given datetimes before first and inside serie, when getInflationRate, then get the expected result',
          () {
        expect(
            inflationCalculator.getInflationRateFromDatetimes(
                DateTime(2021, 12, 31), DateTime(2022, 1, 2)),
            0.5);
      });

      test(
          'Given datetimes both inside serie, when getInflationRate, then get the expected result',
          () {
        expect(
            inflationCalculator.getInflationRateFromDatetimes(
                DateTime(2022, 1, 2), DateTime(2022, 1, 4)),
            1);
      });
    });

    group('getInflationRateFromReferenceAndInterval', () {
      final inflationCalculator = InflationCalculator(
        inflationIndexProvider: inflationIndexProvider,
      );
      test(
          'Given a reference date and an mtd interval, when getInflationRateFromReferenceAndInterval, then get the expected result',
          () {
        expect(
            inflationCalculator.getInflationRateFromReferenceAndInterval(
                DateTime(2023, 2, 6), InflationRateInterval.mtd),
            1);
      });
      test(
          'Given a reference date and a ytd interval, when getInflationRateFromReferenceAndInterval, then get the expected result',
          () {
        expect(
            inflationCalculator.getInflationRateFromReferenceAndInterval(
                DateTime(2023, 2, 6), InflationRateInterval.ytd),
            3);
      });
      test(
          'Given a reference date and an interAnnual interval, when getInflationRateFromReferenceAndInterval, then get the expected result',
          () {
        expect(
            inflationCalculator.getInflationRateFromReferenceAndInterval(
                DateTime(2023, 2, 6), InflationRateInterval.interAnnual),
            7);
      });
    });
  });
}
