import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/pagination/paginated_list_view.dart';
import 'package:allthenews/src/ui/common/pagination/paginated_view_state.dart';
import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/widget/primary_icon_button.dart';
import 'package:allthenews/src/ui/common/widget/retry_action_container.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/most_popular/most_popular_news_notifier.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/secondary_news/secondary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/secondary_news/secondary_news_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const sectionHeaderPadding = 16.0;
}

class MostPopularNewsListPage extends StatefulWidget {
  @override
  _MostPopularNewsListPageState createState() => _MostPopularNewsListPageState();
}

class _MostPopularNewsListPageState extends State<MostPopularNewsListPage> {
  final MostPopularNewsNotifier _mostPopularNewsNotifier = inject<MostPopularNewsNotifier>();

  @override
  void initState() {
    super.initState();
    _mostPopularNewsNotifier.loadFirstPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _mostPopularNewsNotifier,
      builder: (providerContext, child) {
        final viewState = providerContext.select((MostPopularNewsNotifier notifier) => notifier.mostPopularViewState);
        if (viewState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewState.paginatedItems != null) {
          return _buildLoadedContent(viewState.paginatedItems, viewState.mostPopularNewsPageTitle);
        } else if (viewState.error != null) {
          return _buildErrorContent(providerContext);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildLoadedContent(PaginatedItems<SecondaryNewsListEntity> paginatedItems, String title) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, title),
          const SizedBox(height: _Constants.sectionHeaderPadding),
          PaginatedListView<SecondaryNewsListEntity>(
            paginatedItems: paginatedItems,
            nextPageLoadingAction: () => _mostPopularNewsNotifier.loadNextPage(),
            onRetryPressed: () => _mostPopularNewsNotifier.retryPage(),
            itemBuilder: (item) => SecondaryNewsListItem(news: item),
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

  Widget _buildErrorContent(BuildContext context) => RetryActionContainer(
        onRetryPressed: () => _mostPopularNewsNotifier.loadFirstPage(),
      );
}
