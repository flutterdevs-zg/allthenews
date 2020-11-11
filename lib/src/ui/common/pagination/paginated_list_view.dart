import 'package:allthenews/src/ui/common/pagination/paginated_view_state.dart';
import 'package:allthenews/src/ui/common/widget/retry_action_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginatedListView<T> extends StatefulWidget {
  final PaginatedItems<T> paginatedItems;
  final VoidCallback nextPageLoadingAction;
  final VoidCallback onRetryPressed;
  final Widget Function(T item) itemBuilder;

  const PaginatedListView({
    this.paginatedItems,
    this.nextPageLoadingAction,
    this.onRetryPressed,
    this.itemBuilder,
  });

  @override
  _PaginatedListViewState<T> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: ListView.builder(
          itemCount: widget.paginatedItems.items.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            final paginatedViewEntity = widget.paginatedItems.items[index];
            if (paginatedViewEntity is PaginatedContentItem<T>) {
              return widget.itemBuilder(paginatedViewEntity.item);
            } else if (paginatedViewEntity is PaginatedLoadingItem) {
              return const Center(child: CircularProgressIndicator());
            } else if (paginatedViewEntity is PaginationErrorItem) {
              return RetryActionContainer(onRetryPressed: () => widget.onRetryPressed());
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification && _scrollController.position.extentAfter == 0) {
      widget.nextPageLoadingAction();
    }
    return false;
  }
}
