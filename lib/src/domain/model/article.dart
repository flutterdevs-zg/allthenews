import 'package:allthenews/src/data/response/article_response.dart';

class Article {
  final int id;

  final String url;

  final String updated;

  final String authorName;

  final String title;

  final String abstract;

  final String thumbnail;

  Article({
    this.id,
    this.url,
    this.updated,
    this.authorName,
    this.title,
    this.abstract,
    this.thumbnail,
  });

  factory Article.fromResponse(ArticleResponse response) => Article(
        id: response.id,
        authorName: response.author,
        title: response.title,
        abstract: response.abstract,
        updated: response.updated,
        url: response.url,
        thumbnail: response.media.mediaMetadata.last.url,
      );

  @override
  String toString() {
    return 'Article{id: $id, url: $url, updated: $updated, author: $authorName, title: $title, abstract: $abstract}';
  }
}
