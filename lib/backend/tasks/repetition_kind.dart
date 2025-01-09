import 'package:life_admin/backend/tasks/dtos.dart';

enum RepetitionKind {
  daily,
  workday,
  weekly,
  monthly,
}

RepetitionKind repetitionKindFromDto(RepetitionKindDto dto) {
  switch (dto) {
    case RepetitionKindDto.daily:
      return RepetitionKind.daily;
    case RepetitionKindDto.workday:
      return RepetitionKind.workday;
    case RepetitionKindDto.weekly:
      return RepetitionKind.weekly;
    case RepetitionKindDto.monthly:
      return RepetitionKind.monthly;
  }
}

RepetitionKindDto repetitionKindToDto(RepetitionKind repetitionKind) {
  switch (repetitionKind) {
    case RepetitionKind.daily:
      return RepetitionKindDto.daily;
    case RepetitionKind.workday:
      return RepetitionKindDto.workday;
    case RepetitionKind.weekly:
      return RepetitionKindDto.weekly;
    case RepetitionKind.monthly:
      return RepetitionKindDto.monthly;
  }
}
