import 'package:allthenews/ui/common/util/dimens.dart';
import 'package:allthenews/ui/common/util/strings.dart';
import 'package:allthenews/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/ui/pages/news_list/primary_news/primary_news_list_entity.dart';
import 'package:allthenews/ui/pages/news_list/primary_news/primary_news_list_view.dart';
import 'package:allthenews/ui/pages/news_list/secondary_news/secondary_news_list_entity.dart';
import 'package:allthenews/ui/pages/news_list/news_list_page.dart';
import 'package:allthenews/ui/pages/news_list/secondary_news/secondary_news_list_view.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const sectionHeaderPadding = 10.0;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              height: 80,
            ),
            _buildNewsSectionHeader(
              title: Strings.mostViewed,
              routeBuilder: (context) => NewsListPage(
                headerTitle: Strings.mostViewed,
                listEntities: primaryNewsListEntities
                    .map(
                      (primaryEntity) => SecondaryNewsListEntity(
                        title: primaryEntity.title,
                        date: primaryEntity.date,
                        imageUrl: primaryEntity.imageUrl,
                        time: primaryEntity.time,
                        articleUrl: primaryEntity.articleUrl,
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(height: _Constants.sectionHeaderPadding),
            PrimaryNewsListView(
              primaryNewsListEntities: primaryNewsListEntities.take(5).toList(),
            ),
            _buildNewsSectionHeader(
              title: Strings.newest,
              routeBuilder: (context) => NewsListPage(headerTitle: Strings.newest, listEntities: secondaryNewsListEntities),
            ),
            SizedBox(height: _Constants.sectionHeaderPadding),
            SecondaryNewsListView(
              secondaryNewsListEntities: secondaryNewsListEntities.take(3).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsSectionHeader({
    @required String title,
    @required WidgetBuilder routeBuilder,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.pagePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: title,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          PrimaryTextButton(
            text: Strings.showAll,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: routeBuilder,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
