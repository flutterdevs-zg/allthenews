import 'package:allthenews/src/data/response/media_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_response.g.dart';

@JsonSerializable()
class ArticleResponse {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'url')
  final String url;

  @JsonKey(name: 'updated')
  final String updated;

  @JsonKey(name: 'byline')
  final String author;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'abstract')
  final String abstract;

  @JsonKey(name: 'media')
  final MediaResponse media;

  ArticleResponse(
    this.id,
    this.url,
    this.updated,
    this.author,
    this.title,
    this.abstract,
    this.media,
  );

  static ArticleResponse fromJson(Map<String, dynamic> json) => _$ArticleResponseFromJson(json);

  @override
  String toString() {
    return 'ArticleResponse{id: $id, url: $url, updated: $updated, author: $author, title: $title, abstract: $abstract}';
  }
}
