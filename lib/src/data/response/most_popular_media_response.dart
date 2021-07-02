import 'package:allthenews/src/data/response/media_metadata.dart';
import 'package:json_annotation/json_annotation.dart';

part 'most_popular_media_response.g.dart';

@JsonSerializable()
class MostPopularMediaResponse {
  final String? type;

  final String? subtype;

  final String? caption;

  @JsonKey(name: 'media-metadata')
  final List<MediaMetadata>? mediaMetadata;

  const MostPopularMediaResponse(
    this.type,
    this.subtype,
    this.caption,
    this.mediaMetadata,
  );

  static MostPopularMediaResponse fromJson(Map<String, dynamic> json) =>
      _$MostPopularMediaResponseFromJson(json);
}
