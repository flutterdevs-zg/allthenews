import 'dart:convert';

import 'package:allthenews/src/data/article/ny_times_rest_repository.dart';
import 'package:allthenews/src/data/communication/api/http_client.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../api_stubs/api_stubs_reader.dart';
import 'ny_times_rest_repository_test.mocks.dart';

@GenerateMocks([HttpClient, SettingsRepository])
void main() {
  late NYTimesRestRepository nyTimesRestRepository;
  late MockHttpClient mockHttpClient;
  late MockSettingsRepository mockSettingsRepository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockSettingsRepository = MockSettingsRepository();
    nyTimesRestRepository = NYTimesRestRepository(mockHttpClient, mockSettingsRepository);

    when(mockSettingsRepository.getPopularNewsCriterion()).thenAnswer((_) async => PopularNewsCriterion.emailed);
  });

  group('contract tests', () {
    test(
      'should return valid most popular news when nytimes api call finishes successfully',
      () async {
        when(mockHttpClient.get(any)).thenAnswer((_) async => json.decode(findApiStubBy('most_popular_news.json')));

        final articles = await nyTimesRestRepository.getMostPopularArticles();

        expect(articles, isA<List<Article>>());
        expect(articles, isNotEmpty);

        final article = articles.first;

        expect(article, isNotNull);
        expect(article.abstract, isNotNull);
        expect(article.url, isNotNull);
        expect(article.updateDateTime, isNotNull);
        expect(article.authorName, isNotNull);
        expect(article.title, isNotNull);
        expect(article.thumbnail, isNotNull);
      },
    );

    test(
      'should return valid latest news when nytimes api call finishes successfully',
      () async {
        when(mockHttpClient.get(any)).thenAnswer((_) async => json.decode(findApiStubBy('latest_news.json')));

        final articles = await nyTimesRestRepository.getNewestArticles();

        expect(articles, isA<List<Article>>());
        expect(articles, isNotEmpty);

        final article = articles.first;

        expect(article, isNotNull);
        expect(article.abstract, isNotNull);
        expect(article.url, isNotNull);
        expect(article.updateDateTime, isNotNull);
        expect(article.authorName, isNotNull);
        expect(article.title, isNotNull);
        expect(article.thumbnail, isNotNull);
      },
    );
  });
}
