class Inkuru {
  final String id;
  final String title;
  final String content;
  final String author;
  final String source;
  final List<String> tags;

  Inkuru.fromMap(Map<String, dynamic> map)
      : title = map['title'] as String,
        id = map['id'] as String,
        content = map['content'] as String,
        author = map['author'] as String,
        source = map['source'] as String,
        tags = map['tags'] == null
            ? []
            : map['tags'].map<String>((t) => t.toString()).toList();

  @override
  String toString() => ''''id': $id , 'title': $title, 'author': $author\n''';
}
