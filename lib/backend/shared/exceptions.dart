class LeafTagsException implements Exception {
  final String field;

  LeafTagsException({this.field = ''});

  @override
  String toString() => '$field: it must contain leaf tags.';
}
