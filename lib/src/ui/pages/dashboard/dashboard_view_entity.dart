import 'package:allthenews/src/domain/model/article.dart';

class DashboardViewEntity {
  final List<Article> mostPopularArticles;
  final List<Article> newestArticles;
  final String popularNewsTitle;

  DashboardViewEntity({
    this.mostPopularArticles,
    this.newestArticles,
    this.popularNewsTitle,
  }) : super();
}
