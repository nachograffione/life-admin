// Methods uses preorder traversal if needed.
class TreeNode<T> {
  T data;
  List<TreeNode<T>> children = [];
  TreeNode<T>? parent;

  TreeNode({required this.data});

  static TreeNode<U> from<T, U>(TreeNode<T> tree, U Function(T data) convert) {
    TreeNode<U> newTree = TreeNode(data: convert(tree.data));
    for (var child in tree.children) {
      TreeNode<U> newChild = TreeNode.from(child, convert);
      newTree.addChild(newChild);
    }
    return newTree;
  }

  void addChild(TreeNode<T> child) {
    child.parent = this;
    children.add(child);
  }

  List<TreeNode<T>> get ancestors {
    if (parent == null) return [];
    return parent!.ancestors..add(this);
  }

  List<TreeNode<T>> get descendants {
    List<TreeNode<T>> descendants = [];
    if (children.isEmpty) return descendants;
    for (var child in children) {
      descendants.addAll(child.descendants);
    }
    return descendants;
  }

  List<TreeNode<T>> get siblings {
    if (parent == null) return [];
    return parent!.children.where((sibling) => sibling != this).toList();
  }

  List<TreeNode<T>> get leaves {
    final leaves = <TreeNode<T>>[];
    if (isLeaf()) {
      return leaves..add(this);
    }
    for (var child in children) {
      leaves.addAll(child.leaves);
    }
    return leaves;
  }

  bool isLeaf() {
    return children.isEmpty;
  }

  /// Returns true if [this] is an ancestor of [node].
  /// A node is an ancestor of itself.
  bool isAncestorOf(TreeNode<T> node) {
    if (this == node) return true;
    for (var child in children) {
      if (child.isAncestorOf(node)) return true;
    }
    return false;
  }

  /// Returns true if [this] is a descendant of [node].
  /// A node is a descendant of itself.
  bool isDescendantOf(TreeNode<T> node) {
    return node.isAncestorOf(this);
  }

  void apply(void Function(T data) function) {
    function(data);
    for (var child in children) {
      child.apply(function);
    }
  }

  TreeNode<T> firstWhere(bool Function(T data) test,
      {TreeNode<T> Function()? orElse}) {
    final result = _firstWhereWrapped(test);
    if (result != null) return result;
    if (orElse != null) return orElse();
    throw StateError('No element found');
  }

  TreeNode<T>? _firstWhereWrapped(
    bool Function(T data) test,
  ) {
    if (test(data)) return this;
    for (var child in children) {
      final result = child._firstWhereWrapped(test);
      if (result != null) return result;
    }
    return null;
  }

  bool any(T data) {
    if (this.data == data) return true;
    for (var child in children) {
      if (child.any(data)) return true;
    }
    return false;
  }

  bool anyWhere(bool Function(T data) test) {
    if (test(data)) return true;
    for (var child in children) {
      if (child.anyWhere(test)) return true;
    }
    return false;
  }

  @override
  bool operator ==(Object other) {
    return other is TreeNode<T> && other.data == data;
  }

  @override
  int get hashCode => data.hashCode ^ children.hashCode ^ parent.hashCode;
}
