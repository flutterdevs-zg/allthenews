import 'package:allthenews/src/ui/pages/dashboard/news/secondary_news/news_paginated_view_entity.dart';
import 'package:flutter/cupertino.dart';

class MostPopularNewsViewEntity {
  final NewsPaginatedViewEntities newsPaginatedViewEntities;
  final String mostPopularNewsPageTitle;

  List<NewsPaginatedViewEntity> get entities => newsPaginatedViewEntities.entities;

  MostPopularNewsViewEntity({@required this.newsPaginatedViewEntities, @required this.mostPopularNewsPageTitle});

}
