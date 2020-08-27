// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaResponse _$MediaResponseFromJson(Map<String, dynamic> json) {
  return MediaResponse(
    json['type'] as String,
    json['subtype'] as String,
    json['caption'] as String,
    (json['media-metadata'] as List)
        ?.map((e) => e == null
            ? null
            : MediaMetadata.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MediaResponseToJson(MediaResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'subtype': instance.subtype,
      'caption': instance.caption,
      'media-metadata': instance.mediaMetadata,
    };
