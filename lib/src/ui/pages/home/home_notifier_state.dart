import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/ui/common/util/notifier_state.dart';

class HomeNotifierState {
  final NotifierState notifierState;

  HomeNotifierState(this.notifierState);
}

class HomeNotifierInitialState extends HomeNotifierState {
  HomeNotifierInitialState() : super(NotifierState.initial);
}

class HomeNotifierLoadingState extends HomeNotifierState {
  HomeNotifierLoadingState() : super(NotifierState.loading);
}

class HomeNotifierLoadedState extends HomeNotifierState {
  final List<Article> mostPopularArticles;
  final List<Article> newestArticles;
  final PopularNewsCriterion popularNewsCriterion;

  HomeNotifierLoadedState({
    this.mostPopularArticles,
    this.newestArticles,
    this.popularNewsCriterion,
  }) : super(NotifierState.loaded);
}

class HomeNotifierErrorState extends HomeNotifierState {
  final Object error;

  HomeNotifierErrorState({this.error}) : super(NotifierState.error);
}
