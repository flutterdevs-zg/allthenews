import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/ui/common/util/date_time_extensions.dart';
import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/util/notifier_state.dart';
import 'package:allthenews/src/ui/common/util/untranslatable_strings.dart';
import 'package:allthenews/src/ui/common/widget/primary_icon_button.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/src/ui/pages/home/home_notifier.dart';
import 'package:allthenews/src/ui/pages/home/home_notifier_state.dart';
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
  static const retryButtonWidth = 120.0;
  static const retryButtonHeight = 40.0;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeNotifier _homeNotifier = inject<HomeNotifier>();

  @override
  void initState() {
    super.initState();
    _homeNotifier.fetchHomeArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: ChangeNotifierProvider.value(
          value: _homeNotifier,
          builder: (providerContext, child) {
            final notifier = providerContext.watch<HomeNotifier>();

            switch (notifier.state.notifierState) {
              case NotifierState.initial:
              case NotifierState.loading:
                return const Center(child: CircularProgressIndicator());
              case NotifierState.loaded:
                return _buildLoadedContent(notifier.state as HomeNotifierLoadedState);
              case NotifierState.error:
                return _errorContent(providerContext, notifier.state as HomeNotifierErrorState);
            }
            return _errorContent(providerContext, notifier.state as HomeNotifierErrorState);
          },
        ),
      ),
    );
  }

  Column _buildLoadedContent(HomeNotifierLoadedState state) {
    final headerTitle = getTitleForCriterion(context, state.popularNewsCriterion);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: _Constants.sectionHeaderPadding),
                _buildNewsSectionHeader(
                  title: headerTitle,
                  routeBuilder: (context) => NewsListPage(
                    headerTitle: headerTitle,
                    listEntities: state.mostPopularArticles.toSecondaryNewsListEntities(),
                  ),
                ),
                const SizedBox(height: _Constants.sectionHeaderPadding),
                PrimaryNewsListView(
                  primaryNewsListEntities: state.mostPopularArticles
                      .toPrimaryNewsListEntity()
                      .take(_Constants.primaryNewsListSize)
                      .toList(),
                ),
                const SizedBox(height: _Constants.sectionSpacing),
                _buildNewsSectionHeader(
                  title: Strings.of(context).newest,
                  routeBuilder: (context) => NewsListPage(
                    headerTitle: Strings.of(context).newest,
                    listEntities: state.newestArticles.toSecondaryNewsListEntities(),
                  ),
                ),
                const SizedBox(height: _Constants.sectionHeaderPadding),
                _buildSecondaryNewsItems(state.newestArticles),
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

  String getTitleForCriterion(BuildContext context, PopularNewsCriterion criterion) {
    switch (criterion) {
      case PopularNewsCriterion.viewed:
        return Strings.of(context).mostViewed;
      case PopularNewsCriterion.shared:
        return Strings.of(context).mostShared;
      case PopularNewsCriterion.emailed:
        return Strings.of(context).mostEmailed;
    }
    return '';
  }

  Widget _errorContent(BuildContext providerContext, HomeNotifierErrorState state) => Center(
    //TODO use state to display error returned from the notifier
        child: Container(
          height: _Constants.retryButtonHeight,
          width: _Constants.retryButtonWidth,
          child: PrimaryTextButton(
            onPressed: () => providerContext.read<HomeNotifier>().fetchHomeArticles(),
            text: Strings.of(context).retry,
          ),
        ),
      );
}

extension on List<Article> {
  List<PrimaryNewsListEntity> toPrimaryNewsListEntity() => map(
        (article) => PrimaryNewsListEntity(
          title: article.title,
          articleUrl: article.url,
          authorName: article.authorName,
          date: article.updateDateTime.formatDate(),
          imageUrl: article.thumbnail,
          time: article.updateDateTime.formatTime(),
        ),
      ).toList();

  List<SecondaryNewsListEntity> toSecondaryNewsListEntities() => map(
        (article) => SecondaryNewsListEntity(
          title: article.title,
          date: article.updateDateTime.formatDate(),
          imageUrl: article.thumbnail,
          time: article.updateDateTime.formatTime(),
          articleUrl: article.url,
        ),
      ).toList();
}
