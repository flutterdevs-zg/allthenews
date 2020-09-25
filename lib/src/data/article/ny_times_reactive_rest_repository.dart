import 'dart:async';

import 'package:allthenews/src/data/persistence/cache/cache_policy.dart';
import 'package:allthenews/src/data/persistence/database/article_dao.dart';
import 'package:allthenews/src/data/article/mapper/article_dto_mapper.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_reactive_repository.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_repository.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';

class NyTimesReactiveRestRepository extends NYTimesReactiveRepository {
  final NYTimesRepository _nyTimesRepository;
  final ArticleDao _articleDao;
  final CachePolicy<Article> _articleCachePolicy;
  final SettingsRepository _settingsRepository;

  NyTimesReactiveRestRepository(
    this._nyTimesRepository,
    this._articleDao,
    this._articleCachePolicy,
    this._settingsRepository,
  );

  @override
  Stream<List<Article>> getMostPopularArticlesStream() async* {
    final PopularNewsCriterion popularNewsCriterion = await _settingsRepository.getPopularNewsCriterion();
    final Article latestCachedArticle = (await _articleDao.getLatestMostPopularArticle(popularNewsCriterion))?.toDomain();
    if (_articleCachePolicy.isValid(latestCachedArticle)) {
      yield await _getMostPopularArticlesFromCache(popularNewsCriterion);
    }
    yield await _nyTimesRepository
        .getMostPopularArticles()
        .then((articles) => _cacheMostPopularArticles(articles, popularNewsCriterion))
        .then((_) => _getMostPopularArticlesFromCache(popularNewsCriterion));
  }

  @override
  Stream<List<Article>> getNewestArticlesStream() async* {
    final Article latestCachedArticle = (await _articleDao.getLatestArticle())?.toDomain();
    if (_articleCachePolicy.isValid(latestCachedArticle)) {
      yield await _getNewestArticlesFromCache();
    }
    yield await _nyTimesRepository
        .getNewestArticles()
        .then((articles) => _cacheNewestArticles(articles))
        .then((_) => _getNewestArticlesFromCache());
  }

  Future<void> _cacheMostPopularArticles(List<Article> articles, PopularNewsCriterion popularNewsCriterion) =>
      _articleDao.insertArticles(articles.map((article) => article.toMostPopularArticleCompanion(popularNewsCriterion)).toList());

  Future<List<Article>> _getMostPopularArticlesFromCache(PopularNewsCriterion popularNewsCriterion) => _articleDao
      .getMostPopularArticles(popularNewsCriterion)
      .then((articles) => articles.map((articleDto) => articleDto.toDomain()).toList());

  Future<List<Article>> _getNewestArticlesFromCache() =>
      _articleDao.getNewestArticles().then((articles) => articles.map((articleDto) => articleDto.toDomain()).toList());

  Future<void> _cacheNewestArticles(List<Article> articles) =>
      _articleDao.insertArticles(articles.map((article) => article.toNewestArticleCompanion()).toList());
}
