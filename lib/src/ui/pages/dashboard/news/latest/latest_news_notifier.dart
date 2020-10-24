import 'package:allthenews/src/domain/common/page.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_paginated_repository.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/ui/common/util/notifier_view_state.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/articles_mapper.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/secondary_news/news_paginated_view_entity.dart';
import 'package:flutter/foundation.dart';

abstract class _Constants {
  static const pageSize = 10;
}

class LatestNewsNotifier extends ChangeNotifier {
  final NYTimesPaginatedRepository _nyTimesPaginatedRepository;

  NotifierViewState _state = NotifierInitialViewState();

  NewsPaginatedViewEntities get _loadedNewsPaginatedViewEntities =>
      (_state is NotifierLoadedViewState) ? (_state as NotifierLoadedViewState<NewsPaginatedViewEntities>).data : null;

  LatestNewsNotifier(this._nyTimesPaginatedRepository);

  NotifierViewState get state => _state;

  void loadFirstPage() {
    _nyTimesPaginatedRepository
        .getNewestArticlesPage(Page(1, _Constants.pageSize))
        .then((articles) => _setLoadedState(articles))
        .catchError((error) => _onFetchError(error));
  }

  void loadNextPage() {
    if (_loadedNewsPaginatedViewEntities.hasMoreElements) {
      _setPageLoadingState();
      final nextPageNumber = (_loadedNewsPaginatedViewEntities.newsPaginatedContentViewEntities.length ~/ _Constants.pageSize) + 1;
      _nyTimesPaginatedRepository
          .getNewestArticlesPage(Page(nextPageNumber, _Constants.pageSize))
          .then((articles) => _setLoadedState(articles))
          .catchError((error) => _onFetchError(error));
    }
  }

  void _setPageLoadingState() {
    _setNotifierState(
      NotifierLoadedViewState<NewsPaginatedViewEntities>(
        data: NewsPaginatedViewEntities(
          entities: [
            ..._loadedNewsPaginatedViewEntities.newsPaginatedContentViewEntities,
            LoadingNewsPaginatedViewEntity(),
          ],
          hasMoreElements: _loadedNewsPaginatedViewEntities.hasMoreElements,
        ),
      ),
    );
  }

  void _setLoadedState(List<Article> articles) {
    final List<ContentNewsPaginatedViewEntity> currentArticles =
        (_state is NotifierLoadedViewState) ? _loadedNewsPaginatedViewEntities.newsPaginatedContentViewEntities : [];

    _setNotifierState(
      NotifierLoadedViewState<NewsPaginatedViewEntities>(
        data: NewsPaginatedViewEntities(
          entities: [
            ...currentArticles,
            ...articles.toSecondaryNewsListEntities().map((e) => ContentNewsPaginatedViewEntity(e)),
          ],
          hasMoreElements: articles.length == _Constants.pageSize,
        ),
      ),
    );
  }

  void _onFetchError(error) {
    _setNotifierState(NotifierErrorViewState(error: error));
  }

  void _setNotifierState(NotifierViewState notifierViewState) {
    _state = notifierViewState;
    notifyListeners();
  }
}
