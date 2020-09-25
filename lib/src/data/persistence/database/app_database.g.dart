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
  final String thumbnail;
  final ArticleDtoType type;
  ArticleDto(
      {@required this.url,
      @required this.updateDateTime,
      @required this.authorName,
      @required this.title,
      @required this.abstract,
      this.thumbnail,
      @required this.type});
  factory ArticleDto.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return ArticleDto(
      url: stringType.mapFromDatabaseResponse(data['${effectivePrefix}url']),
      updateDateTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}update_date_time']),
      authorName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}author_name']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      abstract: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}abstract']),
      thumbnail: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail']),
      type: $ArticlesTable.$converter0.mapToDart(
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}type'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || updateDateTime != null) {
      map['update_date_time'] = Variable<DateTime>(updateDateTime);
    }
    if (!nullToAbsent || authorName != null) {
      map['author_name'] = Variable<String>(authorName);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || abstract != null) {
      map['abstract'] = Variable<String>(abstract);
    }
    if (!nullToAbsent || thumbnail != null) {
      map['thumbnail'] = Variable<String>(thumbnail);
    }
    if (!nullToAbsent || type != null) {
      final converter = $ArticlesTable.$converter0;
      map['type'] = Variable<String>(converter.mapToSql(type));
    }
    return map;
  }

  ArticlesCompanion toCompanion(bool nullToAbsent) {
    return ArticlesCompanion(
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      updateDateTime: updateDateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(updateDateTime),
      authorName: authorName == null && nullToAbsent
          ? const Value.absent()
          : Value(authorName),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      abstract: abstract == null && nullToAbsent
          ? const Value.absent()
          : Value(abstract),
      thumbnail: thumbnail == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnail),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
    );
  }

  factory ArticleDto.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ArticleDto(
      url: serializer.fromJson<String>(json['url']),
      updateDateTime: serializer.fromJson<DateTime>(json['updateDateTime']),
      authorName: serializer.fromJson<String>(json['authorName']),
      title: serializer.fromJson<String>(json['title']),
      abstract: serializer.fromJson<String>(json['abstract']),
      thumbnail: serializer.fromJson<String>(json['thumbnail']),
      type: serializer.fromJson<ArticleDtoType>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'url': serializer.toJson<String>(url),
      'updateDateTime': serializer.toJson<DateTime>(updateDateTime),
      'authorName': serializer.toJson<String>(authorName),
      'title': serializer.toJson<String>(title),
      'abstract': serializer.toJson<String>(abstract),
      'thumbnail': serializer.toJson<String>(thumbnail),
      'type': serializer.toJson<ArticleDtoType>(type),
    };
  }

  ArticleDto copyWith(
          {String url,
          DateTime updateDateTime,
          String authorName,
          String title,
          String abstract,
          String thumbnail,
          ArticleDtoType type}) =>
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
  bool operator ==(dynamic other) =>
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
  final Value<String> thumbnail;
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
    @required String url,
    @required DateTime updateDateTime,
    @required String authorName,
    @required String title,
    @required String abstract,
    this.thumbnail = const Value.absent(),
    @required ArticleDtoType type,
  })  : url = Value(url),
        updateDateTime = Value(updateDateTime),
        authorName = Value(authorName),
        title = Value(title),
        abstract = Value(abstract),
        type = Value(type);
  static Insertable<ArticleDto> custom({
    Expression<String> url,
    Expression<DateTime> updateDateTime,
    Expression<String> authorName,
    Expression<String> title,
    Expression<String> abstract,
    Expression<String> thumbnail,
    Expression<String> type,
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
      {Value<String> url,
      Value<DateTime> updateDateTime,
      Value<String> authorName,
      Value<String> title,
      Value<String> abstract,
      Value<String> thumbnail,
      Value<ArticleDtoType> type}) {
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
      map['thumbnail'] = Variable<String>(thumbnail.value);
    }
    if (type.present) {
      final converter = $ArticlesTable.$converter0;
      map['type'] = Variable<String>(converter.mapToSql(type.value));
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
  final String _alias;
  $ArticlesTable(this._db, [this._alias]);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  GeneratedTextColumn _url;
  @override
  GeneratedTextColumn get url => _url ??= _constructUrl();
  GeneratedTextColumn _constructUrl() {
    return GeneratedTextColumn(
      'url',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updateDateTimeMeta =
      const VerificationMeta('updateDateTime');
  GeneratedDateTimeColumn _updateDateTime;
  @override
  GeneratedDateTimeColumn get updateDateTime =>
      _updateDateTime ??= _constructUpdateDateTime();
  GeneratedDateTimeColumn _constructUpdateDateTime() {
    return GeneratedDateTimeColumn(
      'update_date_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _authorNameMeta = const VerificationMeta('authorName');
  GeneratedTextColumn _authorName;
  @override
  GeneratedTextColumn get authorName => _authorName ??= _constructAuthorName();
  GeneratedTextColumn _constructAuthorName() {
    return GeneratedTextColumn(
      'author_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _abstractMeta = const VerificationMeta('abstract');
  GeneratedTextColumn _abstract;
  @override
  GeneratedTextColumn get abstract => _abstract ??= _constructAbstract();
  GeneratedTextColumn _constructAbstract() {
    return GeneratedTextColumn(
      'abstract',
      $tableName,
      false,
    );
  }

  final VerificationMeta _thumbnailMeta = const VerificationMeta('thumbnail');
  GeneratedTextColumn _thumbnail;
  @override
  GeneratedTextColumn get thumbnail => _thumbnail ??= _constructThumbnail();
  GeneratedTextColumn _constructThumbnail() {
    return GeneratedTextColumn(
      'thumbnail',
      $tableName,
      true,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [url, updateDateTime, authorName, title, abstract, thumbnail, type];
  @override
  $ArticlesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'articles';
  @override
  final String actualTableName = 'articles';
  @override
  VerificationContext validateIntegrity(Insertable<ArticleDto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url'], _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('update_date_time')) {
      context.handle(
          _updateDateTimeMeta,
          updateDateTime.isAcceptableOrUnknown(
              data['update_date_time'], _updateDateTimeMeta));
    } else if (isInserting) {
      context.missing(_updateDateTimeMeta);
    }
    if (data.containsKey('author_name')) {
      context.handle(
          _authorNameMeta,
          authorName.isAcceptableOrUnknown(
              data['author_name'], _authorNameMeta));
    } else if (isInserting) {
      context.missing(_authorNameMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('abstract')) {
      context.handle(_abstractMeta,
          abstract.isAcceptableOrUnknown(data['abstract'], _abstractMeta));
    } else if (isInserting) {
      context.missing(_abstractMeta);
    }
    if (data.containsKey('thumbnail')) {
      context.handle(_thumbnailMeta,
          thumbnail.isAcceptableOrUnknown(data['thumbnail'], _thumbnailMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {title, type};
  @override
  ArticleDto map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ArticleDto.fromData(data, _db, prefix: effectivePrefix);
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
  $ArticlesTable _articles;
  $ArticlesTable get articles => _articles ??= $ArticlesTable(this);
  ArticleDao _articleDao;
  ArticleDao get articleDao => _articleDao ??= ArticleDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [articles];
}
