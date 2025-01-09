import 'package:life_admin/backend/shared/datetime_manager.dart';
import 'package:life_admin/backend/shared/metadata.dart';
import 'package:life_admin/backend/shared/tag.dart';
import 'package:life_admin/backend/shared/tag_manager.dart';
import 'package:life_admin/backend/shared/tag_tree_node.dart';
import 'package:life_admin/backend/tasks/datetime_rule.dart';
import 'package:life_admin/backend/tasks/repetition_kind.dart';
import 'package:life_admin/backend/tasks/task.dart';
import 'package:life_admin/backend/tasks/tasks_filter.dart';
import 'package:life_admin/backend/tasks/tasks_manager_wrapped.dart';
import 'package:life_admin/backend/tasks/time_of_day.dart';
import 'package:life_admin/backend/tasks/weekday.dart';
import 'package:test/test.dart';

void main() {
  group('getTasks using filter', () {
    final root = TagTreeNode(data: Tag(name: 'root'));

    // Daily task
    final taskA = Task(
      metadata: Metadata(
        name: 'A',
        description: '',
        tagManager: TagManager(
          tags: [root],
        ),
      ),
      datetimeRule: DatetimeRule(
        duration: const Duration(hours: 1),
        startsAt: const TimeOfDay(hour: 0, minute: 0),
        weekdays: [
          Weekday.monday,
          Weekday.tuesday,
          Weekday.wednesday,
          Weekday.thursday,
          Weekday.friday,
          Weekday.saturday,
          Weekday.sunday,
        ],
        monthweeks: [1, 2, 3, 4, 5],
      ),
    );
    // Workday task
    final taskB = Task(
      metadata: Metadata(
        name: 'B',
        description: '',
        tagManager: TagManager(
          tags: [root],
        ),
      ),
      datetimeRule: DatetimeRule(
        duration: const Duration(hours: 1),
        startsAt: const TimeOfDay(hour: 0, minute: 0),
        weekdays: [
          Weekday.monday,
          Weekday.tuesday,
          Weekday.wednesday,
          Weekday.thursday,
          Weekday.friday,
          Weekday.saturday,
        ],
        monthweeks: [1, 2, 3, 4, 5],
      ),
    );
    // Weekly single weekday task
    final taskC = Task(
      metadata: Metadata(
        name: 'C',
        description: '',
        tagManager: TagManager(
          tags: [root],
        ),
      ),
      datetimeRule: DatetimeRule(
        duration: const Duration(hours: 1),
        startsAt: const TimeOfDay(hour: 0, minute: 0),
        weekdays: [
          Weekday.monday,
        ],
        monthweeks: [1, 2, 3, 4, 5],
      ),
    );
    // Weekly multiple weekdays task
    final taskD = Task(
      metadata: Metadata(
        name: 'D',
        description: '',
        tagManager: TagManager(
          tags: [root],
        ),
      ),
      datetimeRule: DatetimeRule(
        duration: const Duration(hours: 1),
        startsAt: const TimeOfDay(hour: 0, minute: 0),
        weekdays: [
          Weekday.monday,
          Weekday.tuesday,
        ],
        monthweeks: [1, 2, 3, 4, 5],
      ),
    );
    // Monthly single weekday single monthweek task
    final taskE = Task(
      metadata: Metadata(
        name: 'E',
        description: '',
        tagManager: TagManager(
          tags: [root],
        ),
      ),
      datetimeRule: DatetimeRule(
        duration: const Duration(hours: 1),
        startsAt: const TimeOfDay(hour: 0, minute: 0),
        weekdays: [
          Weekday.monday,
        ],
        monthweeks: [1],
      ),
    );
    // Monthly multiple weekday single monthweek task
    final taskF = Task(
      metadata: Metadata(
        name: 'F',
        description: '',
        tagManager: TagManager(
          tags: [root],
        ),
      ),
      datetimeRule: DatetimeRule(
        duration: const Duration(hours: 1),
        startsAt: const TimeOfDay(hour: 0, minute: 0),
        weekdays: [
          Weekday.monday,
          Weekday.tuesday,
        ],
        monthweeks: [1],
      ),
    );
    // Monthly workday weekdays single monthweek task
    final taskG = Task(
      metadata: Metadata(
        name: 'G',
        description: '',
        tagManager: TagManager(
          tags: [root],
        ),
      ),
      datetimeRule: DatetimeRule(
        duration: const Duration(hours: 1),
        startsAt: const TimeOfDay(hour: 0, minute: 0),
        weekdays: [
          Weekday.monday,
          Weekday.tuesday,
          Weekday.wednesday,
          Weekday.thursday,
          Weekday.friday,
          Weekday.saturday,
        ],
        monthweeks: [1],
      ),
    );
    // Monthly daily weekdays single monthweek task
    final taskH = Task(
      metadata: Metadata(
        name: 'H',
        description: '',
        tagManager: TagManager(
          tags: [root],
        ),
      ),
      datetimeRule: DatetimeRule(
        duration: const Duration(hours: 1),
        startsAt: const TimeOfDay(hour: 0, minute: 0),
        weekdays: [
          Weekday.monday,
          Weekday.tuesday,
          Weekday.wednesday,
          Weekday.thursday,
          Weekday.friday,
          Weekday.saturday,
          Weekday.sunday,
        ],
        monthweeks: [1],
      ),
    );
    // Monthly single weekday multiple monthweek task
    final taskI = Task(
      metadata: Metadata(
        name: 'I',
        description: '',
        tagManager: TagManager(
          tags: [root],
        ),
      ),
      datetimeRule: DatetimeRule(
        duration: const Duration(hours: 1),
        startsAt: const TimeOfDay(hour: 0, minute: 0),
        weekdays: [
          Weekday.monday,
        ],
        monthweeks: [1, 2],
      ),
    );
    // Monthly multiple weekday multiple monthweek task
    final taskJ = Task(
      metadata: Metadata(
        name: 'J',
        description: '',
        tagManager: TagManager(
          tags: [root],
        ),
      ),
      datetimeRule: DatetimeRule(
        duration: const Duration(hours: 1),
        startsAt: const TimeOfDay(hour: 0, minute: 0),
        weekdays: [
          Weekday.monday,
          Weekday.tuesday,
        ],
        monthweeks: [1, 2],
      ),
    );
    // Monthly workday weekdays multiple monthweek task
    final taskK = Task(
      metadata: Metadata(
        name: 'K',
        description: '',
        tagManager: TagManager(
          tags: [root],
        ),
      ),
      datetimeRule: DatetimeRule(
        duration: const Duration(hours: 1),
        startsAt: const TimeOfDay(hour: 0, minute: 0),
        weekdays: [
          Weekday.monday,
          Weekday.tuesday,
          Weekday.wednesday,
          Weekday.thursday,
          Weekday.friday,
          Weekday.saturday,
        ],
        monthweeks: [1, 2],
      ),
    );
    // Monthly daily weekdays multiple monthweek task
    final taskL = Task(
      metadata: Metadata(
        name: 'L',
        description: '',
        tagManager: TagManager(
          tags: [root],
        ),
      ),
      datetimeRule: DatetimeRule(
        duration: const Duration(hours: 1),
        startsAt: const TimeOfDay(hour: 0, minute: 0),
        weekdays: [
          Weekday.monday,
          Weekday.tuesday,
          Weekday.wednesday,
          Weekday.thursday,
          Weekday.friday,
          Weekday.saturday,
          Weekday.sunday,
        ],
        monthweeks: [1, 2],
      ),
    );

    final tasksManagerWrapped = TasksManagerWrapped(
      tasks: [
        taskA,
        taskB,
        taskC,
        taskD,
        taskE,
        taskF,
        taskG,
        taskH,
        taskI,
        taskJ,
        taskK,
        taskL,
      ],
      tagsTree: root,
    );

    test('Given daily filter, when getTasks, then get expected result', () {
      expect(
        tasksManagerWrapped.getTasks(
          TasksFilter(
            repetitionKind: RepetitionKind.daily,
          ),
        ),
        [taskA],
      );
    });
    test('Given workday filter, when getTasks, then get expected result', () {
      expect(
        tasksManagerWrapped.getTasks(
          TasksFilter(
            repetitionKind: RepetitionKind.workday,
          ),
        ),
        [taskB],
      );
    });
    test(
        'Given weekly task and weekday, when getTasks, then get expected result',
        () {
      expect(
        tasksManagerWrapped.getTasks(
          TasksFilter(
            repetitionKind: RepetitionKind.weekly,
            weekday: Weekday.monday,
          ),
        ),
        [taskC, taskD],
      );
      expect(
        tasksManagerWrapped.getTasks(
          TasksFilter(
            repetitionKind: RepetitionKind.weekly,
            weekday: Weekday.tuesday,
          ),
        ),
        [taskD],
      );
    });
    test(
        'Given monthly task and weekday and monthweek, when getTasks, then get expected result',
        () {
      expect(
        tasksManagerWrapped.getTasks(
          TasksFilter(
            repetitionKind: RepetitionKind.monthly,
            weekday: Weekday.monday,
            monthweek: 1,
          ),
        ),
        [taskE, taskF, taskG, taskH, taskI, taskJ, taskK, taskL],
      );
      expect(
        tasksManagerWrapped.getTasks(
          TasksFilter(
            repetitionKind: RepetitionKind.monthly,
            weekday: Weekday.tuesday,
            monthweek: 1,
          ),
        ),
        [taskF, taskG, taskH, taskJ, taskK, taskL],
      );
      expect(
        tasksManagerWrapped.getTasks(
          TasksFilter(
            repetitionKind: RepetitionKind.monthly,
            weekday: Weekday.monday,
            monthweek: 2,
          ),
        ),
        [taskI, taskJ, taskK, taskL],
      );
      expect(
        tasksManagerWrapped.getTasks(
          TasksFilter(
            repetitionKind: RepetitionKind.monthly,
            weekday: Weekday.tuesday,
            monthweek: 2,
          ),
        ),
        [taskJ, taskK, taskL],
      );
    });
  });

  group('getFirstMondayOfMonth', () {
    final tasksManagerWrapped = TasksManagerWrapped(
      tasks: [],
      tagsTree: TagTreeNode(data: Tag(name: '')),
      dateTimeManager: DefaultDateTimeManager(),
    );
    test(
        'Given a month that starts on monday, when getFirstMondayOfMonth, then get expected result',
        () {
      expect(tasksManagerWrapped.getFirstMondayOfMonth(2024, 4),
          DateTime(2024, 4, 1));
    });
    test(
        'Given a month that starts on thursday (furthest that takes previous monday as first), when getFirstMondayOfMonth, then get expected result',
        () {
      expect(tasksManagerWrapped.getFirstMondayOfMonth(2024, 8),
          DateTime(2024, 7, 29));
    });
    test(
        'Given a month that starts on friday (furthest that takes next monday as first), when getFirstMondayOfMonth, then get expected result',
        () {
      expect(tasksManagerWrapped.getFirstMondayOfMonth(2024, 11),
          DateTime(2024, 11, 4));
    });
  });

  group('getCurrentMonthweek', () {
    test(
        'Given first monthday, when getCurrentMonthweek, then get expected result',
        () {
      final tasksManagerWrapped = TasksManagerWrapped(
        tasks: [],
        tagsTree: TagTreeNode(data: Tag(name: '')),
        dateTimeManager: MockDateTimeManager(DateTime(2024, 4, 1)),
      );
      expect(tasksManagerWrapped.getCurrentMonthweek(), 1);
    });
    test(
        'Given second monthday, when getCurrentMonthweek, then get expected result',
        () {
      final tasksManagerWrapped = TasksManagerWrapped(
        tasks: [],
        tagsTree: TagTreeNode(data: Tag(name: '')),
        dateTimeManager: MockDateTimeManager(DateTime(2024, 4, 2)),
      );
      expect(tasksManagerWrapped.getCurrentMonthweek(), 1);
    });
    test(
        'Given tenth monthday, when getCurrentMonthweek, then get expected result',
        () {
      final tasksManagerWrapped = TasksManagerWrapped(
        tasks: [],
        tagsTree: TagTreeNode(data: Tag(name: '')),
        dateTimeManager: MockDateTimeManager(DateTime(2024, 4, 10)),
      );
      expect(tasksManagerWrapped.getCurrentMonthweek(), 2);
    });
    test(
        'Given last monthday, when getCurrentMonthweek, then get expected result',
        () {
      final tasksManagerWrapped = TasksManagerWrapped(
        tasks: [],
        tagsTree: TagTreeNode(data: Tag(name: '')),
        dateTimeManager: MockDateTimeManager(DateTime(2024, 4, 30)),
      );
      expect(tasksManagerWrapped.getCurrentMonthweek(), 5);
    });
  });
}
