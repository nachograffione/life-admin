import 'package:flutter/material.dart';

Color dullDownColor(Color color, double factor) {
  return color.withOpacity(factor);
}

double roundToResolution(double value, double resolution) {
  if (resolution <= 0) {
    throw ArgumentError("Resolution must be greater than zero.");
  }

  double roundedValue = (value / resolution).round() * resolution;
  return roundedValue;
}

String capitalize(String value) {
  return value[0].toUpperCase() + value.substring(1);
}

String shortForm(String value) {
  return value.substring(0, 3);
}

String enumToString(Enum value) {
  return value.toString().split('.').last;
}

String durationToString(Duration duration) {
  final hours = duration.inMinutes ~/ 60;
  final minutes = duration.inMinutes % 60;

  final hoursTwoDigit = hours.toString().padLeft(2, '0');
  final minutesTwoDigit = minutes.toString().padLeft(2, '0');

  return "$hoursTwoDigit:$minutesTwoDigit";
}
