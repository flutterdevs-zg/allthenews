import 'package:allthenews/src/data/response/image_format.dart';
import 'package:allthenews/src/data/response/multimedia.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:json_annotation/json_annotation.dart';

part 'newest_article_response.g.dart';

@JsonSerializable()
class NewestArticleResponse {
  final int id;

  final String url;

  @JsonKey(name: 'updated_date', fromJson: DateTime.parse)
  final DateTime updated;

  @JsonKey(name: 'byline')
  final String author;

  final String title;

  final String abstract;

  final List<Multimedia> multimedia;

  const NewestArticleResponse(
    this.id,
    this.url,
    this.updated,
    this.author,
    this.title,
    this.abstract,
    this.multimedia,
  );

  static NewestArticleResponse fromJson(Map<String, dynamic> json) =>
      _$NewestArticleResponseFromJson(json);

  static Article toArticle(NewestArticleResponse response) => Article(
        id: response.id,
        authorName: response.author,
        title: response.title,
        abstract: response.abstract,
        updateDateTime: response.updated,
        url: response.url,
        thumbnail: response.multimedia
            ?.firstWhere((element) => element.format == ImageFormat.medium)
            ?.thumbnail,
      );
}
