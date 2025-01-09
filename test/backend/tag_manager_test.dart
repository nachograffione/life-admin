import 'package:life_admin/backend/shared/tag.dart';
import 'package:life_admin/backend/shared/tag_manager.dart';
import 'package:life_admin/backend/shared/tag_tree_node.dart';
import 'package:test/test.dart';

void main() {
  group('hasTag', () {
    final TagTreeNode root = TagTreeNode(data: Tag(name: 'tagRoot'));
    final TagTreeNode a = TagTreeNode(data: Tag(name: 'tagA'));
    final TagTreeNode aa = TagTreeNode(data: Tag(name: 'tagAA'));
    final TagTreeNode b = TagTreeNode(data: Tag(name: 'tagB'));
    final TagTreeNode bb = TagTreeNode(data: Tag(name: 'tagBB'));
    root.addChild(a);
    a.addChild(aa);
    root.addChild(b);
    b.addChild(bb);

    final TagManager tagManager = TagManager(tags: [aa]);

    test('Given an included leaf tag, when hasTag, then get expected result',
        () {
      expect(tagManager.hasTag(aa), true);
    });
    test(
        'Given an included ancestor tag, when hasTag, then get expected result',
        () {
      expect(tagManager.hasTag(a), true);
    });
    test('Given a non-included leaf tag, when hasTag, then get expected result',
        () {
      expect(tagManager.hasTag(bb), false);
    });
    test(
        'Given a non-included ancestor tag, when hasTag, then get expected result',
        () {
      expect(tagManager.hasTag(bb), false);
    });
  });
}
