import 'package:allthenews/src/domain/model/article.dart';

class DashboardViewEntity {
  final List<Article> mostPopularArticles;
  final List<Article> newestArticles;
  final String popularNewsTitle;

  DashboardViewEntity({
    required this.mostPopularArticles,
    required this.newestArticles,
    required this.popularNewsTitle,
  }) : super();
}
