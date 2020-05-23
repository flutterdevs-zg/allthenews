import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/widget/primary_icon_button.dart';
import 'package:allthenews/src/ui/pages/news_list/secondary_news/secondary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/news_list/secondary_news/secondary_news_list_view.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const sectionHeaderPadding = 16.0;
}

class NewsListPage extends StatelessWidget {
  final List<SecondaryNewsListEntity> listEntities;
  final String headerTitle;

  const NewsListPage({@required this.listEntities, @required this.headerTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            SizedBox(height: _Constants.sectionHeaderPadding),
            SecondaryNewsListView(
              secondaryNewsListEntities: listEntities,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) =>
      Padding(
        padding: EdgeInsets.only(
          top: Dimens.pagePadding,
          left: Dimens.pagePadding,
          right: Dimens.pagePadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: headerTitle,
              child: Text(
                headerTitle,
                style: Theme
                    .of(context)
                    .textTheme
                    .headline3,
              ),
            ),
            PrimaryIconButton(
              iconData: Icons.search,
              onPressed: () {},
            ),
          ],
        ),
      );
}
