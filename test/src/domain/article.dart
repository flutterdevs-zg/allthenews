import 'package:allthenews/src/domain/model/article.dart';

final testRestArticles = [
  Article(
    authorName: 'rest_author',
    thumbnail: 'rest_thumbnail',
    title: 'rest_title',
    updateDateTime: DateTime(2020, 12, 1, 15),
    url: 'rest_url',
    abstract: 'rest_abstract',
  )
];

final testCachedArticles = [
  Article(
    authorName: 'cached_author',
    thumbnail: 'cached_thumbnail',
    title: 'cached_title',
    updateDateTime: DateTime(2019, 12, 1, 15),
    url: 'cached_url',
    abstract: 'cached_abstract',
  ),
  Article(
    authorName: 'cached_author_2',
    thumbnail: 'cached_thumbnail_2',
    title: 'cached_title_2',
    updateDateTime: DateTime(2019, 12, 1, 14),
    url: 'cached_url_2',
    abstract: 'cached_abstract_2',
  ),
];