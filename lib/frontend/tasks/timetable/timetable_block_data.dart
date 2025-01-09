import 'package:life_admin/backend/tasks/time_of_day.dart' as tod;

class TimetableBlockData {
  final String name;
  final tod.TimeOfDay startsAt;
  final tod.TimeOfDay endsAt;

  Duration get duration => endsAt - startsAt;

  const TimetableBlockData({
    required this.name,
    required this.startsAt,
    required this.endsAt,
  });
}
