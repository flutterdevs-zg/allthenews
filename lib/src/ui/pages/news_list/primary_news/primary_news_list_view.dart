import 'package:allthenews/src/ui/pages/news_list/primary_news/primary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/news_list/primary_news/primary_news_list_item.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const listHorizontalPadding = 13.0;
}

class PrimaryNewsListView extends StatelessWidget {
  final List<PrimaryNewsListEntity> primaryNewsListEntities;

  const PrimaryNewsListView({
    @required this.primaryNewsListEntities,
  }) : assert(primaryNewsListEntities != null);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: _Constants.listHorizontalPadding,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: primaryNewsListEntities.length,
        itemBuilder: (context, index) {
          final viewEntity = primaryNewsListEntities[index];
          return Hero(
            tag: viewEntity.title,
            child: PrimaryNewsListItem(news: viewEntity),
          );
        },
      ),
    );
  }
}
