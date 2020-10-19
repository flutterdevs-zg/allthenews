import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/util/notifier_view_state.dart';
import 'package:allthenews/src/ui/common/widget/retry_action_container.dart';
import 'package:allthenews/src/ui/common/widget/primary_icon_button.dart';
import 'package:allthenews/src/ui/pages/feed/news/secondary_news/secondary_news_list_item.dart';
import 'package:allthenews/src/ui/pages/home/news/latest/latest_news_notifier.dart';
import 'package:allthenews/src/ui/pages/home/news/secondary_news/news_paginated_view_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const sectionHeaderPadding = 16.0;
}

class LatestNewsListPage extends StatefulWidget {
  @override
  _LatestNewsListPageState createState() => _LatestNewsListPageState();
}

class _LatestNewsListPageState extends State<LatestNewsListPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<LatestNewsNotifier>().loadFirstPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final state = context.select((LatestNewsNotifier notifier) => notifier.state);
    if (state is NotifierLoadingViewState || state is NotifierInitialViewState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is NotifierErrorViewState) {
      return _buildErrorContent(context);
    } else if (state is NotifierLoadedViewState) {
      return _buildLoadedContent((state as NotifierLoadedViewState<NewsPaginatedViewEntities>).data);
    } else {
      return Container();
    }
  }

  Widget _buildLoadedContent(NewsPaginatedViewEntities paginatedViewEntities) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: _Constants.sectionHeaderPadding),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: ListView.builder(
                itemCount: paginatedViewEntities.entities.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  final paginatedViewEntity = paginatedViewEntities.entities[index];
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

  Widget _buildHeader(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: Dimens.pagePadding,
          left: Dimens.pagePadding,
          right: Dimens.pagePadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: Strings.current.newest,
              child: Text(
                Strings.current.newest,
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
      context.read<LatestNewsNotifier>().loadNextPage();
    }
    return false;
  }

  Widget _buildErrorContent(BuildContext context) => RetryActionContainer(
        onRetryPressed: () => context.read<LatestNewsNotifier>().loadFirstPage(),
      );
}
