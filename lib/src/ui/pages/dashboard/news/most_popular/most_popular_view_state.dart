import 'package:allthenews/src/ui/pages/dashboard/news/most_popular/most_popular_news_view_entity.dart';

class MostPopularViewState {
  final bool isLoading;
  final MostPopularNewsViewEntity viewEntity;
  final Object error;

  const MostPopularViewState({this.isLoading = false, this.viewEntity, this.error});
}
