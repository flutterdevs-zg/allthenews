import 'package:moor/moor.dart';

class ArticleDtoTypeConverter extends TypeConverter<ArticleDtoType, String> {
  const ArticleDtoTypeConverter();

  @override
  ArticleDtoType mapToDart(String? fromDb) => (fromDb == null)
      ? throw Exception("Article type should not be null")
      : ArticleDtoType.values.firstWhere((element) => element.toString() == fromDb);

  @override
  String? mapToSql(ArticleDtoType? value) => value?.toString();
}

enum ArticleDtoType { newest, mostViewed, mostShared, mostEmailed }
