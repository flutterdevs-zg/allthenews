import 'package:allthenews/src/data/communication/api/request_factory.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:async/async.dart';

class NYTimesRepository {
  final requestFactory = RequestFactory("https://api.nytimes.com/svc/");

  Future<Article> getFirstMostPopularArticle() async {
    final Result<dynamic> result =
        await requestFactory.networkRequest("mostpopular/v2/emailed/7.json");

    return result.asValue.value.map((json) => Article.fromJson(json)).toList().first;
  }
}
