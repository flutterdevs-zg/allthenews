import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_repository.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/pages/home/home_notifier_state.dart';
import 'package:flutter/cupertino.dart';

class HomeNotifier extends ChangeNotifier {
  final NYTimesRepository _nyTimesRepository;
  final SettingsRepository _settingsRepository;

  HomeNotifierState _state = HomeNotifierInitialState();

  HomeNotifierState get state => _state;

  HomeNotifier(this._nyTimesRepository, this._settingsRepository);

  void fetchHomeArticles() {
    _setNotifierState(HomeNotifierLoadingState());
    Future.wait([
      _nyTimesRepository.getMostPopularArticles(),
      _nyTimesRepository.getNewestArticles(),
      _settingsRepository.getPopularNewsCriterion(),
    ]).then((values) => _onFetchSuccess(values)).catchError((error) => _onFetchError(error));
  }

  void _onFetchError(error) => _setNotifierState(HomeNotifierErrorState(error: error));

  void _onFetchSuccess(List<Object> values) {
    _setNotifierState(HomeNotifierLoadedState(
      mostPopularArticles: values[0] as List<Article>,
      newestArticles: values[1] as List<Article>,
      popularNewsCriterion: values[2] as PopularNewsCriterion,
    ));
  }

  void _setNotifierState(HomeNotifierState notifierState) {
    _state = notifierState;
    notifyListeners();
  }
}
