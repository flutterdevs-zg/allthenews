import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/util/untranslatable_strings.dart';
import 'package:allthenews/src/ui/common/widget/primary_icon_button.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/src/ui/pages/home/news/news_list_page.dart';
import 'package:allthenews/src/ui/pages/home/news/primary_news/primary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/home/news/primary_news/primary_news_list_view.dart';
import 'package:allthenews/src/ui/pages/home/news/secondary_news/secondary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/home/news/secondary_news/secondary_news_list_item.dart';
import 'package:allthenews/src/ui/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const appBarActionsVerticalPadding = 11.0;
  static const appBarActionsIconsPadding = 8.0;
  static const appBarTitleFontFamily = 'Chomsky';
  static const appBarTitleLeftPadding = 10.0;
  static const sectionHeaderPadding = 10.0;
  static const sectionSpacing = 20.0;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: _Constants.sectionHeaderPadding),
                    _buildNewsSectionHeader(
                      title: Strings.of(context).mostViewed,
                      routeBuilder: (context) => NewsListPage(
                        headerTitle: Strings.of(context).mostViewed,
                        listEntities: primaryNewsListEntities.toSecondaryNewsListEntities(),
                      ),
                    ),
                    SizedBox(height: _Constants.sectionHeaderPadding),
                    PrimaryNewsListView(
                      primaryNewsListEntities: primaryNewsListEntities.take(5).toList(),
                    ),
                    SizedBox(height: _Constants.sectionSpacing),
                    _buildNewsSectionHeader(
                      title: Strings.of(context).newest,
                      routeBuilder: (context) => NewsListPage(
                        headerTitle: Strings.of(context).newest,
                        listEntities: secondaryNewsListEntities,
                      ),
                    ),
                    SizedBox(height: _Constants.sectionHeaderPadding),
                    _buildSecondaryNewsItems(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: Dimens.appBarElevation,
      iconTheme: IconThemeData(color: Colors.black),
      title: Padding(
        padding: const EdgeInsets.only(left: _Constants.appBarTitleLeftPadding),
        child: Text(
          UntranslatableStrings.newYorkTimes,
          style: Theme.of(context).textTheme.headline2.copyWith(
                fontFamily: _Constants.appBarTitleFontFamily,
              ),
        ),
      ),
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: _Constants.appBarActionsVerticalPadding,
          ),
          child: PrimaryIconButton(
            iconData: Icons.search,
            onPressed: () {},
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: _Constants.appBarActionsVerticalPadding,
            bottom: _Constants.appBarActionsVerticalPadding,
            right: Dimens.pagePadding,
            left: _Constants.appBarActionsIconsPadding,
          ),
          child: PrimaryIconButton(
            iconData: Icons.settings,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNewsSectionHeader({
    @required String title,
    @required WidgetBuilder routeBuilder,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.pagePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Hero(
              tag: title,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
          PrimaryTextButton(
            text: Strings.of(context).showAll,
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

  Widget _buildSecondaryNewsItems() => Column(
        children: secondaryNewsListEntities.take(3).toList().map((news) => SecondaryNewsListItem(news: news)).toList(),
      );
}

extension on List<PrimaryNewsListEntity> {
  List<SecondaryNewsListEntity> toSecondaryNewsListEntities() => map(
        (primaryEntity) => SecondaryNewsListEntity(
          title: primaryEntity.title,
          date: primaryEntity.date,
          imageUrl: primaryEntity.imageUrl,
          time: primaryEntity.time,
          articleUrl: primaryEntity.articleUrl,
        ),
      ).toList();
}
