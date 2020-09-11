import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_repository.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/common/util/notifier_state.dart';
import 'package:flutter/cupertino.dart';

class HomeNotifier extends ChangeNotifier {
  final NYTimesRepository _nyTimesRepository;
  final SettingsRepository _settingsRepository;

  NotifierState _state = NotifierState.initial;

  NotifierState get state => _state;

  HomeNotifier(this._nyTimesRepository, this._settingsRepository);

  List<Article> _mostPopularArticles;

  List<Article> get mostPopularArticles => _mostPopularArticles;

  List<Article> _newestArticles;

  List<Article> get newestArticles => _newestArticles;

  PopularNewsCriterion _popularNewsCriterion;

  PopularNewsCriterion get popularNewsCriterion => _popularNewsCriterion;

  void fetchHomeArticles() {
    _setNotifierState(NotifierState.loading);
    Future.wait([
      _nyTimesRepository.getMostPopularArticles(),
      _nyTimesRepository.getNewestArticles(),
      _settingsRepository.getPopularNewsCriterion(),
    ]).then((values) {
      _mostPopularArticles = values[0] as List<Article>;
      _newestArticles = values[1] as List<Article>;
      _popularNewsCriterion = values[2] as PopularNewsCriterion;
      _setNotifierState(NotifierState.loaded);
    }).catchError((_) {
      _setNotifierState(NotifierState.error);
    });
  }

  void _setNotifierState(NotifierState notifierState) {
    _state = notifierState;
    notifyListeners();
  }
}
