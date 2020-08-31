import 'package:allthenews/src/data/response/media_response.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_response.g.dart';

@JsonSerializable()
class ArticleResponse {
  final int id;

  final String url;

  final String updated;

  @JsonKey(name: 'byline')
  final String author;

  final String title;

  final String abstract;

  final MediaResponse media;

  const ArticleResponse(
    this.id,
    this.url,
    this.updated,
    this.author,
    this.title,
    this.abstract,
    this.media,
  );

  static ArticleResponse fromJson(Map<String, dynamic> json) => _$ArticleResponseFromJson(json);

  static Article toArticle(ArticleResponse response) => Article(
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
    return 'ArticleResponse{id: $id, url: $url, updated: $updated, author: $author, title: $title, abstract: $abstract}';
  }
}
