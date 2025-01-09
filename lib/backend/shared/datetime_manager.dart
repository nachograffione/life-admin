abstract class DateTimeManager {
  DateTime now();
}

class DefaultDateTimeManager implements DateTimeManager {
  @override
  DateTime now() => DateTime.now();
}

class MockDateTimeManager implements DateTimeManager {
  final DateTime fixedNow;

  MockDateTimeManager(this.fixedNow);

  @override
  DateTime now() => fixedNow;
}
