import 'package:allthenews/src/data/response/image_format.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_metadata.g.dart';

@JsonSerializable()
class MediaMetadata {
  final String url;

  final ImageFormat format;

  final int height;

  final int width;

  MediaMetadata(this.url, this.format, this.height, this.width);

  static MediaMetadata fromJson(Map<String, dynamic> json) => _$MediaMetadataFromJson(json);
}
