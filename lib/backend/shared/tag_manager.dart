import 'package:life_admin/backend/shared/exceptions.dart';
import 'package:life_admin/backend/shared/tag_tree_node.dart';

class TagManager {
  late final List<TagTreeNode> tags;

  TagManager({List<TagTreeNode>? tags}) {
    if (tags == null) {
      this.tags = [];
    } else {
      for (var tag in tags) {
        if (!tag.isLeaf()) throw LeafTagsException();
      }
      this.tags = tags;
    }
  }

  bool hasTag(TagTreeNode tag) {
    return tags.any((t) => t.isDescendantOf(tag));
  }
}
