import 'package:allthenews/src/data/communication/api/network_request.dart';
import 'package:allthenews/src/data/communication/api/request.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_repository.dart';

class _Urls {
  static const baseUrl = "https://api.nytimes.com/svc/";
  static const mostPopular = "mostpopular/v2/emailed/7.json";
}

class NYTimesRESTRepository extends NYTimesRepository {
  final _networkRequest = NetworkRequest(_Urls.baseUrl);

  Future<Article> getFirstMostPopularArticle() async {
    final response = await _networkRequest.get(
      Request(
        path: _Urls.mostPopular,
      ),
    );

    return Article.fromJson(response.data['results'][0]);
  }
}
