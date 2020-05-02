import 'package:allthenews/ui/pages/news_list/news_list_item.dart';
import 'package:allthenews/ui/pages/news_list/news_view_entity.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const itemSpacing = 26.0;
}

class NewsListView extends StatelessWidget {
  final List<NewsViewEntity> newsViewEntities;

  const NewsListView({
    @required this.newsViewEntities,
  }) : assert(newsViewEntities != null);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: _Constants.itemSpacing),
        itemCount: newsViewEntities.length,
        itemBuilder: (context, index) =>
            NewsListItem(news: newsViewEntities[index]),
      ),
    );
  }
}
