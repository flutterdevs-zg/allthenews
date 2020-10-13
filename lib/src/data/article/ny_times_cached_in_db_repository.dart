import 'package:allthenews/src/data/persistence/database/article_dao.dart';
import 'package:allthenews/src/domain/common/page.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_cached_repository.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/data/article/mapper/article_dto_mapper.dart';

class NyTimesCachedInDbRepository extends NyTimesCachedRepository {
  final ArticleDao _articleDao;

  NyTimesCachedInDbRepository(this._articleDao);

  @override
  Future<void> saveMostPopularArticles(List<Article> articles, PopularNewsCriterion popularNewsCriterion) =>
      _articleDao.insertArticles(articles.map((article) => article.toMostPopularArticleCompanion(popularNewsCriterion)).toList());

  @override
  Future<List<Article>> getMostPopularArticles(PopularNewsCriterion popularNewsCriterion) =>
      _articleDao.getMostPopularArticles(popularNewsCriterion).then((articles) => articles.map((articleDto) => articleDto.toDomain()).toList());

  @override
  Future<List<Article>> getNewestArticles() => _articleDao.getNewestArticles().then((articles) => articles.map((articleDto) => articleDto.toDomain()).toList());

  @override
  Future<void> saveNewestArticles(List<Article> articles) => _articleDao.insertArticles(articles.map((article) => article.toNewestArticleCompanion()).toList());

  @override
  Future<Article> getLatestArticle() async => (await _articleDao.getLatestArticle())?.toDomain();

  @override
  Future<Article> getLatestMostPopularArticle(PopularNewsCriterion popularNewsCriterion) async =>
      (await _articleDao.getLatestMostPopularArticle(popularNewsCriterion))?.toDomain();

  @override
  Future<List<Article>> getNewestArticlesPage(Page page) =>
      _articleDao.getNewestArticlesPage(page).then((articles) => articles.map((articleDto) => articleDto.toDomain()).toList());

  @override
  Future<List<Article>> getMostPopularArticlesPage(Page page, PopularNewsCriterion popularNewsCriterion) => _articleDao
      .getMostPopularArticlesPage(page, popularNewsCriterion)
      .then((articles) => articles.map((articleDto) => articleDto.toDomain()).toList());
}
