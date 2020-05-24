import 'package:allthenews/src/ui/pages/home/news/primary_news/primary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/home/news/secondary_news/secondary_news_list_entity.dart';

extension PrimaryNewsEntityMapper on List<PrimaryNewsListEntity> {
  List<SecondaryNewsListEntity> mapToSecondaryNewsListEntities() {
    return this
        .map(
          (primaryEntity) => SecondaryNewsListEntity(
            title: primaryEntity.title,
            date: primaryEntity.date,
            imageUrl: primaryEntity.imageUrl,
            time: primaryEntity.time,
            articleUrl: primaryEntity.articleUrl,
          ),
        )
        .toList();
  }
}
