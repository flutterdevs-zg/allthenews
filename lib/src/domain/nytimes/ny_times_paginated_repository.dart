import 'package:allthenews/src/domain/common/page.dart';
import 'package:allthenews/src/domain/model/article.dart';

abstract class NYTimesPaginatedRepository {

  Future<List<Article>> getMostPopularArticlesPage(Page page);

  Future<List<Article>> getNewestArticlesPage(Page page);

}