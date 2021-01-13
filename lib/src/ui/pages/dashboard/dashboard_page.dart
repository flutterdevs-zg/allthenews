import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/util/mapper.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/src/ui/common/widget/retry_action_container.dart';
import 'package:allthenews/src/ui/pages/dashboard/dashboard_view_entity.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/latest/latest_news_page.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/most_popular/most_popular_news_page.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/primary_news/primary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/secondary_news/secondary_news_list_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard_notifier.dart';
import 'news/primary_news/primary_news_list_view.dart';
import 'news/secondary_news/secondary_news_list_item.dart';

abstract class _Constants {
  static const sectionHeaderPadding = 10.0;
  static const sectionSpacing = 20.0;
  static const primaryNewsListSize = 5;
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardNotifier _dashboardNotifier = inject<DashboardNotifier>();
  final Mapper<Article, PrimaryNewsListEntity> primaryNewsViewEntityMapper =
      inject<Mapper<Article, PrimaryNewsListEntity>>();
  final Mapper<Article, SecondaryNewsListEntity> secondaryNewsViewEntityMapper =
      inject<Mapper<Article, SecondaryNewsListEntity>>();

  @override
  void initState() {
    super.initState();
    _dashboardNotifier.fetchArticles();
  }

  @override
  void dispose() {
    super.dispose();
    _dashboardNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider.value(
        value: _dashboardNotifier,
        builder: (providerContext, child) {
          final viewState = providerContext.select((DashboardNotifier notifier) => notifier.state);
          if (viewState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewState.viewEntity != null) {
            return _buildLoadedContent(viewState.viewEntity);
          } else if (viewState.error != null) {
            return _buildErrorContent();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Column _buildLoadedContent(DashboardViewEntity homePageViewEntity) {
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
                  routeBuilder: (context) => MostPopularNewsListPage(),
                ),
                const SizedBox(height: _Constants.sectionHeaderPadding),
                PrimaryNewsListView(
                  primaryNewsListEntities: homePageViewEntity.mostPopularArticles
                      .map((item) => primaryNewsViewEntityMapper.map(item))
                      .take(_Constants.primaryNewsListSize)
                      .toList(),
                ),
                const SizedBox(height: _Constants.sectionSpacing),
                _buildNewsSectionHeader(
                  title: Strings.current.newest,
                  routeBuilder: (context) => LatestNewsListPage(),
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
            text: Strings.current.showAll,
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
            .map((item) => secondaryNewsViewEntityMapper.map(item))
            .take(3)
            .toList()
            .map((news) => SecondaryNewsListItem(news: news))
            .toList(),
      );

  Widget _buildErrorContent() => RetryActionContainer(
        onRetryPressed: () => _dashboardNotifier.fetchArticles(),
      );
}
