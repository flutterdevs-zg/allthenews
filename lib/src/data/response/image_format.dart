import 'package:json_annotation/json_annotation.dart';

enum ImageFormat {
  @JsonValue('Standard Thumbnail')
  small,

  @JsonValue('mediumThreeByTwo210')
  medium,

  @JsonValue('Normal')
  normal,

  @JsonValue('mediumThreeByTwo440')
  large,
}
