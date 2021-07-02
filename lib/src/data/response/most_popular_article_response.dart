import 'package:allthenews/src/data/response/image_format.dart';
import 'package:allthenews/src/data/response/most_popular_media_response.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:json_annotation/json_annotation.dart';

part 'most_popular_article_response.g.dart';

abstract class _Constants {
  static const imageMediaType = "image";
}

@JsonSerializable()
class MostPopularArticleResponse {
  final int id;

  final String url;

  @JsonKey(fromJson: DateTime.parse)
  final DateTime updated;

  @JsonKey(name: 'byline')
  final String author;

  final String title;

  final String abstract;

  final List<MostPopularMediaResponse> media;

  const MostPopularArticleResponse(
    this.id,
    this.url,
    this.updated,
    this.author,
    this.title,
    this.abstract,
    this.media,
  );

  static MostPopularArticleResponse fromJson(Map<String, dynamic> json) =>
      _$MostPopularArticleResponseFromJson(json);

  static Article toArticle(MostPopularArticleResponse response) => Article(
      authorName: response.author,
      title: response.title,
      abstract: response.abstract,
      updateDateTime: response.updated,
      url: response.url,
      thumbnail: response.media.isNotEmpty
          ? response.media
              .firstWhereOrNull((element) => element.type == _Constants.imageMediaType)
              ?.mediaMetadata
              ?.firstWhereOrNull((element) => element.format == ImageFormat.large)
              ?.url
          : null);
}
