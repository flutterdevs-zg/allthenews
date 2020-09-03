import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/common/notifier_state.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_repository.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:flutter/cupertino.dart';

class HomeNotifier extends ChangeNotifier {
  final NYTimesRepository _nyTimesRepository;
  final SettingsRepository _settingsRepository;

  HomeNotifier(this._nyTimesRepository, this._settingsRepository);

  NotifierState _notifierState = NotifierState.initial;

  NotifierState get notifierState => _notifierState;

  List<Article> _articles;

  List<Article> get articles => _articles;

  String _primaryListTitle;

  String get primaryListTitle => _primaryListTitle;

  void setNotifierState(NotifierState notifierState) {
    _notifierState = notifierState;
    notifyListeners();
  }

  void fetchHomeArticles(BuildContext context) {
    setNotifierState(NotifierState.loading);
    _nyTimesRepository.getArticles().then((articles) {
      _articles = articles;
      _getTitleForType(context);
      setNotifierState(NotifierState.loaded);
    }).catchError((error) {
      setNotifierState(NotifierState.error);
    });
  }

  void _getTitleForType(BuildContext context) async {
    _settingsRepository.getPopularNewsCriterion().then((criterion) {
      switch (criterion) {
        case PopularNewsCriterion.viewed:
          _primaryListTitle = Strings.of(context).mostViewed;
          break;
        case PopularNewsCriterion.shared:
          _primaryListTitle = Strings.of(context).mostShared;
          break;
        case PopularNewsCriterion.emailed:
          _primaryListTitle = Strings.of(context).mostEmailed;
          break;
      }
    });
  }
}
