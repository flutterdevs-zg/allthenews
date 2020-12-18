import 'package:allthenews/src/data/article/ny_times_cached_in_db_repository.dart';
import 'package:allthenews/src/data/communication/api/http_client.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../persistence/database/fake_article_dao.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  NyTimesCachedInDbRepository nyTimesCachedInDbRepository;
  FakeArticleDao fakeArticleDao;

  setUp(() {
    fakeArticleDao = FakeArticleDao();
    nyTimesCachedInDbRepository = NyTimesCachedInDbRepository(fakeArticleDao);
  });

  group('latest news', () {
    test(
      'should return empty list when there is no latest news in database',
      () async {
        final articles = await nyTimesCachedInDbRepository.getNewestArticles();

        expect(articles, isNotNull);
        expect(articles, isEmpty);
      },
    );

    test(
      'should return latest news when they are cached in db',
      () async {
        await nyTimesCachedInDbRepository.saveNewestArticles([
          Article(
            url: '',
            updateDateTime: DateTime.now(),
            title: '',
            thumbnail: '',
            authorName: '',
            abstract: '',
          )
        ].toList());

        final articles = await nyTimesCachedInDbRepository.getNewestArticles();

        expect(articles, isNotNull);
        expect(articles, isNotEmpty);
      },
    );
  });

  group('most popular news', () {
    test(
      'should return empty list when there is no most popular news in database',
      () async {
        final articles = await nyTimesCachedInDbRepository.getMostPopularArticles(PopularNewsCriterion.emailed);

        expect(articles, isNotNull);
        expect(articles, isEmpty);
      },
    );

    test(
      'should return most popular news when they are cached in db',
      () async {
        await nyTimesCachedInDbRepository.saveMostPopularArticles(
          [
            Article(
              url: '',
              updateDateTime: DateTime.now(),
              title: '',
              thumbnail: '',
              authorName: '',
              abstract: '',
            )
          ].toList(),
          PopularNewsCriterion.emailed,
        );

        final articles = await nyTimesCachedInDbRepository.getMostPopularArticles(PopularNewsCriterion.emailed);

        expect(articles, isNotNull);
        expect(articles, isNotEmpty);
      },
    );
  });
}
