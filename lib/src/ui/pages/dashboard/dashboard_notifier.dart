import 'dart:async';

import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_reactive_repository.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/pages/dashboard/dashboard_view_entity.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/popular_news_criterion_message_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'dashboard_view_state.dart';

class DashboardNotifier extends ChangeNotifier {
  final NYTimesReactiveRepository _nyTimesReactiveRepository;
  final SettingsRepository _settingsRepository;
  final PopularNewsCriterionMessageMapper _popularNewsCriterionMessageMapper;
  StreamSubscription? _streamSubscription;

  DashboardViewState _state = const DashboardViewState();

  DashboardViewState get state => _state;

  DashboardNotifier(
    this._nyTimesReactiveRepository,
    this._settingsRepository,
    this._popularNewsCriterionMessageMapper,
  );

  void fetchArticles() {
    _setNotifierState(const DashboardViewState(isLoading: true));
    _streamSubscription = Rx.combineLatest(
      [
        _nyTimesReactiveRepository.getNewestArticlesStream(),
        _settingsRepository.getPopularNewsCriterionStream().flatMap((criterion) =>
            _nyTimesReactiveRepository
                .getMostPopularArticlesStream()
                .map((articles) => [articles, criterion]))
      ],
      (data) => DashboardViewState(
        viewEntity: DashboardViewEntity(
          newestArticles: data[0]! as List<Article>,
          mostPopularArticles: (data[1]! as List)[0] as List<Article>,
          popularNewsTitle:
              _popularNewsCriterionMessageMapper.map((data[1]! as List)[1] as PopularNewsCriterion),
        ),
      ),
    )
        .handleError((error) => _onFetchError(error))
        .listen((loadedState) => _setNotifierState(loadedState));
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.cancel();
  }

  void _onFetchError(error) {
    if (_state.viewEntity == null) {
      _setNotifierState(DashboardViewState(error: error));
    }
  }

  void _setNotifierState(DashboardViewState dashboardViewState) {
    _state = dashboardViewState;
    notifyListeners();
  }
}
