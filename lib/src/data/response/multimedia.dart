import 'package:json_annotation/json_annotation.dart';

part 'multimedia.g.dart';

@JsonSerializable()
class Multimedia {
  final String type;

  final String subtype;

  final String caption;

  final String format;

  @JsonKey(name: 'url')
  final String thumbnail;

  Multimedia(this.type, this.subtype, this.caption, this.format, this.thumbnail);

  static Multimedia fromJson(Map<String, dynamic> json) => _$MultimediaFromJson(json);
}
