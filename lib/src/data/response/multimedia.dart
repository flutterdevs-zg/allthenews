import 'package:allthenews/src/data/response/image_format.dart';
import 'package:json_annotation/json_annotation.dart';

part 'multimedia.g.dart';

@JsonSerializable()
class Multimedia {
  final String type;

  final String subtype;

  final String caption;

  final ImageFormat format;

  @JsonKey(name: 'url')
  final String thumbnail;

  const Multimedia(
    this.type,
    this.subtype,
    this.caption,
    this.format,
    this.thumbnail,
  );

  static Multimedia fromJson(Map<String, dynamic> json) => _$MultimediaFromJson(json);
}
