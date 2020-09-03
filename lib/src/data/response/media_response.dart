import 'package:allthenews/src/data/response/media_metadata.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_response.g.dart';

@JsonSerializable()
class MediaResponse {
  final String type;

  final String subtype;

  final String caption;

  @JsonKey(name: 'media-metadata')
  final List<MediaMetadata> mediaMetadata;

  MediaResponse(this.type, this.subtype, this.caption, this.mediaMetadata);

  static MediaResponse fromJson(Map<String, dynamic> json) => _$MediaResponseFromJson(json);
}
