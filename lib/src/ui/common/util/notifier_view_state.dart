abstract class NotifierViewState {}

class NotifierInitialViewState extends NotifierViewState {
  NotifierInitialViewState() : super();
}

class NotifierLoadingViewState extends NotifierViewState {
  NotifierLoadingViewState() : super();
}

class NotifierLoadedViewState<T> extends NotifierViewState {
  final T data;

  NotifierLoadedViewState({this.data}) : super();
}

class NotifierErrorViewState extends NotifierViewState {
  final Object error;

  NotifierErrorViewState({this.error}) : super();
}
