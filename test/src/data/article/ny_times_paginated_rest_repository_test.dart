import 'package:allthenews/src/data/article/ny_times_paginated_rest_repository.dart';
import 'package:allthenews/src/data/communication/api/http_client.dart';
import 'package:allthenews/src/domain/common/page.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_cached_repository.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_repository.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockSettingsRepository extends Mock implements SettingsRepository {}

class MockNyTimesRepository extends Mock implements NYTimesRepository {}

class MockNyTimesCachedRepository extends Mock implements NyTimesCachedRepository {}

void main() {
  NyTimesPaginatedRestRepository nyTimesPaginatedRestRepository;
  MockNyTimesRepository mockNyTimesRepository;
  MockNyTimesCachedRepository mockNyTimesCachedRepository;
  MockSettingsRepository mockSettingsRepository;

  setUp(() {
    mockNyTimesRepository = MockNyTimesRepository();
    mockNyTimesCachedRepository = MockNyTimesCachedRepository();
    mockSettingsRepository = MockSettingsRepository();
    nyTimesPaginatedRestRepository = NyTimesPaginatedRestRepository(
      mockNyTimesRepository,
      mockNyTimesCachedRepository,
      mockSettingsRepository,
    );
  });

  group('latest news', () {
    test(
      'should get data from remote repository and save it to cache when asks for the first page',
      () async {
        when(mockNyTimesRepository.getNewestArticles()).thenAnswer((_) async => Future.value([]));
        when(mockNyTimesCachedRepository.saveNewestArticles(any)).thenAnswer((_) => Future.value());

        await nyTimesPaginatedRestRepository.getNewestArticlesPage(Page(1, 10));

        verifyInOrder([
          mockNyTimesRepository.getNewestArticles(),
          (mockNyTimesCachedRepository.saveNewestArticles(any)),
        ]);
      },
    );

    test(
      'should not call remote repository and get data from cached repository when asks for the second page',
      () async {
        final secondPage = Page(2, 10);
        when(mockNyTimesRepository.getNewestArticles()).thenAnswer((_) async => Future.value([]));
        when(mockNyTimesCachedRepository.saveNewestArticles(any)).thenAnswer((_) => Future.value());

        await nyTimesPaginatedRestRepository.getNewestArticlesPage(secondPage);

        verifyNever(mockNyTimesRepository.getNewestArticles());
        verify(mockNyTimesCachedRepository.getNewestArticlesPage(secondPage));
      },
    );
  });

  group('most popular news', () {
    test(
      'should get data from remote repository and save it to cache when asks for the first page',
          () async {
        when(mockNyTimesRepository.getMostPopularArticles()).thenAnswer((_) async => Future.value([]));
        when(mockNyTimesCachedRepository.saveMostPopularArticles(any, any)).thenAnswer((_) => Future.value());

        await nyTimesPaginatedRestRepository.getMostPopularArticlesPage(Page(1, 10));

        verifyInOrder([
          mockNyTimesRepository.getMostPopularArticles(),
          (mockNyTimesCachedRepository.saveMostPopularArticles(any, any)),
        ]);
      },
    );

    test(
      'should not call remote repository and get data from cached repository when asks for the second page',
          () async {
        final secondPage = Page(2, 10);
        when(mockNyTimesRepository.getMostPopularArticles()).thenAnswer((_) async => Future.value([]));
        when(mockNyTimesCachedRepository.saveMostPopularArticles(any, any)).thenAnswer((_) => Future.value());

        await nyTimesPaginatedRestRepository.getMostPopularArticlesPage(secondPage);

        verifyNever(mockNyTimesRepository.getMostPopularArticles());
        verify(mockNyTimesCachedRepository.getMostPopularArticlesPage(secondPage, any));
      },
    );
  });
}
