import 'dart:async';

import 'package:allthenews/src/domain/nytimes/ny_times_reactive_repository.dart';
import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/pages/home/home_notifier_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class HomeNotifier extends ChangeNotifier {
  final NYTimesReactiveRepository _nyTimesReactiveRepository;
  final SettingsRepository _settingsRepository;
  StreamSubscription _streamSubscription;

  HomeNotifierState _state = HomeNotifierInitialState();

  HomeNotifierState get state => _state;

  HomeNotifier(this._nyTimesReactiveRepository, this._settingsRepository);

  void fetchHomeArticles() {
    _streamSubscription = Rx.combineLatest([
          _nyTimesReactiveRepository.getMostPopularArticlesStream(),
          _nyTimesReactiveRepository.getNewestArticlesStream(),
          Stream.fromFuture(_settingsRepository.getPopularNewsCriterion()),
        ], (data) => HomeNotifierLoadedState(
                mostPopularArticles: data[0] as List<Article>,
                newestArticles: data[1] as List<Article>,
                popularNewsTitle: _getTitleForCriterion(data[2] as PopularNewsCriterion),
            ))
        .handleError((error) => _onFetchError(error))
        .listen((homeNotifierLoadedState) => _setNotifierState(homeNotifierLoadedState));
  }

  void dispose() {
    _streamSubscription?.cancel();
  }

  void _onFetchError(error) {
    if (_state is! HomeNotifierLoadedState) {
      _setNotifierState(HomeNotifierErrorState(error: error));
    }
  }

  String _getTitleForCriterion(PopularNewsCriterion criterion) {
    switch (criterion) {
      case PopularNewsCriterion.viewed:
        return Strings.current.mostViewed;
      case PopularNewsCriterion.shared:
        return Strings.current.mostShared;
      case PopularNewsCriterion.emailed:
        return Strings.current.mostEmailed;
    }
    return '';
  }

  void _setNotifierState(HomeNotifierState notifierState) {
    _state = notifierState;
    notifyListeners();
  }
}
