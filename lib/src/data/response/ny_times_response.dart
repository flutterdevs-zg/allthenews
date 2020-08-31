import 'package:allthenews/src/data/response/article_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ny_times_response.g.dart';

@JsonSerializable()
class NyTimesResponse {
  final String copyright;
  @JsonKey(name: 'num_results')
  final int numResults;

  @JsonKey(name: 'results')
  final List<ArticleResponse> articles;

  NyTimesResponse({
    this.copyright,
    this.numResults,
    this.articles,
  });

  static NyTimesResponse fromJson(Map<String, dynamic> json) => _$NyTimesResponseFromJson(json);
}
