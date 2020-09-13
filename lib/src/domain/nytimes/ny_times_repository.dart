import 'package:allthenews/src/domain/model/article.dart';

abstract class NYTimesRepository {
  Future<List<Article>> getMostPopularArticles();

  Future<List<Article>> getNewestArticles();
}
