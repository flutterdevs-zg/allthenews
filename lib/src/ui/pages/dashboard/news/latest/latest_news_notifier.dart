import 'package:allthenews/src/domain/common/page.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_paginated_repository.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/articles_mapper.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/secondary_news/news_paginated_view_entity.dart';
import 'package:flutter/foundation.dart';

import 'latest_news_view_state.dart';

abstract class _Constants {
  static const pageSize = 10;
}

class LatestNewsNotifier extends ChangeNotifier {
  final NYTimesPaginatedRepository _nyTimesPaginatedRepository;

  LatestNewsViewState _state = const LatestNewsViewState();

  NewsPaginatedViewEntities get _loadedNewsPaginatedViewEntities => _state.viewEntities;

  LatestNewsNotifier(this._nyTimesPaginatedRepository);

  LatestNewsViewState get state => _state;

  void loadFirstPage() {
    _setNotifierState(const LatestNewsViewState(isLoading: true));
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
      LatestNewsViewState(
        viewEntities: NewsPaginatedViewEntities(
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
    final List<ContentNewsPaginatedViewEntity> currentArticles = _loadedNewsPaginatedViewEntities?.newsPaginatedContentViewEntities ?? [];

    _setNotifierState(
      LatestNewsViewState(
        viewEntities: NewsPaginatedViewEntities(
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
    _setNotifierState(LatestNewsViewState(error: error));
  }

  void _setNotifierState(LatestNewsViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
