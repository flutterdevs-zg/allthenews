import 'package:allthenews/src/domain/model/article.dart';

abstract class NYTimesRepository {
  Future<List<Article>> getArticles();
}
