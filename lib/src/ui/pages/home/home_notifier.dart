import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_repository.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:flutter/cupertino.dart';

class HomeNotifier extends ChangeNotifier {
  final NYTimesRepository _nyTimesRepository;
  final SettingsRepository _settingsRepository;

  HomeNotifier(this._nyTimesRepository, this._settingsRepository);

  List<Article> _mostPopularArticles;

  List<Article> get mostPopularArticles => _mostPopularArticles;

  List<Article> _newestArticles;

  List<Article> get newestArticles => _newestArticles;

  PopularNewsCriterion _popularNewsCriterion;

  PopularNewsCriterion get popularNewsCriterion => _popularNewsCriterion;

  void fetchHomeArticles(BuildContext context) {
    Future.wait(
            [_nyTimesRepository.getMostPopularArticles(), _nyTimesRepository.getNewestArticles()])
        .then((articles) async {
      _mostPopularArticles = articles[0];
      _newestArticles = articles[1];
      _popularNewsCriterion = await _settingsRepository.getPopularNewsCriterion();
      notifyListeners();
    });
  }
}
