import 'package:allthenews/src/data/persistence/database/app_database.dart';
import 'package:allthenews/src/data/persistence/database/article_dao.dart';
import 'package:allthenews/src/data/persistence/database/article_dto_type_converter.dart';
import 'package:allthenews/src/domain/common/page.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:mockito/mockito.dart';
import 'package:moor/moor.dart';

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