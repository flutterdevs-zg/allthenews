import 'dart:io';

import 'package:allthenews/src/data/persistence/database/article_dto_type_converter.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'article_dao.dart';
import 'article_dto.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() => LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(path.join(dbFolder.path, 'db.sqlite'));
      return VmDatabase(file);
    });

@UseMoor(
  tables: [Articles],
  daos: [ArticleDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
