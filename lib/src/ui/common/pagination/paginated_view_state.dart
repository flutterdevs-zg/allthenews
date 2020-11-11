class PaginatedViewState<T> {
  final bool isLoading;
  final PaginatedItems<T> paginatedItems;
  final Object error;

  const PaginatedViewState({
    this.isLoading = false,
    this.paginatedItems,
    this.error,
  });
}

class PaginatedItems<T> {
  final List<PaginatedItem<T>> items;
  final bool hasMoreElements;

  const PaginatedItems({
    this.items,
    this.hasMoreElements = false,
  });

  List<PaginatedContentItem<T>> get contentItems => items.whereType<PaginatedContentItem<T>>().toList();

}

abstract class PaginatedItem<T> {}

class PaginatedContentItem<T> extends PaginatedItem<T> {
  final T item;

  PaginatedContentItem(this.item);
}

class PaginatedLoadingItem<T> extends PaginatedItem<T> {}

class PaginationErrorItem<T> extends PaginatedItem<T> {}