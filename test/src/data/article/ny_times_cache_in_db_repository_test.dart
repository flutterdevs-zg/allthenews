import 'package:allthenews/src/data/article/ny_times_cached_in_db_repository.dart';
import 'package:allthenews/src/data/communication/api/http_client.dart';
import 'package:allthenews/src/data/persistence/database/app_database.dart';
import 'package:allthenews/src/data/persistence/database/article_dao.dart';
import 'package:allthenews/src/data/persistence/database/article_dto_type_converter.dart';
import 'package:allthenews/src/domain/common/page.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moor/moor.dart';

class MockHttpClient extends Mock implements HttpClient {}

class FakeArticleDao extends Mock implements ArticleDao {
  final List<ArticleDto> cachedArticles = [];

  @override
  Future<List<ArticleDto>> getMostPopularArticles(PopularNewsCriterion popularNewsCriterion) => Future.value(cachedArticles);

  @override
  Future<List<ArticleDto>> getMostPopularArticlesPage(Page page, PopularNewsCriterion popularNewsCriterion) => Future.value(cachedArticles);

  @override
  Future<List<ArticleDto>> getNewestArticlesPage(Page page) => Future.value(cachedArticles);

  @override
  Future<List<ArticleDto>> getNewestArticles() => Future.value(cachedArticles);

  @override
  Future<void> insertArticles(List<Insertable<ArticleDto>> articleList) async {
    cachedArticles.addAll(articleList.map((e) => mapFromCompanion(e)).toList());
  }

  ArticleDto mapFromCompanion(Insertable<ArticleDto> companion) {
    final asColumnMap = companion.toColumns(false);
    final context = GenerationContext(SqlTypeSystem.defaultInstance, null);
    final rawValues = asColumnMap.cast<String, Variable>().map((key, value) => MapEntry(key, value.mapToSimpleValue(context)));

    return ArticleDto(
      url: rawValues['url'] as String,
      updateDateTime: rawValues['updateDateTime'] as DateTime,
      authorName: rawValues['authorName'] as String,
      title: rawValues['title'] as String,
      abstract: rawValues['abstract'] as String,
      type: const ArticleDtoTypeConverter().mapToDart(rawValues['type'] as String),
    );
  }
}

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

        expect(articles, isNot(null));
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

        expect(articles, isNot(null));
        expect(articles, isNotEmpty);
      },
    );
  });

  group('most popular news', () {
    test(
      'should return empty list when there is no most popular news in database',
      () async {
        final articles = await nyTimesCachedInDbRepository.getMostPopularArticles(PopularNewsCriterion.emailed);

        expect(articles, isNot(null));
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

        expect(articles, isNot(null));
        expect(articles, isNotEmpty);
      },
    );
  });
}
