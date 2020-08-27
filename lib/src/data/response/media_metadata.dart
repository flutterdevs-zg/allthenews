import 'package:json_annotation/json_annotation.dart';

part 'media_metadata.g.dart';

@JsonSerializable()
class MediaMetadata {
  @JsonKey(name: 'url')
  final String url;

  @JsonKey(name: 'format')
  final String format;

  @JsonKey(name: 'height')
  final int height;

  @JsonKey(name: 'width')
  final int width;

  MediaMetadata(this.url, this.format, this.height, this.width);

  static MediaMetadata fromJson(Map<String, dynamic> json) => _$MediaMetadataFromJson(json);
}
