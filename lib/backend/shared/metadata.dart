import 'package:life_admin/backend/shared/dtos.dart';
import 'package:life_admin/backend/shared/tag_manager.dart';

class Metadata {
  final String name;
  final String description;
  late final TagManager tagManager;

  Metadata(
      {required this.name, required this.description, TagManager? tagManager}) {
    this.tagManager = tagManager ?? TagManager();
  }

  MetadataDto toDto() {
    return MetadataDto(
      name: name,
      description: description,
      tags: tagManager.tags.map((e) => e.data.toDto()).toList(),
    );
  }
}
