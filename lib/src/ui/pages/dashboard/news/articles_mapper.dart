import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/ui/common/util/mapper.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/primary_news/primary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/secondary_news/secondary_news_list_entity.dart';
import 'package:allthenews/src/ui/common/util/date_time_extensions.dart';

class SecondaryNewsViewEntityMapper extends Mapper<Article, SecondaryNewsListEntity> {
  @override
  SecondaryNewsListEntity map(Article article) => SecondaryNewsListEntity(
        title: article.title,
        date: article.updateDateTime.formatDate(),
        imageUrl: article.thumbnail,
        time: article.updateDateTime.formatTime(),
        articleUrl: article.url,
      );
}

class PrimaryNewsViewEntityMapper extends Mapper<Article, PrimaryNewsListEntity> {
  @override
  PrimaryNewsListEntity map(Article article) => PrimaryNewsListEntity(
        title: article.title,
        articleUrl: article.url,
        authorName: article.authorName,
        date: article.updateDateTime.formatDate(),
        imageUrl: article.thumbnail,
        time: article.updateDateTime.formatTime(),
      );
}
