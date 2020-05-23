import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/util/mappers.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/src/ui/pages/home/news/news_list_page.dart';
import 'package:allthenews/src/ui/pages/home/news/primary_news/primary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/home/news/primary_news/primary_news_list_view.dart';
import 'package:allthenews/src/ui/pages/home/news/secondary_news/secondary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/home/news/secondary_news/secondary_news_list_view.dart';
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
              title: Strings.of(context).mostViewed,
              routeBuilder: (context) => NewsListPage(
                headerTitle: Strings.of(context).mostViewed,
                listEntities: primaryNewsListEntities.mapToSecondaryListItem(),
              ),
            ),
            SizedBox(height: _Constants.sectionHeaderPadding),
            PrimaryNewsListView(
              primaryNewsListEntities: primaryNewsListEntities.take(5).toList(),
            ),
            _buildNewsSectionHeader(
              title: Strings
                  .of(context)
                  .newest,
              routeBuilder: (context) =>
                  NewsListPage(
                    headerTitle: Strings
                        .of(context)
                        .newest,
                    listEntities: secondaryNewsListEntities,
                  ),
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
            text: Strings
                .of(context)
                .showAll,
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
