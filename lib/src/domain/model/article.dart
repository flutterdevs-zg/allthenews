import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  final int id;

  final String title;

  Article({this.id, this.title});

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  @override
  String toString() => 'Article{id: $id, title: $title}';
}
