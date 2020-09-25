import 'package:allthenews/src/data/persistence/database/article_dto.dart';
import 'package:allthenews/src/data/persistence/database/article_dto_type_converter.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:moor/moor.dart';
import 'app_database.dart';

part 'article_dao.g.dart';

@UseDao(tables: [Articles])
class ArticleDao extends DatabaseAccessor<AppDatabase> with _$ArticleDaoMixin {
  ArticleDao(AppDatabase db) : super(db);

  Future<List<ArticleDto>> getMostPopularArticles(PopularNewsCriterion popularNewsCriterion) => (select(articles)
        ..where((article) => article.type.equals(popularNewsCriterion.toDtoType().toString()))
        ..orderBy(
          ([
            (article) => OrderingTerm(expression: article.updateDateTime, mode: OrderingMode.desc),
            (article) => OrderingTerm(expression: article.title),
          ]),
        ))
      .get();

  Future<List<ArticleDto>> getNewestArticles() => (select(articles)
        ..where((article) => article.type.equals(ArticleDtoType.newest.toString()))
        ..orderBy(
          ([
            (article) => OrderingTerm(expression: article.updateDateTime, mode: OrderingMode.desc),
            (article) => OrderingTerm(expression: article.title),
          ]),
        ))
      .get();

  Future<void> insertArticles(List<Insertable<ArticleDto>> articleList) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(articles, articleList);
    });
  }

  Future<ArticleDto> getLatestArticle() => (select(articles)
        ..where((article) => article.type.equals(ArticleDtoType.newest.toString()))
        ..orderBy(
          ([
            (article) => OrderingTerm(expression: article.updateDateTime, mode: OrderingMode.desc),
            (article) => OrderingTerm(expression: article.title),
          ]),
        )
        ..limit(1))
      .getSingle();

  Future<ArticleDto> getLatestMostPopularArticle(PopularNewsCriterion popularNewsCriterion) => (select(articles)
        ..where((article) => article.type.equals(popularNewsCriterion.toDtoType().toString()))
        ..orderBy(
          ([
            (article) => OrderingTerm(expression: article.updateDateTime, mode: OrderingMode.desc),
            (article) => OrderingTerm(expression: article.title),
          ]),
        )
        ..limit(1))
      .getSingle();
}

extension PopularNewsCriterionExtension on PopularNewsCriterion {
  ArticleDtoType toDtoType() {
    switch (this) {
      case PopularNewsCriterion.viewed:
        return ArticleDtoType.mostViewed;
      case PopularNewsCriterion.shared:
        return ArticleDtoType.mostShared;
      case PopularNewsCriterion.emailed:
        return ArticleDtoType.mostEmailed;
      default:
        return null;
    }
  }
}
