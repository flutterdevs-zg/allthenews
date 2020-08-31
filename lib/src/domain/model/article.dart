import 'package:meta/meta.dart';

class Article {
  final int id;

  final String url;

  final String updated;

  final String authorName;

  final String title;

  final String abstract;

  final String thumbnail;

  Article({
    @required this.id,
    @required this.url,
    @required this.updated,
    @required this.authorName,
    @required this.title,
    @required this.abstract,
    @required this.thumbnail,
  });

  @override
  String toString() {
    return 'Article{id: $id, url: $url, updated: $updated, author: $authorName, title: $title, abstract: $abstract}';
  }
}
