import 'package:allthenews/src/domain/common/page.dart';
import 'package:allthenews/src/domain/common/usecase/get_page_use_case.dart';
import 'package:allthenews/src/ui/common/pagination/paginated_view_state.dart';
import 'package:allthenews/src/ui/common/util/mapper.dart';
import 'package:flutter/foundation.dart';

abstract class _Constants {
  static const pageSize = 10;
}

abstract class PaginationNotifier<D, V> extends ChangeNotifier {
  final GetPageUseCase<D> _getPageUseCase;
  final Mapper<D, V> mapper;

  PaginatedViewState<V> _state = const PaginatedViewState();

  PaginatedItems<V> get _paginatedItems => _state.paginatedItems;

  PaginationNotifier(this._getPageUseCase, this.mapper);

  PaginatedViewState<V> get state => _state;

  void loadFirstPage() {
    setNotifierState(const PaginatedViewState(isLoading: true));
    _getPageUseCase(Page(1, _Constants.pageSize))
        .then((items) => _setLoadedState(items.cast()))
        .catchError((error) => _onFetchError(error));
  }

  void loadNextPage() {
    if (_paginatedItems.hasMoreElements) {
      _setPageLoadingState();
      final nextPageNumber = (_paginatedItems.items.length ~/ _Constants.pageSize) + 1;
      _getPageUseCase(Page(nextPageNumber, _Constants.pageSize))
          .then((items) => _setLoadedState(items.cast()))
          .catchError((error) => _onFetchError(error));
    }
  }

  void retryPage() {
    if (_paginatedItems == null) {
      loadFirstPage();
    } else {
      loadNextPage();
    }
  }

  void _setPageLoadingState() {
    setNotifierState(
      PaginatedViewState(
        paginatedItems: PaginatedItems<V>(
          items: [
            ..._paginatedItems.items,
            PaginatedLoadingItem(),
          ],
          hasMoreElements: _paginatedItems.hasMoreElements,
        ),
      ),
    );
  }

  void _setLoadedState(List<D> items) {
    final List<PaginatedItem<V>> currentItems = _paginatedItems?.contentItems ?? [];

    setNotifierState(
      PaginatedViewState(
        paginatedItems: PaginatedItems<V>(
          items: [
            ...currentItems,
            ...toViewEntities(items).map((item) => PaginatedContentItem(item)),
          ],
          hasMoreElements: items.length == _Constants.pageSize,
        ),
      ),
    );
  }

  void _onFetchError(Object error) {
    if (_paginatedItems != null) {
      setNotifierState(
        PaginatedViewState(
          paginatedItems: PaginatedItems<V>(
            items: [
              ..._paginatedItems.items,
              ...[PaginationErrorItem()],
            ],
            hasMoreElements: true,
          ),
        ),
      );
    } else {
      setNotifierState(PaginatedViewState(error: error));
    }
  }

  void setNotifierState(PaginatedViewState<V> viewState) {
    _state = viewState;
    notifyListeners();
  }

  List<V> toViewEntities(List<D> items) => items.map((item) => mapper.map(item)).toList();
}
