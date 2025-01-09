import 'package:life_admin/backend/shared/metadata.dart';
import 'package:life_admin/backend/tasks/datetime_rule.dart';
import 'package:life_admin/backend/tasks/dtos.dart';

class Task {
  Metadata metadata;
  DatetimeRule datetimeRule;

  Task({
    required this.metadata,
    required this.datetimeRule,
  });

  TaskDto toDto() {
    return TaskDto(
      metadata: metadata.toDto(),
      datetimeRule: datetimeRule.toDto(),
    );
  }
}
