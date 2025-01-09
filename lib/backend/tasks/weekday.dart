import 'package:life_admin/backend/tasks/dtos.dart';

enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

WeekdayDto weekdayToDto(Weekday value) {
  switch (value) {
    case Weekday.monday:
      return WeekdayDto.monday;
    case Weekday.tuesday:
      return WeekdayDto.tuesday;
    case Weekday.wednesday:
      return WeekdayDto.wednesday;
    case Weekday.thursday:
      return WeekdayDto.thursday;
    case Weekday.friday:
      return WeekdayDto.friday;
    case Weekday.saturday:
      return WeekdayDto.saturday;
    case Weekday.sunday:
      return WeekdayDto.sunday;
    default:
      throw Exception('Unknown weekday: $value');
  }
}

Weekday weekdayFromDto(WeekdayDto value) {
  switch (value) {
    case WeekdayDto.monday:
      return Weekday.monday;
    case WeekdayDto.tuesday:
      return Weekday.tuesday;
    case WeekdayDto.wednesday:
      return Weekday.wednesday;
    case WeekdayDto.thursday:
      return Weekday.thursday;
    case WeekdayDto.friday:
      return Weekday.friday;
    case WeekdayDto.saturday:
      return Weekday.saturday;
    case WeekdayDto.sunday:
      return Weekday.sunday;
    default:
      throw Exception('Unknown weekday: $value');
  }
}

// value is 1-based (following DateTime.weekday)
Weekday weekdayFromInt(int value) {
  return Weekday.values[value - 1];
}
