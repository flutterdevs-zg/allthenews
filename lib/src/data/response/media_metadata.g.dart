// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaMetadata _$MediaMetadataFromJson(Map<String, dynamic> json) {
  return MediaMetadata(
    json['url'] as String,
    json['format'] as String,
    json['height'] as int,
    json['width'] as int,
  );
}

Map<String, dynamic> _$MediaMetadataToJson(MediaMetadata instance) =>
    <String, dynamic>{
      'url': instance.url,
      'format': instance.format,
      'height': instance.height,
      'width': instance.width,
    };
