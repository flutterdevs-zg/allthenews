// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newest_article_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewestArticleResponse _$NewestArticleResponseFromJson(
    Map<String, dynamic> json) {
  return NewestArticleResponse(
    json['url'] as String,
    DateTime.parse(json['updated_date'] as String),
    json['byline'] as String,
    json['title'] as String,
    json['abstract'] as String,
    (json['multimedia'] as List<dynamic>?)
        ?.map((e) => Multimedia.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$NewestArticleResponseToJson(
        NewestArticleResponse instance) =>
    <String, dynamic>{
      'url': instance.url,
      'updated_date': instance.updated.toIso8601String(),
      'byline': instance.author,
      'title': instance.title,
      'abstract': instance.abstract,
      'multimedia': instance.multimedia,
    };
