import 'package:allthenews/src/ui/pages/dashboard/news/secondary_news/news_paginated_view_entity.dart';

class LatestNewsViewState {
  final bool isLoading;
  final NewsPaginatedViewEntities viewEntities;
  final Object error;

  const LatestNewsViewState({this.isLoading = false, this.viewEntities, this.error});
}