import 'package:allthenews/src/data/response/media_metadata.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_response.g.dart';

@JsonSerializable()
class MediaResponse {
  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'subtype')
  final String subtype;

  @JsonKey(name: 'caption')
  final String caption;

  @JsonKey(name: 'media-metadata')
  final List<MediaMetadata> mediaMetadata;

  MediaResponse(this.type, this.subtype, this.caption, this.mediaMetadata);
  

  static MediaResponse fromJson(Map<String, dynamic> json) => _$MediaResponseFromJson(json);


}
