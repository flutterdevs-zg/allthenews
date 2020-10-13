import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/ui/pages/home/news/primary_news/primary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/home/news/secondary_news/secondary_news_list_entity.dart';
import 'package:allthenews/src/ui/common/util/date_time_extensions.dart';

extension ArticlesMapper on List<Article> {
  List<PrimaryNewsListEntity> toPrimaryNewsListEntity() => map(
        (article) => PrimaryNewsListEntity(
          title: article.title,
          articleUrl: article.url,
          authorName: article.authorName,
          date: article.updateDateTime.formatDate(),
          imageUrl: article.thumbnail,
          time: article.updateDateTime.formatTime(),
        ),
      ).toList();

  List<SecondaryNewsListEntity> toSecondaryNewsListEntities() => map(
        (article) => SecondaryNewsListEntity(
          title: article.title,
          date: article.updateDateTime.formatDate(),
          imageUrl: article.thumbnail,
          time: article.updateDateTime.formatTime(),
          articleUrl: article.url,
        ),
      ).toList();
}
