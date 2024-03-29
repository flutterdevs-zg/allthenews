// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ArticleDto extends DataClass implements Insertable<ArticleDto> {
  final String url;
  final DateTime updateDateTime;
  final String authorName;
  final String title;
  final String abstract;
  final String? thumbnail;
  final ArticleDtoType type;
  ArticleDto(
      {required this.url,
      required this.updateDateTime,
      required this.authorName,
      required this.title,
      required this.abstract,
      this.thumbnail,
      required this.type});
  factory ArticleDto.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ArticleDto(
      url: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}url'])!,
      updateDateTime: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}update_date_time'])!,
      authorName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}author_name'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      abstract: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}abstract'])!,
      thumbnail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail']),
      type: $ArticlesTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['url'] = Variable<String>(url);
    map['update_date_time'] = Variable<DateTime>(updateDateTime);
    map['author_name'] = Variable<String>(authorName);
    map['title'] = Variable<String>(title);
    map['abstract'] = Variable<String>(abstract);
    if (!nullToAbsent || thumbnail != null) {
      map['thumbnail'] = Variable<String?>(thumbnail);
    }
    {
      final converter = $ArticlesTable.$converter0;
      map['type'] = Variable<String>(converter.mapToSql(type)!);
    }
    return map;
  }

  ArticlesCompanion toCompanion(bool nullToAbsent) {
    return ArticlesCompanion(
      url: Value(url),
      updateDateTime: Value(updateDateTime),
      authorName: Value(authorName),
      title: Value(title),
      abstract: Value(abstract),
      thumbnail: thumbnail == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnail),
      type: Value(type),
    );
  }

  factory ArticleDto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ArticleDto(
      url: serializer.fromJson<String>(json['url']),
      updateDateTime: serializer.fromJson<DateTime>(json['updateDateTime']),
      authorName: serializer.fromJson<String>(json['authorName']),
      title: serializer.fromJson<String>(json['title']),
      abstract: serializer.fromJson<String>(json['abstract']),
      thumbnail: serializer.fromJson<String?>(json['thumbnail']),
      type: serializer.fromJson<ArticleDtoType>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'url': serializer.toJson<String>(url),
      'updateDateTime': serializer.toJson<DateTime>(updateDateTime),
      'authorName': serializer.toJson<String>(authorName),
      'title': serializer.toJson<String>(title),
      'abstract': serializer.toJson<String>(abstract),
      'thumbnail': serializer.toJson<String?>(thumbnail),
      'type': serializer.toJson<ArticleDtoType>(type),
    };
  }

  ArticleDto copyWith(
          {String? url,
          DateTime? updateDateTime,
          String? authorName,
          String? title,
          String? abstract,
          String? thumbnail,
          ArticleDtoType? type}) =>
      ArticleDto(
        url: url ?? this.url,
        updateDateTime: updateDateTime ?? this.updateDateTime,
        authorName: authorName ?? this.authorName,
        title: title ?? this.title,
        abstract: abstract ?? this.abstract,
        thumbnail: thumbnail ?? this.thumbnail,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('ArticleDto(')
          ..write('url: $url, ')
          ..write('updateDateTime: $updateDateTime, ')
          ..write('authorName: $authorName, ')
          ..write('title: $title, ')
          ..write('abstract: $abstract, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      url.hashCode,
      $mrjc(
          updateDateTime.hashCode,
          $mrjc(
              authorName.hashCode,
              $mrjc(
                  title.hashCode,
                  $mrjc(abstract.hashCode,
                      $mrjc(thumbnail.hashCode, type.hashCode)))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArticleDto &&
          other.url == this.url &&
          other.updateDateTime == this.updateDateTime &&
          other.authorName == this.authorName &&
          other.title == this.title &&
          other.abstract == this.abstract &&
          other.thumbnail == this.thumbnail &&
          other.type == this.type);
}

class ArticlesCompanion extends UpdateCompanion<ArticleDto> {
  final Value<String> url;
  final Value<DateTime> updateDateTime;
  final Value<String> authorName;
  final Value<String> title;
  final Value<String> abstract;
  final Value<String?> thumbnail;
  final Value<ArticleDtoType> type;
  const ArticlesCompanion({
    this.url = const Value.absent(),
    this.updateDateTime = const Value.absent(),
    this.authorName = const Value.absent(),
    this.title = const Value.absent(),
    this.abstract = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.type = const Value.absent(),
  });
  ArticlesCompanion.insert({
    required String url,
    required DateTime updateDateTime,
    required String authorName,
    required String title,
    required String abstract,
    this.thumbnail = const Value.absent(),
    required ArticleDtoType type,
  })  : url = Value(url),
        updateDateTime = Value(updateDateTime),
        authorName = Value(authorName),
        title = Value(title),
        abstract = Value(abstract),
        type = Value(type);
  static Insertable<ArticleDto> custom({
    Expression<String>? url,
    Expression<DateTime>? updateDateTime,
    Expression<String>? authorName,
    Expression<String>? title,
    Expression<String>? abstract,
    Expression<String?>? thumbnail,
    Expression<ArticleDtoType>? type,
  }) {
    return RawValuesInsertable({
      if (url != null) 'url': url,
      if (updateDateTime != null) 'update_date_time': updateDateTime,
      if (authorName != null) 'author_name': authorName,
      if (title != null) 'title': title,
      if (abstract != null) 'abstract': abstract,
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (type != null) 'type': type,
    });
  }

  ArticlesCompanion copyWith(
      {Value<String>? url,
      Value<DateTime>? updateDateTime,
      Value<String>? authorName,
      Value<String>? title,
      Value<String>? abstract,
      Value<String?>? thumbnail,
      Value<ArticleDtoType>? type}) {
    return ArticlesCompanion(
      url: url ?? this.url,
      updateDateTime: updateDateTime ?? this.updateDateTime,
      authorName: authorName ?? this.authorName,
      title: title ?? this.title,
      abstract: abstract ?? this.abstract,
      thumbnail: thumbnail ?? this.thumbnail,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (updateDateTime.present) {
      map['update_date_time'] = Variable<DateTime>(updateDateTime.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (abstract.present) {
      map['abstract'] = Variable<String>(abstract.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<String?>(thumbnail.value);
    }
    if (type.present) {
      final converter = $ArticlesTable.$converter0;
      map['type'] = Variable<String>(converter.mapToSql(type.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesCompanion(')
          ..write('url: $url, ')
          ..write('updateDateTime: $updateDateTime, ')
          ..write('authorName: $authorName, ')
          ..write('title: $title, ')
          ..write('abstract: $abstract, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $ArticlesTable extends Articles
    with TableInfo<$ArticlesTable, ArticleDto> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ArticlesTable(this._db, [this._alias]);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  late final GeneratedColumn<String?> url = GeneratedColumn<String?>(
      'url', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _updateDateTimeMeta =
      const VerificationMeta('updateDateTime');
  late final GeneratedColumn<DateTime?> updateDateTime =
      GeneratedColumn<DateTime?>('update_date_time', aliasedName, false,
          typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _authorNameMeta = const VerificationMeta('authorName');
  late final GeneratedColumn<String?> authorName = GeneratedColumn<String?>(
      'author_name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _abstractMeta = const VerificationMeta('abstract');
  late final GeneratedColumn<String?> abstract = GeneratedColumn<String?>(
      'abstract', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _thumbnailMeta = const VerificationMeta('thumbnail');
  late final GeneratedColumn<String?> thumbnail = GeneratedColumn<String?>(
      'thumbnail', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumnWithTypeConverter<ArticleDtoType, String?> type =
      GeneratedColumn<String?>('type', aliasedName, false,
              typeName: 'TEXT', requiredDuringInsert: true)
          .withConverter<ArticleDtoType>($ArticlesTable.$converter0);
  @override
  List<GeneratedColumn> get $columns =>
      [url, updateDateTime, authorName, title, abstract, thumbnail, type];
  @override
  String get aliasedName => _alias ?? 'articles';
  @override
  String get actualTableName => 'articles';
  @override
  VerificationContext validateIntegrity(Insertable<ArticleDto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('update_date_time')) {
      context.handle(
          _updateDateTimeMeta,
          updateDateTime.isAcceptableOrUnknown(
              data['update_date_time']!, _updateDateTimeMeta));
    } else if (isInserting) {
      context.missing(_updateDateTimeMeta);
    }
    if (data.containsKey('author_name')) {
      context.handle(
          _authorNameMeta,
          authorName.isAcceptableOrUnknown(
              data['author_name']!, _authorNameMeta));
    } else if (isInserting) {
      context.missing(_authorNameMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('abstract')) {
      context.handle(_abstractMeta,
          abstract.isAcceptableOrUnknown(data['abstract']!, _abstractMeta));
    } else if (isInserting) {
      context.missing(_abstractMeta);
    }
    if (data.containsKey('thumbnail')) {
      context.handle(_thumbnailMeta,
          thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {title, type};
  @override
  ArticleDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ArticleDto.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ArticlesTable createAlias(String alias) {
    return $ArticlesTable(_db, alias);
  }

  static TypeConverter<ArticleDtoType, String> $converter0 =
      const ArticleDtoTypeConverter();
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ArticlesTable articles = $ArticlesTable(this);
  late final ArticleDao articleDao = ArticleDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [articles];
}
