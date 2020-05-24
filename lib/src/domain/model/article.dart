import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Article   {
  final String id;

  final String title;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}
