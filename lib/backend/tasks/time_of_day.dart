import 'package:flutter/material.dart' as flutter;

class TimeOfDay extends flutter.TimeOfDay {
  static const TimeOfDay startOfDay = TimeOfDay(hour: 0, minute: 0);
  static const TimeOfDay endOfDay = TimeOfDay(hour: 23, minute: 59);

  const TimeOfDay({
    required int hour,
    required int minute,
  }) : super(hour: hour, minute: minute);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeOfDay && other.hour == hour && other.minute == minute;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;

  TimeOfDay get previous => add(const Duration(minutes: -1));

  double get dayRatio => minuteOfDay / TimeOfDay.endOfDay.minuteOfDay;

  TimeOfDay add(Duration duration) {
    int totalMinutes = hour * 60 + minute + duration.inMinutes;

    int newHours = totalMinutes ~/ 60;
    int newMinutes = totalMinutes % 60;

    newHours %= 24;
    newMinutes %= 60;

    return TimeOfDay(hour: newHours, minute: newMinutes);
  }

  TimeOfDay subtract(Duration duration) => add(-duration);

  int get minuteOfDay => hour * 60 + minute;

  Duration operator -(TimeOfDay other) =>
      Duration(minutes: minuteOfDay - other.minuteOfDay);

  int compareTo(TimeOfDay startsAt) {
    return hour * 60 + minute - startsAt.hour * 60 - startsAt.minute;
  }

  @override
  String toString() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}
