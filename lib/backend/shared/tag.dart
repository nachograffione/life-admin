import 'package:life_admin/backend/shared/dtos.dart';

class Tag {
  final String name;

  Tag({required this.name});

  factory Tag.fromDto(TagDto dto) {
    return Tag(name: dto.name);
  }

  TagDto toDto() {
    return TagDto(name: name);
  }

  @override
  operator ==(Object other) {
    return other is Tag && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
