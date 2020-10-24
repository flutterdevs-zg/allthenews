import 'package:allthenews/src/ui/pages/dashboard/news/secondary_news/secondary_news_list_entity.dart';
import 'package:flutter/foundation.dart';

class NewsPaginatedViewEntities {
  final List<NewsPaginatedViewEntity> entities;
  final bool hasMoreElements;

  NewsPaginatedViewEntities({
    @required this.entities,
    @required this.hasMoreElements,
  });

  List<ContentNewsPaginatedViewEntity> get newsPaginatedContentViewEntities => entities.whereType<ContentNewsPaginatedViewEntity>().toList();
}

abstract class NewsPaginatedViewEntity {}

class ContentNewsPaginatedViewEntity extends NewsPaginatedViewEntity {
  final SecondaryNewsListEntity value;

  ContentNewsPaginatedViewEntity(this.value);
}

class LoadingNewsPaginatedViewEntity extends NewsPaginatedViewEntity {}
