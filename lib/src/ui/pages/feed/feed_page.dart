import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/util/notifier_view_state.dart';
import 'package:allthenews/src/ui/common/util/untranslatable_strings.dart';
import 'package:allthenews/src/ui/common/widget/primary_icon_button.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/src/ui/common/widget/retry_action_container.dart';
import 'package:allthenews/src/ui/pages/feed/feed_notifier.dart';
import 'package:allthenews/src/ui/pages/feed/news/primary_news/primary_news_list_view.dart';
import 'package:allthenews/src/ui/pages/feed/news/secondary_news/secondary_news_list_item.dart';
import 'package:allthenews/src/ui/pages/home/home_page_view_entity.dart';
import 'package:allthenews/src/ui/pages/home/news/articles_mapper.dart';
import 'package:allthenews/src/ui/pages/home/news/latest/latest_news_notifier.dart';
import 'package:allthenews/src/ui/pages/home/news/latest/latest_news_page.dart';
import 'package:allthenews/src/ui/pages/home/news/most_popular/most_popular_news_notifier.dart';
import 'package:allthenews/src/ui/pages/home/news/most_popular/most_popular_news_page.dart';
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
  static const retryButtonWidth = 120.0;
  static const retryButtonHeight = 40.0;
}

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final FeedNotifier _feedNotifier = inject<FeedNotifier>();

  @override
  void initState() {
    super.initState();
    _feedNotifier.fetchArticles();
  }

  @override
  void dispose() {
    super.dispose();
    _feedNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: ChangeNotifierProvider.value(
          value: _feedNotifier,
          builder: (providerContext, child) {
            final state = providerContext.select((FeedNotifier notifier) => notifier.state);
            if (state is NotifierInitialViewState || state is NotifierLoadingViewState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NotifierErrorViewState) {
              return _errorContent(providerContext);
            } else if (state is NotifierLoadedViewState) {
              return _buildLoadedContent(
                  (state as NotifierLoadedViewState<HomePageViewEntity>).data);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Column _buildLoadedContent(HomePageViewEntity homePageViewEntity) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: _Constants.sectionHeaderPadding),
                _buildNewsSectionHeader(
                  title: homePageViewEntity.popularNewsTitle,
                  routeBuilder: (context) => ChangeNotifierProvider(
                    create: (_) => inject<MostPopularNewsNotifier>(),
                    child: MostPopularNewsListPage(),
                  ),
                ),
                const SizedBox(height: _Constants.sectionHeaderPadding),
                PrimaryNewsListView(
                  primaryNewsListEntities: homePageViewEntity.mostPopularArticles
                      .toPrimaryNewsListEntity()
                      .take(_Constants.primaryNewsListSize)
                      .toList(),
                ),
                const SizedBox(height: _Constants.sectionSpacing),
                _buildNewsSectionHeader(
                  title: Strings.of(context).newest,
                  routeBuilder: (context) => ChangeNotifierProvider(
                    create: (_) => inject<LatestNewsNotifier>(),
                    child: LatestNewsListPage(),
                  ),
                ),
                const SizedBox(height: _Constants.sectionHeaderPadding),
                _buildSecondaryNewsItems(homePageViewEntity.newestArticles),
              ],
            ),
          ),
        ),
      ],
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

  Widget _errorContent(BuildContext providerContext) => RetryActionContainer(
        onRetryPressed: () => providerContext.read<FeedNotifier>().fetchArticles(),
      );
}
