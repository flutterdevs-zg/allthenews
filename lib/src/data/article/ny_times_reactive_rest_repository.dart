import 'dart:async';

import 'package:allthenews/src/data/persistence/cache/cache_policy.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_cached_repository.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_reactive_repository.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_repository.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';

class NyTimesReactiveRestRepository extends NYTimesReactiveRepository {
  final NYTimesRepository _nyTimesRepository;
  final NyTimesCachedRepository _nyTimesCachedRepository;
  final CachePolicy<Article?> _articleCachePolicy;
  final SettingsRepository _settingsRepository;

  NyTimesReactiveRestRepository(
    this._nyTimesRepository,
    this._nyTimesCachedRepository,
    this._articleCachePolicy,
    this._settingsRepository,
  );

  @override
  Stream<List<Article>> getMostPopularArticlesStream() async* {
    final PopularNewsCriterion popularNewsCriterion = await _settingsRepository.getPopularNewsCriterion();
    final Article? latestCachedArticle = await _nyTimesCachedRepository.getLatestMostPopularArticle(popularNewsCriterion);
    if (_articleCachePolicy.isValid(latestCachedArticle)) {
      yield await _nyTimesCachedRepository.getMostPopularArticles(popularNewsCriterion);
    }
    yield await _nyTimesRepository
        .getMostPopularArticles()
        .then((articles) => _nyTimesCachedRepository.saveMostPopularArticles(articles, popularNewsCriterion))
        .then((_) => _nyTimesCachedRepository.getMostPopularArticles(popularNewsCriterion));
  }

  @override
  Stream<List<Article>> getNewestArticlesStream() async* {
    final Article? latestCachedArticle = await _nyTimesCachedRepository.getLatestArticle();
    if (_articleCachePolicy.isValid(latestCachedArticle)) {
      yield await _nyTimesCachedRepository.getNewestArticles();
    }
    yield await _nyTimesRepository
        .getNewestArticles()
        .then((articles) => _nyTimesCachedRepository.saveNewestArticles(articles))
        .then((_) => _nyTimesCachedRepository.getNewestArticles());
  }
}
