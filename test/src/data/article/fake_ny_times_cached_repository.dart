import 'dart:math';

import 'package:allthenews/src/domain/common/page.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_cached_repository.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';

class FakeNyTimesCachedRepository implements NyTimesCachedRepository {
  final List<Article> _newestArticles = [];
  final List<Article> _mostEmailedArticles = [];
  final List<Article> _mostViewedArticles = [];
  final List<Article> _mostSharedArticles = [];

  List<Article> get _sortedNewestArticles => _newestArticles..sort(_sortByDateTimeReversed);

  List<Article> get _sortedMostEmailedArticles => _mostEmailedArticles..sort(_sortByDateTimeReversed);

  List<Article> get _sortedMostViewedArticles => _mostViewedArticles..sort(_sortByDateTimeReversed);

  List<Article> get _sortedMostSharedArticles => _mostSharedArticles..sort(_sortByDateTimeReversed);

  @override
  Future<List<Article>> getNewestArticles() async => _sortedNewestArticles;

  @override
  Future<List<Article>> getMostPopularArticles(PopularNewsCriterion popularNewsCriterion) async => _findMostPopularSortedArticlesBy(popularNewsCriterion);

  @override
  Future<List<Article>> getNewestArticlesPage(Page page) async {
    final fromIndex = (page.number - 1) * page.size;
    return (fromIndex >= _newestArticles.length)
        ? []
        : _sortedNewestArticles.sublist(fromIndex, min(fromIndex + page.size, _newestArticles.length));
  }
  @override
  Future<List<Article>> getMostPopularArticlesPage(Page page, PopularNewsCriterion popularNewsCriterion) async {
    final articles = _findMostPopularSortedArticlesBy(popularNewsCriterion);
    final fromIndex = (page.number - 1) * page.size;
    return (fromIndex >= articles.length)
        ? []
        : articles.sublist(fromIndex, min(fromIndex + page.size, articles.length));
  }

  @override
  Future<void> saveMostPopularArticles(List<Article> articles, PopularNewsCriterion popularNewsCriterion) async =>
      _findMostPopularSortedArticlesBy(popularNewsCriterion).addAll(articles);

  @override
  Future<void> saveNewestArticles(List<Article> articles) async => _newestArticles.addAll(articles);

  @override
  Future<Article> getLatestArticle() async => _newestArticles.isEmpty ? null : _sortedNewestArticles.first;

  @override
  Future<Article> getLatestMostPopularArticle(PopularNewsCriterion popularNewsCriterion) async {
    final articles = _findMostPopularSortedArticlesBy(popularNewsCriterion);
    return articles.isEmpty ? null : articles.first;
  }

  List<Article> _findMostPopularSortedArticlesBy(PopularNewsCriterion popularNewsCriterion) {
    switch (popularNewsCriterion) {
      case PopularNewsCriterion.viewed:
        return _sortedMostViewedArticles;
      case PopularNewsCriterion.shared:
        return _sortedMostSharedArticles;
      case PopularNewsCriterion.emailed:
        return _sortedMostEmailedArticles;
      default:
        return null;
    }
  }
}

int _sortByDateTimeReversed(Article first, Article second) => second?.updateDateTime?.compareTo(first?.updateDateTime) ?? 0;
