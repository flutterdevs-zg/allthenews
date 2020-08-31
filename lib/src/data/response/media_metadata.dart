import 'package:json_annotation/json_annotation.dart';

part 'media_metadata.g.dart';

@JsonSerializable()
class MediaMetadata {
  final String url;

  final String format;

  final int height;

  final int width;

  MediaMetadata(this.url, this.format, this.height, this.width);

  static MediaMetadata fromJson(Map<String, dynamic> json) => _$MediaMetadataFromJson(json);
}
