import 'package:allthenews/src/ui/pages/dashboard/news/primary_news/primary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/primary_news/primary_news_list_item.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const listHorizontalPadding = 13.0;
  static const listHeight = 240.0;
}

class PrimaryNewsListView extends StatelessWidget {
  final List<PrimaryNewsListEntity> primaryNewsListEntities;

  const PrimaryNewsListView({
    required this.primaryNewsListEntities,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _Constants.listHeight,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
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
