import 'package:life_admin/backend/finances/dtos.dart';

class Price {
  final double value;
  final double absoluteError;

  Price({
    this.value = 0,
    this.absoluteError = 0,
  });

  Price operator +(Price other) {
    return Price(
        value: value + other.value,
        absoluteError: absoluteError + other.absoluteError);
  }

  Price operator -(Price other) {
    return Price(
      value: value - other.value,
      absoluteError: absoluteError + other.absoluteError,
    );
  }

  Price operator *(double other) {
    return Price(value: value * other, absoluteError: absoluteError * other);
  }

  Price operator /(double other) {
    return Price(value: value / other, absoluteError: absoluteError / other);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Price &&
          other.value == value &&
          other.absoluteError == absoluteError;

  @override
  int get hashCode => value.hashCode ^ absoluteError.hashCode;

  PriceDto toDto() {
    return PriceDto(
      value: value,
      absoluteError: absoluteError,
    );
  }
}
