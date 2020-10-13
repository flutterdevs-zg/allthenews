import 'package:allthenews/src/domain/common/page.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_cached_repository.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_paginated_repository.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_repository.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';

class NyTimesPaginatedRestRepository extends NYTimesPaginatedRepository {
  final NYTimesRepository _nyTimesRepository;
  final NyTimesCachedRepository _nyTimesCachedRepository;
  final SettingsRepository _settingsRepository;

  NyTimesPaginatedRestRepository(
    this._nyTimesRepository,
    this._nyTimesCachedRepository,
    this._settingsRepository,
  );

  @override
  Future<List<Article>> getMostPopularArticlesPage(Page page) async {
    final PopularNewsCriterion popularNewsCriterion = await _settingsRepository.getPopularNewsCriterion();
    if (page.number == 1) {
      await _nyTimesRepository.getMostPopularArticles().then((articles) => _nyTimesCachedRepository.saveMostPopularArticles(articles, popularNewsCriterion));
    }
    return _nyTimesCachedRepository.getMostPopularArticlesPage(page, popularNewsCriterion);
  }

  @override
  Future<List<Article>> getNewestArticlesPage(Page page) async {
    if (page.number == 1) {
      await _nyTimesRepository.getNewestArticles().then((articles) => _nyTimesCachedRepository.saveNewestArticles(articles));
    }
    return _nyTimesCachedRepository.getNewestArticlesPage(page);
  }
}
