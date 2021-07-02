// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'most_popular_article_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MostPopularArticleResponse _$MostPopularArticleResponseFromJson(
    Map<String, dynamic> json) {
  return MostPopularArticleResponse(
    json['id'] as int,
    json['url'] as String,
    DateTime.parse(json['updated'] as String),
    json['byline'] as String,
    json['title'] as String,
    json['abstract'] as String,
    (json['media'] as List<dynamic>)
        .map(
            (e) => MostPopularMediaResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MostPopularArticleResponseToJson(
        MostPopularArticleResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'updated': instance.updated.toIso8601String(),
      'byline': instance.author,
      'title': instance.title,
      'abstract': instance.abstract,
      'media': instance.media,
    };
