import 'package:allthenews/src/ui/pages/dashboard/news/secondary_news/secondary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/secondary_news/secondary_news_list_item.dart';
import 'package:flutter/material.dart';

class SecondaryNewsListView extends StatelessWidget {
  final List<SecondaryNewsListEntity> secondaryNewsListEntities;

  const SecondaryNewsListView({
    @required this.secondaryNewsListEntities,
  }) : assert(secondaryNewsListEntities != null);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: secondaryNewsListEntities.length,
        itemBuilder: (context, index) {
          final viewEntity = secondaryNewsListEntities[index];
          return Hero(
            tag: viewEntity.title,
            child: SecondaryNewsListItem(news: viewEntity),
          );
        },
      ),
    );
  }
}
