import 'package:allthenews/src/domain/model/article.dart';

class HomePageViewEntity {
  final List<Article> mostPopularArticles;
  final List<Article> newestArticles;
  final String popularNewsTitle;

  HomePageViewEntity({
    this.mostPopularArticles,
    this.newestArticles,
    this.popularNewsTitle,
  }) : super();
}