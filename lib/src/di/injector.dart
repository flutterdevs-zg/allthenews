import 'package:allthenews/src/app/app_config.dart';
import 'package:allthenews/src/app/app_flavors.dart';
import 'package:allthenews/src/data/appinfo/app_info_local_repository.dart';
import 'package:allthenews/src/data/article/article_cache_policy.dart';
import 'package:allthenews/src/data/article/ny_times_cached_in_db_repository.dart';
import 'package:allthenews/src/data/article/ny_times_paginated_rest_repository.dart';
import 'package:allthenews/src/data/article/ny_times_reactive_rest_repository.dart';
import 'package:allthenews/src/data/article/ny_times_rest_repository.dart';
import 'package:allthenews/src/data/communication/api/api_exception_mapper.dart';
import 'package:allthenews/src/data/communication/api/api_key_local_repository.dart';
import 'package:allthenews/src/data/communication/api/http_client.dart';
import 'package:allthenews/src/data/persistence/cache/cache_policy.dart';
import 'package:allthenews/src/data/persistence/database/app_database.dart';
import 'package:allthenews/src/data/persistence/database/article_dao.dart';
import 'package:allthenews/src/data/persistence/shared_preferences_persistence_repository.dart';
import 'package:allthenews/src/data/presentation/presentation_showing_local_repository.dart';
import 'package:allthenews/src/data/settings/settings_local_repository.dart';
import 'package:allthenews/src/domain/appinfo/app_info_repository.dart';
import 'package:allthenews/src/domain/authorization/api_key_repository.dart';
import 'package:allthenews/src/domain/common/persistence/persistence_repository.dart';
import 'package:allthenews/src/domain/common/usecase/get_page_use_case.dart';
import 'package:allthenews/src/domain/communication/exception_mapper.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/get_latest_news_page_use_case.dart';
import 'package:allthenews/src/domain/nytimes/get_most_popular_news_page_use_case.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_cached_repository.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_paginated_repository.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_reactive_repository.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_repository.dart';
import 'package:allthenews/src/domain/presentation/presentation_showing_repository.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/common/theme/theme_notifier.dart';
import 'package:allthenews/src/ui/common/util/mapper.dart';
import 'package:allthenews/src/ui/pages/dashboard/dashboard_notifier.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/articles_mapper.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/latest/latest_news_notifier.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/most_popular/most_popular_news_notifier.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/primary_news/primary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/secondary_news/secondary_news_list_entity.dart';
import 'package:allthenews/src/ui/pages/presentation/presentation_notifier.dart';
import 'package:allthenews/src/ui/pages/settings/settings_notifier.dart';
import 'package:get_it/get_it.dart';

abstract class _Constants {
  static const latestNews = 'latestNews';
  static const mostPopularNews = 'mostPopularNews';

}

final _locator = GetIt.instance;

void injectDependencies(Environment flavor) {
  _locator.registerSingleton<AppConfig>(AppConfig());
  _locator.registerSingleton<AppInfoRepository>(AppInfoLocalRepository());
  _locator.registerSingleton<PersistenceRepository>(SharedPreferencesPersistenceRepository());
  _locator.registerSingleton<SettingsRepository>(SettingsLocalRepository(_locator<PersistenceRepository>()));
  _locator.registerSingleton<PresentationShowingRepository>(PresentationShowingLocalRepository(_locator<PersistenceRepository>()));
  _locator.registerFactory<CachePolicy<Article>>(() => ArticleCachePolicy());
  _injectApiDependencies();
  _injectNotifiers();
}

void _injectApiDependencies() {
  _locator.registerSingleton<ApiKeyRepository>(ApiKeyLocalRepository());
  _locator.registerSingleton<HttpClient>(HttpClient(_locator<AppConfig>(), _locator<ApiKeyRepository>()));
  _locator.registerSingleton<NYTimesRepository>(NYTimesRestRepository(_locator<HttpClient>(), _locator<SettingsRepository>()));
  _locator.registerSingleton<AppDatabase>(AppDatabase());
  _locator.registerSingleton<ArticleDao>(ArticleDao(_locator<AppDatabase>()));
  _locator.registerSingleton<NyTimesCachedRepository>(NyTimesCachedInDbRepository(_locator<ArticleDao>()));
  _locator.registerSingleton<NYTimesPaginatedRepository>(NyTimesPaginatedRestRepository(
    _locator<NYTimesRepository>(),
    _locator<NyTimesCachedRepository>(),
    _locator<SettingsRepository>(),
  ));
  _locator.registerSingleton<NYTimesReactiveRepository>(NyTimesReactiveRestRepository(
    _locator<NYTimesRepository>(),
    _locator<NyTimesCachedRepository>(),
    _locator<CachePolicy<Article>>(),
    _locator<SettingsRepository>(),
  ));
  _locator.registerSingleton<ExceptionMapper>(ApiExceptionMapper());
  _locator.registerFactory<Mapper<Article, SecondaryNewsListEntity>>(() => SecondaryNewsViewEntityMapper());
  _locator.registerFactory<Mapper<Article, PrimaryNewsListEntity>>(() => PrimaryNewsViewEntityMapper());
  _locator.registerSingleton<GetPageUseCase<Article>>(
      GetLatestNewsPageUseCase(_locator<NYTimesPaginatedRepository>()),
      instanceName: _Constants.latestNews,
  );
  _locator.registerSingleton<GetPageUseCase<Article>>(
      GetMostPopularNewsPageUseCase(_locator<NYTimesPaginatedRepository>()),
      instanceName: _Constants.mostPopularNews,
  );
}

void _injectNotifiers() {
  _locator.registerFactory(() => ThemeNotifier(_locator<SettingsRepository>()));
  _locator.registerFactory(() => SettingsNotifier(_locator<SettingsRepository>(), _locator<AppInfoRepository>()));
  _locator.registerFactory(() => PresentationNotifier(_locator<PresentationShowingRepository>()));
  _locator.registerFactory(() => DashboardNotifier(
        _locator<NYTimesReactiveRepository>(),
        _locator<SettingsRepository>(),
      ));
  _locator.registerFactory(() => MostPopularNewsNotifier(
      _locator<GetPageUseCase<Article>>(instanceName: _Constants.mostPopularNews),
      _locator<Mapper<Article, SecondaryNewsListEntity>>(),
      _locator<SettingsRepository>())
  );
  _locator.registerFactory(() => LatestNewsNotifier(
      _locator<GetPageUseCase<Article>>(instanceName: _Constants.latestNews),
      _locator<Mapper<Article, SecondaryNewsListEntity>>())
  );
}

T inject<T>({String name, dynamic param}) => GetIt.instance.get<T>(instanceName: name, param1: param);
