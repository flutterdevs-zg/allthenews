import 'package:allthenews/src/data/communication/api/http_client.dart';
import 'package:allthenews/src/data/communication/api/request.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_repository.dart';

class _Urls {
  static const mostPopular = "mostpopular/v2/emailed/7.json";
}

class NYTimesRestRepository extends NYTimesRepository {
  final HttpClient _httpClient;

  NYTimesRestRepository(this._httpClient);

  @override
  Future<Article> getFirstMostPopularArticle() async {
    final response = await _httpClient.get(
      Request(
        path: _Urls.mostPopular,
      ),
    );

    return Article.fromJson(response.data['results'][0] as Map<String, dynamic>);
  }
}
