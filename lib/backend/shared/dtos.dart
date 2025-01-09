import 'package:life_admin/backend/shared/tree_node.dart';

class TagDto {
  final String name;

  TagDto({required this.name});

  @override
  bool operator ==(Object other) {
    return other is TagDto && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

typedef TagTreeNodeDto = TreeNode<TagDto>;

class MetadataDto {
  final String name;
  final String description;
  final List<TagDto> tags;

  MetadataDto(
      {required this.name, required this.description, required this.tags});
}
