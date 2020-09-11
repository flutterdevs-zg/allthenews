// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaMetadata _$MediaMetadataFromJson(Map<String, dynamic> json) {
  return MediaMetadata(
    json['url'] as String,
    _$enumDecodeNullable(_$ImageFormatEnumMap, json['format']),
    json['height'] as int,
    json['width'] as int,
  );
}

Map<String, dynamic> _$MediaMetadataToJson(MediaMetadata instance) =>
    <String, dynamic>{
      'url': instance.url,
      'format': _$ImageFormatEnumMap[instance.format],
      'height': instance.height,
      'width': instance.width,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ImageFormatEnumMap = {
  ImageFormat.small: 'Standard Thumbnail',
  ImageFormat.medium: 'mediumThreeByTwo210',
  ImageFormat.normal: 'Normal',
  ImageFormat.large: 'mediumThreeByTwo440',
};
