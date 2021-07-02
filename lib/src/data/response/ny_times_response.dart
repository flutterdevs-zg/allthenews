class NyTimesResponse<T> {
  final String copyright;
  final int numResults;
  final List<T> articles;

  const NyTimesResponse({
    required this.copyright,
    required this.numResults,
    required this.articles,
  });

  factory NyTimesResponse.fromJson(Map<String, dynamic> json, Function fromJson) {
    final List<Map<String, dynamic>> items = (json['results'] as List).cast<Map<String, dynamic>>();

    return NyTimesResponse<T>(
      copyright: json['copyright'] as String,
      numResults: json['num_results'] as int,
      articles: List<T>.from(items.map((itemJson) => fromJson(itemJson))),
    );
  }
}
