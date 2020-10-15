import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/ui/common/util/notifier_state.dart';

class FeedNotifierState {
  final NotifierState notifierState;

  FeedNotifierState(this.notifierState);
}

class FeedNotifierInitialState extends FeedNotifierState {
  FeedNotifierInitialState() : super(NotifierState.initial);
}

class FeedNotifierLoadingState extends FeedNotifierState {
  FeedNotifierLoadingState() : super(NotifierState.loading);
}

class FeedNotifierLoadedState extends FeedNotifierState {
  final List<Article> mostPopularArticles;
  final List<Article> newestArticles;
  final String popularNewsTitle;

  FeedNotifierLoadedState({
    this.mostPopularArticles,
    this.newestArticles,
    this.popularNewsTitle,
  }) : super(NotifierState.loaded);
}

class FeedNotifierErrorState extends FeedNotifierState {
  final Object error;

  FeedNotifierErrorState({this.error}) : super(NotifierState.error);
}
