import 'package:life_admin/backend/finances/inflation_index.dart';

class InflationIndexProvider {
  final List<InflationIndex> inflationIndexSerie;

  InflationIndexProvider({
    required this.inflationIndexSerie,
  });

  double getInflationIndex(DateTime datetime) {
    if (datetime.isAfter(inflationIndexSerie.last.datetime)) {
      return inflationIndexSerie.last.value;
    }

    // Iterate backwards for more efficiency
    for (var i = inflationIndexSerie.length - 1; i >= 0; i--) {
      if (inflationIndexSerie[i].datetime.isBefore(datetime)) {
        if (inflationIndexSerie[i + 1].datetime.isAtSameMomentAs(datetime)) {
          return inflationIndexSerie[i + 1].value;
        } else {
          return (inflationIndexSerie[i].value +
                  inflationIndexSerie[i + 1].value) /
              2;
        }
      }
    }

    return inflationIndexSerie.first.value;
  }
}
