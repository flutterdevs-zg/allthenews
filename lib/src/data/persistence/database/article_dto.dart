import 'package:moor/moor.dart';

import 'article_dto_type_converter.dart';

@DataClassName("ArticleDto")
class Articles extends Table {

  TextColumn get url => text()();

  DateTimeColumn get updateDateTime => dateTime()();

  TextColumn get authorName => text()();

  TextColumn get title => text()();

  TextColumn get abstract => text()();

  TextColumn get thumbnail => text().nullable()();

  TextColumn get type => text().map(const ArticleDtoTypeConverter())();

  @override
  Set<Column> get primaryKey => {title, type};
}
