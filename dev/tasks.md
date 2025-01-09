# Tasks

## Facade, main components, dtos

```plantuml
@startuml lifeAdminModel
!theme reddress-darkblue
skinparam classAttributeIconSize 0
hide circle
<style>
  classDiagram {
    fontname "Arial"
    header {
      fontstyle bold
      fontsize 15
    }
    class {
      fontsize 13
    }
    note {
      fontsize 13
      backgroundColor grey
    }
  }
</style>

package tasks {}


class tasks.TasksManager {
  getTasks(filter:TasksFilterDto):List<TaskDto>
  getTasksSum(filter:TasksFilterDto):Duration
  ---
  getDailyWeekdays():List<WeekdayDto>
  getDailyMonthweeks():List<MonthweekDto>
  getWorkdayWeekdays():List<WeekdayDto>
  getWorkdayMonthweeks():List<MonthweekDto>
  getWeeklyMonthweeks():List<MonthweekDto>
}

class tasks.TaskManagerWrapped {}

class tasks.RepetitionKindFeatures {}

tasks.TasksManager --> "1" tasks.TaskManagerWrapped
tasks.TasksManager --> "1" tasks.RepetitionKindFeatures

@enduml
```


```plantuml
@startuml lifeAdminModel
!theme reddress-darkblue
skinparam classAttributeIconSize 0
hide circle
<style>
  classDiagram {
    fontname "Arial"
    header {
      fontstyle bold
      fontsize 15
    }
    class {
      fontsize 13
    }
    note {
      fontsize 13
      backgroundColor grey
    }
  }
</style>

package tasks {}

class "tasks.<ClassName>Dto"

class tasks.TasksFilterDto {
  weekdays
  monthweeks
}

@enduml
```

## Tasks

> A **task** is an activity that occurs at least once a day.

_If some activity is repeated inside a day, think on it as different tasks named like "first \<actvity\>", "second \<activity\>", etc._

```plantuml
@startuml lifeAdminModel
!theme reddress-darkblue
skinparam classAttributeIconSize 0
hide circle
<style>
  classDiagram {
    fontname "Arial"
    header {
      fontstyle bold
      fontsize 15
    }
    class {
      fontsize 13
    }
    note {
      fontsize 13
      backgroundColor grey
    }
  }
</style>

package tasks {}
package shared {}

class tasks.RepetitionKindFeatures {
  dailyWeekdays
  dailyMonthweeks
  workdayWeekdays
  workdayMonthweeks
  weeklyMonthweeks
}

class tasks.TasksManager {
  getTasks(filter:TasksFilter):List<Task>
  getTasksSum(filter:TasksFilter):Duration
  ---
}

class tasks.Task

class shared.TagTreeNode


class tasks.Task  {}

class tasks.DatetimeRule {
  duration
  startsAt
}

class tasks.RepetitionKind {
  DAILY
  WORKDAY
  WEEKLY
  MONTHLY
  CUSTOM
}


class shared.Metadata {
}

enum shared.Weekday {
  MONDAY
  TUESDAY
  WEDNESDAY
  THURSDAY
  FRIDAY
  SATURDAY
  SUNDAY
}

class shared.Monthweek {
}

class builtin.Int {
}

tasks.TasksManager --> "*" tasks.Task : tasks
tasks.TasksManager --> "1" shared.TagTreeNode : tags
tasks.Task --> "1" shared.Metadata : metadata
tasks.Task --> "1" tasks.DatetimeRule : datetimeRule
tasks.DatetimeRule --> "*" shared.Weekday : weekdays
tasks.DatetimeRule --> "*" shared.Monthweek : monthweeks
 shared.Monthweek --|> builtin.Int
@enduml
```