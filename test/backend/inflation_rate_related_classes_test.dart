import 'package:life_admin/backend/finances/inflation_calculator.dart';
import 'package:life_admin/backend/finances/inflation_index.dart';
import 'package:life_admin/backend/finances/inflation_index_provider.dart';
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
      )
    ]);

    group('getInflationIndex', () {
      test(
          'Given a datetime after serie, when getInflationIndex, then get the last index value',
          () {
        expect(
            inflationIndexProvider.getInflationIndex(DateTime(2022, 1, 6)), 4);
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
                DateTime(2022, 1, 3), DateTime(2022, 1, 7)),
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

    // TODO: add getInflationRateFromReferenceAndInterval tests
  });
}
