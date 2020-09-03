import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/domain/communication/exception_mapper.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/util/untranslatable_strings.dart';
import 'package:allthenews/src/ui/common/widget/primary_icon_button.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/src/ui/pages/home/home_notifier.dart';
import 'package:allthenews/src/ui/pages/home/news/news_list_page.dart';
import 'package:allthenews/src/ui/pages/home/news/primary_news/primary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/home/news/primary_news/primary_news_list_view.dart';
import 'package:allthenews/src/ui/pages/home/news/secondary_news/secondary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/home/news/secondary_news/secondary_news_list_item.dart';
import 'package:allthenews/src/ui/pages/settings/settings_notifier.dart';
import 'package:allthenews/src/ui/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const appBarActionsVerticalPadding = 11.0;
  static const appBarActionsIconsPadding = 8.0;
  static const appBarTitleFontFamily = 'Chomsky';
  static const appBarTitleLeftPadding = 10.0;
  static const sectionHeaderPadding = 10.0;
  static const sectionSpacing = 20.0;
  static const primaryNewsListSize = 5;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ExceptionMapper _exceptionMapper = inject<ExceptionMapper>();
  final HomeNotifier _homeNotifier = inject<HomeNotifier>();

  @override
  void initState() {
    super.initState();
    _homeNotifier.fetchHomeArticles(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: ChangeNotifierProvider.value(
            value: _homeNotifier,
            builder: (context, child) {
              final List<Article> articles =
                  context.select((HomeNotifier notifier) => notifier.articles);

              return articles == null
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: _Constants.sectionHeaderPadding),
                                _buildNewsSectionHeader(
                                  title: _homeNotifier.primaryListTitle,
                                  routeBuilder: (context) => NewsListPage(
                                    headerTitle: Strings.of(context).mostViewed,
                                    listEntities: articles.toSecondaryNewsListEntities(),
                                  ),
                                ),
                                const SizedBox(height: _Constants.sectionHeaderPadding),
                                PrimaryNewsListView(
                                  primaryNewsListEntities: articles
                                      .toPrimaryNewsListEntity()
                                      .take(_Constants.primaryNewsListSize)
                                      .toList(),
                                ),
                                const SizedBox(height: _Constants.sectionSpacing),
                                _buildNewsSectionHeader(
                                  title: Strings.of(context).newest,
                                  routeBuilder: (context) => NewsListPage(
                                    headerTitle: Strings.of(context).newest,
                                    listEntities: articles.toSecondaryNewsListEntities(),
                                  ),
                                ),
                                const SizedBox(height: _Constants.sectionHeaderPadding),
                                _buildSecondaryNewsItems(articles),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
            }),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: Dimens.appBarElevation,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Padding(
        padding: const EdgeInsets.only(left: _Constants.appBarTitleLeftPadding),
        child: Text(
          UntranslatableStrings.newYorkTimes,
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(fontFamily: _Constants.appBarTitleFontFamily),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: _Constants.appBarActionsVerticalPadding,
          ),
          child: PrimaryIconButton(
            iconData: Icons.search,
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
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
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (_) => inject<SettingsNotifier>(),
                    child: SettingsPage(),
                  ),
                ),
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

  Widget _buildSecondaryNewsItems(List<Article> articles) => Column(
        children: articles
            .toSecondaryNewsListEntities()
            .take(3)
            .toList()
            .map((news) => SecondaryNewsListItem(news: news))
            .toList(),
      );
}

extension on List<Article> {
  List<PrimaryNewsListEntity> toPrimaryNewsListEntity() => map(
        (article) => PrimaryNewsListEntity(
          title: article.title,
          articleUrl: article.url,
          authorName: article.authorName,
          date: article.date,
          imageUrl: article.thumbnail,
          time: article.time,
        ),
      ).toList();

  List<SecondaryNewsListEntity> toSecondaryNewsListEntities() => map(
        (article) => SecondaryNewsListEntity(
          title: article.title,
          date: article.date,
          imageUrl: article.thumbnail,
          time: article.time,
          articleUrl: article.url,
        ),
      ).toList();
}
