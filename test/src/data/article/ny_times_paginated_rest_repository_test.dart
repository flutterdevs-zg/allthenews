import 'package:allthenews/src/data/article/ny_times_paginated_rest_repository.dart';
import 'package:allthenews/src/data/communication/api/http_client.dart';
import 'package:allthenews/src/domain/common/page.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_repository.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../domain/article.dart';
import 'fake_ny_times_cached_repository.dart';
import 'ny_times_paginated_rest_repository_test.mocks.dart';

@GenerateMocks([HttpClient, SettingsRepository, NYTimesRepository])
void main() {
  late NyTimesPaginatedRestRepository nyTimesPaginatedRestRepository;
  late MockNYTimesRepository mockNyTimesRepository;
  late FakeNyTimesCachedRepository fakeNyTimesCachedRepository;
  late MockSettingsRepository mockSettingsRepository;

  setUp(() {
    mockNyTimesRepository = MockNYTimesRepository();
    fakeNyTimesCachedRepository = FakeNyTimesCachedRepository();
    mockSettingsRepository = MockSettingsRepository();
    nyTimesPaginatedRestRepository = NyTimesPaginatedRestRepository(
      mockNyTimesRepository,
      fakeNyTimesCachedRepository,
      mockSettingsRepository,
    );
  });

  test(
    'should get latest news from remote repository and save it to cache when asks for the first page',
    () async {
      fakeNyTimesCachedRepository.saveNewestArticles(testCachedArticles);
      when(mockNyTimesRepository.getNewestArticles()).thenAnswer((_) async => Future.value(testRestArticles));

      final articles = await nyTimesPaginatedRestRepository.getNewestArticlesPage(Page(1, 2));

      expect(articles, containsAll(testRestArticles));
      expect(testCachedArticles.any((element) => articles.contains(element)), true);
    },
  );

  test(
    'should not call remote repository and get latest news from cached repository when asks for the second page',
    () async {
      fakeNyTimesCachedRepository.saveNewestArticles(testCachedArticles);
      when(mockSettingsRepository.getPopularNewsCriterion()).thenAnswer((_) async => PopularNewsCriterion.emailed);
      when(mockNyTimesRepository.getNewestArticles()).thenAnswer((_) async => Future.value(testRestArticles));

      final articles = await nyTimesPaginatedRestRepository.getNewestArticlesPage(Page(2, 1));

      expect(testRestArticles.any((element) => articles.contains(element)), false);
      expect(testCachedArticles.any((element) => articles.contains(element)), true);
    },
  );

  test(
    'should get most popular news from remote repository and save it to cache when asks for the first page',
    () async {
      fakeNyTimesCachedRepository.saveMostPopularArticles(testCachedArticles, PopularNewsCriterion.emailed);
      when(mockSettingsRepository.getPopularNewsCriterion()).thenAnswer((_) async => PopularNewsCriterion.emailed);
      when(mockNyTimesRepository.getMostPopularArticles()).thenAnswer((_) async => Future.value(testRestArticles));

      final articles = await nyTimesPaginatedRestRepository.getMostPopularArticlesPage(Page(1, 2));

      expect(articles, containsAll(testRestArticles));
      expect(testCachedArticles.any((element) => articles.contains(element)), true);
    },
  );

  test(
    'should not call remote repository and get most popular articles from cached repository when asks for the second page',
    () async {
      fakeNyTimesCachedRepository.saveMostPopularArticles(testCachedArticles, PopularNewsCriterion.emailed);
      when(mockSettingsRepository.getPopularNewsCriterion()).thenAnswer((_) async => PopularNewsCriterion.emailed);
      when(mockNyTimesRepository.getMostPopularArticles()).thenAnswer((_) async => Future.value(testRestArticles));

      final articles = await nyTimesPaginatedRestRepository.getMostPopularArticlesPage(Page(2, 1));

      expect(testRestArticles.any((element) => articles.contains(element)), false);
      expect(testCachedArticles.any((element) => articles.contains(element)), true);
    },
  );
}
