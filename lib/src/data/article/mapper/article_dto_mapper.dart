import 'package:allthenews/src/data/persistence/database/app_database.dart';
import 'package:allthenews/src/data/persistence/database/article_dto_type_converter.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/data/persistence/database/article_dao.dart';
import 'package:moor/moor.dart';

extension ArticleDtoExtension on ArticleDto {
  Article toDomain() => Article(
        authorName: authorName,
        title: title,
        abstract: abstract,
        updateDateTime: updateDateTime,
        url: url,
        thumbnail: thumbnail,
      );
}

extension ArticleExtensions on Article {
  ArticlesCompanion toMostPopularArticleCompanion(PopularNewsCriterion criterion) => ArticlesCompanion(
        title: Value(title),
        abstract: Value(abstract),
        authorName: Value(authorName),
        thumbnail: Value(thumbnail),
        type: Value(criterion.toDtoType()),
        updateDateTime: Value(updateDateTime),
        url: Value(url),
      );

  ArticlesCompanion toNewestArticleCompanion() => ArticlesCompanion(
        title: Value(title),
        abstract: Value(abstract),
        authorName: Value(authorName),
        thumbnail: Value(thumbnail),
        type: const Value(ArticleDtoType.newest),
        updateDateTime: Value(updateDateTime),
        url: Value(url),
      );
}
