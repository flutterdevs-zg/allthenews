import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/util/notifier_view_state.dart';
import 'package:allthenews/src/ui/common/widget/retry_action_container.dart';
import 'package:allthenews/src/ui/common/widget/primary_icon_button.dart';
import 'package:allthenews/src/ui/pages/feed/news/secondary_news/secondary_news_list_item.dart';
import 'package:allthenews/src/ui/pages/home/news/most_popular/most_popular_news_notifier.dart';
import 'package:allthenews/src/ui/pages/home/news/secondary_news/news_paginated_view_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'most_popular_news_view_entity.dart';

abstract class _Constants {
  static const sectionHeaderPadding = 16.0;
}

class MostPopularNewsListPage extends StatefulWidget {
  @override
  _MostPopularNewsListPageState createState() => _MostPopularNewsListPageState();
}

class _MostPopularNewsListPageState extends State<MostPopularNewsListPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MostPopularNewsNotifier>().loadFirstPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final state = context.select((MostPopularNewsNotifier notifier) => notifier.state);
    if (state is NotifierLoadingViewState || state is NotifierInitialViewState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is NotifierErrorViewState) {
      return _buildErrorContent(context);
    } else if (state is NotifierLoadedViewState) {
      return _buildLoadedContent((state as NotifierLoadedViewState<MostPopularNewsViewEntity>).data);
    } else {
      return Container();
    }
  }

  Widget _buildLoadedContent(MostPopularNewsViewEntity mostPopularNewsViewEntity) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, mostPopularNewsViewEntity.mostPopularNewsPageTitle),
          const SizedBox(height: _Constants.sectionHeaderPadding),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: ListView.builder(
                itemCount: mostPopularNewsViewEntity.entities.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  final paginatedViewEntity = mostPopularNewsViewEntity.entities[index];
                  if (paginatedViewEntity is ContentNewsPaginatedViewEntity) {
                    return SecondaryNewsListItem(news: paginatedViewEntity.value);
                  } else if (paginatedViewEntity is LoadingNewsPaginatedViewEntity) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      );

  Widget _buildHeader(BuildContext context, String title) => Padding(
        padding: const EdgeInsets.only(
          top: Dimens.pagePadding,
          left: Dimens.pagePadding,
          right: Dimens.pagePadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: title,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            PrimaryIconButton(
              iconData: Icons.search,
              onPressed: () {},
            ),
          ],
        ),
      );

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification && _scrollController.position.extentAfter == 0) {
      context.read<MostPopularNewsNotifier>().loadNextPage();
    }
    return false;
  }

  Widget _buildErrorContent(BuildContext context) => RetryActionContainer(
        onRetryPressed: () => context.read<MostPopularNewsNotifier>().loadFirstPage(),
      );
}
