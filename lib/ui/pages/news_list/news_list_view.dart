import 'package:allthenews/ui/pages/news_list/secondary_news_list_entity.dart';
import 'package:allthenews/ui/pages/news_list/secondary_news_list_item.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const itemSpacing = 26.0;
}

class NewsListView extends StatelessWidget {
  final List<SecondaryNewsListEntity> secondaryNewsListEntities;

  const NewsListView({
    @required this.secondaryNewsListEntities,
  }) : assert(secondaryNewsListEntities != null);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: _Constants.itemSpacing),
        itemCount: secondaryNewsListEntities.length,
        itemBuilder: (context, index) =>
            SecondaryNewsListItem(news: secondaryNewsListEntities[index]),
      ),
    );
  }
}
