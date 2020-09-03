// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleResponse _$ArticleResponseFromJson(Map<String, dynamic> json) {
  return ArticleResponse(
    json['id'] as int,
    json['url'] as String,
    json['updated'] as String,
    json['byline'] as String,
    json['title'] as String,
    json['abstract'] as String,
    (json['media'] as List)
        ?.map((e) => e == null
            ? null
            : MediaResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ArticleResponseToJson(ArticleResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'updated': instance.updated,
      'byline': instance.author,
      'title': instance.title,
      'abstract': instance.abstract,
      'media': instance.media,
    };
