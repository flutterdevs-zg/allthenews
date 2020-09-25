import 'package:allthenews/src/domain/model/article.dart';

abstract class NYTimesReactiveRepository {

  Stream<List<Article>> getMostPopularArticlesStream();

  Stream<List<Article>> getNewestArticlesStream();

}
