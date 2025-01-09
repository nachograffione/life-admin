import 'package:life_admin/backend/finances/dtos.dart';

class InflationIndex {
  final DateTime datetime;
  final double value;

  InflationIndex({required this.datetime, required this.value});

  InflationIndexDto toDto() {
    return InflationIndexDto(
      datetime: datetime,
      value: value,
    );
  }
}
