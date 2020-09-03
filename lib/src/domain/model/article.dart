import 'package:meta/meta.dart';

class Article {
  final int id;

  final String url;

  final String date;

  final String time;

  final String authorName;

  final String title;

  final String abstract;

  final String thumbnail;

  Article({
    @required this.id,
    @required this.url,
    @required this.date,
    @required this.time,
    @required this.authorName,
    @required this.title,
    @required this.abstract,
    @required this.thumbnail,
  });
}
