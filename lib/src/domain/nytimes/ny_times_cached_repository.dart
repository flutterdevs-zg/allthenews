import 'package:allthenews/src/domain/common/page.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';

abstract class NyTimesCachedRepository {
  Future<List<Article>> getNewestArticles();

  Future<List<Article>> getMostPopularArticles(PopularNewsCriterion popularNewsCriterion);

  Future<List<Article>> getNewestArticlesPage(Page page);

  Future<List<Article>> getMostPopularArticlesPage(Page page, PopularNewsCriterion popularNewsCriterion);

  Future<Article> getLatestArticle();

  Future<Article> getLatestMostPopularArticle(PopularNewsCriterion popularNewsCriterion);

  Future<void> saveMostPopularArticles(List<Article> articles, PopularNewsCriterion popularNewsCriterion);

  Future<void> saveNewestArticles(List<Article> articles);
}
