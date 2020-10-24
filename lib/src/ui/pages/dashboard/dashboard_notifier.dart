import 'dart:async';

import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_reactive_repository.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/common/util/notifier_view_state.dart';
import 'package:allthenews/src/ui/pages/dashboard/dashboard_view_entity.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/popular_news_criterion_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class DashboardNotifier extends ChangeNotifier {
  final NYTimesReactiveRepository _nyTimesReactiveRepository;
  final SettingsRepository _settingsRepository;
  StreamSubscription _streamSubscription;

  NotifierViewState _state = NotifierInitialViewState();

  NotifierViewState get state => _state;

  DashboardNotifier(this._nyTimesReactiveRepository, this._settingsRepository);

  void fetchArticles() {
    _streamSubscription = Rx.combineLatest(
            [
          _nyTimesReactiveRepository.getMostPopularArticlesStream(),
          _nyTimesReactiveRepository.getNewestArticlesStream(),
          Stream.fromFuture(_settingsRepository.getPopularNewsCriterion()),
        ],
            (data) => NotifierLoadedViewState<DashboardViewEntity>(
                  data: DashboardViewEntity(
                    mostPopularArticles: data[0] as List<Article>,
                    newestArticles: data[1] as List<Article>,
                    popularNewsTitle: (data[2] as PopularNewsCriterion).getTitle(),
                  ),
                ))
        .handleError((error) => _onFetchError(error))
        .listen((loadedState) => _setNotifierState(loadedState));
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.cancel();
  }

  void _onFetchError(error) {
    if (_state is! NotifierLoadedViewState) {
      _setNotifierState(NotifierErrorViewState(error: error));
    }
  }

  void _setNotifierState(NotifierViewState notifierState) {
    _state = notifierState;
    notifyListeners();
  }
}
