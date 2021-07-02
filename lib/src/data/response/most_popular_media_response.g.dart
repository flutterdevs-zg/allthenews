// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'most_popular_media_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MostPopularMediaResponse _$MostPopularMediaResponseFromJson(
    Map<String, dynamic> json) {
  return MostPopularMediaResponse(
    json['type'] as String?,
    json['subtype'] as String?,
    json['caption'] as String?,
    (json['media-metadata'] as List<dynamic>?)
        ?.map((e) => MediaMetadata.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MostPopularMediaResponseToJson(
        MostPopularMediaResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'subtype': instance.subtype,
      'caption': instance.caption,
      'media-metadata': instance.mediaMetadata,
    };
