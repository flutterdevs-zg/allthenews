import 'dart:async';

import 'package:allthenews/src/domain/common/page.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_paginated_repository.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/articles_mapper.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/popular_news_criterion_extensions.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/secondary_news/news_paginated_view_entity.dart';
import 'package:flutter/foundation.dart';

import 'most_popular_news_view_entity.dart';
import 'most_popular_view_state.dart';

abstract class _Constants {
  static const pageSize = 10;
}

class MostPopularNewsNotifier extends ChangeNotifier {
  final NYTimesPaginatedRepository _nyTimesPaginatedRepository;
  final SettingsRepository _settingsRepository;

  MostPopularViewState _state = const MostPopularViewState();

  MostPopularNewsViewEntity get _loadedMostPopularViewEntity => _state.viewEntity;

  NewsPaginatedViewEntities get _loadedNewsPaginatedViewEntities => _state.viewEntity?.newsPaginatedViewEntities;

  MostPopularNewsNotifier(this._nyTimesPaginatedRepository, this._settingsRepository);

  MostPopularViewState get state => _state;

  Future<void> loadFirstPage() async {
    _setNotifierState(const MostPopularViewState(isLoading: true));
    final Future<List<Article>> articles =
        _nyTimesPaginatedRepository.getMostPopularArticlesPage(Page(1, _Constants.pageSize)).catchError((error) => _onFetchError(error));

    final Future<String> popularNewsTitle =
        _settingsRepository.getPopularNewsCriterion().then((criterion) => criterion.getTitle()).catchError((error) => _onFetchError(error));

    _setLoadedState(await articles, await popularNewsTitle);
  }

  void loadNextPage() {
    if (_loadedNewsPaginatedViewEntities.hasMoreElements) {
      _setPageLoadingState();
      final nextPageNumber = (_loadedNewsPaginatedViewEntities.entities.length ~/ _Constants.pageSize) + 1;
      _nyTimesPaginatedRepository
          .getMostPopularArticlesPage(Page(nextPageNumber, _Constants.pageSize))
          .then((articles) => _setLoadedState(articles, _loadedMostPopularViewEntity.mostPopularNewsPageTitle))
          .catchError((error) => _onFetchError(error));
    }
  }

  void _setPageLoadingState() {
    _setNotifierState(MostPopularViewState(
      viewEntity: MostPopularNewsViewEntity(
        newsPaginatedViewEntities: NewsPaginatedViewEntities(
          entities: [..._loadedNewsPaginatedViewEntities.newsPaginatedContentViewEntities, LoadingNewsPaginatedViewEntity()],
          hasMoreElements: _loadedNewsPaginatedViewEntities.hasMoreElements,
        ),
        mostPopularNewsPageTitle: _loadedMostPopularViewEntity.mostPopularNewsPageTitle,
      ),
    ));
  }

  void _setLoadedState(List<Article> articles, String popularNewsTitle) {
    final List<ContentNewsPaginatedViewEntity> currentArticles = _loadedNewsPaginatedViewEntities?.newsPaginatedContentViewEntities ?? [];

    _setNotifierState(MostPopularViewState(
      viewEntity: MostPopularNewsViewEntity(
        newsPaginatedViewEntities: NewsPaginatedViewEntities(
          entities: [
            ...currentArticles,
            ...articles.toSecondaryNewsListEntities().map((e) => ContentNewsPaginatedViewEntity(e)),
          ],
          hasMoreElements: articles.length == _Constants.pageSize,
        ),
        mostPopularNewsPageTitle: popularNewsTitle,
      ),
    ));
  }

  void _onFetchError(Object error) {
    _setNotifierState(MostPopularViewState(error: error));
  }

  void _setNotifierState(MostPopularViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
