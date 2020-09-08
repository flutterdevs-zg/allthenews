// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multimedia.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Multimedia _$MultimediaFromJson(Map<String, dynamic> json) {
  return Multimedia(
    json['type'] as String,
    json['subtype'] as String,
    json['caption'] as String,
    json['format'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$MultimediaToJson(Multimedia instance) =>
    <String, dynamic>{
      'type': instance.type,
      'subtype': instance.subtype,
      'caption': instance.caption,
      'format': instance.format,
      'url': instance.thumbnail,
    };
