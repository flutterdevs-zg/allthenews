import 'package:allthenews/src/data/appinfo/app_info_local_repository.dart';
import 'package:allthenews/src/data/communication/api/api_exception_mapper.dart';
import 'package:allthenews/src/data/communication/api/api_key_local_repository.dart';
import 'package:allthenews/src/data/communication/api/http_client.dart';
import 'package:allthenews/src/data/communication/api/ny_times_rest_repository.dart';
import 'package:allthenews/src/data/persistence/shared_preferences_persistence_repository.dart';
import 'package:allthenews/src/data/settings/settings_local_repository.dart';
import 'package:allthenews/src/domain/appinfo/app_info_repository.dart';
import 'package:allthenews/src/domain/authorization/api_key_repository.dart';
import 'package:allthenews/src/domain/common/persistence/persistence_repository.dart';
import 'package:allthenews/src/domain/communication/exception_mapper.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_repository.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/common/theme/theme_notifier.dart';
import 'package:allthenews/src/ui/pages/settings/settings_notifier.dart';
import 'package:get_it/get_it.dart';

final _locator = GetIt.instance;

abstract class _Constants {
  static const nyTimesBaseUrl = "https://api.nytimes.com/svc/";
}

void injectDependencies() {
  _locator.registerSingleton<AppInfoRepository>(AppInfoLocalRepository());
  _locator.registerSingleton<PersistenceRepository>(SharedPreferencesPersistenceRepository());
  _locator.registerSingleton<SettingsRepository>(
      SettingsLocalRepository(_locator<PersistenceRepository>()));
  _locator.registerFactory(() => ThemeNotifier(_locator<SettingsRepository>()));
  _locator.registerFactory(
      () => SettingsNotifier(_locator<SettingsRepository>(), _locator<AppInfoRepository>()));
  _injectApiDependencies();
}

void _injectApiDependencies() {
  _locator.registerSingleton<ApiKeyRepository>(ApiKeyLocalRepository());
  _locator.registerSingleton<HttpClient>(
      HttpClient(_Constants.nyTimesBaseUrl, _locator<ApiKeyRepository>()));
  _locator.registerSingleton<NYTimesRepository>(NYTimesRestRepository(_locator<HttpClient>()));
  _locator.registerSingleton<ExceptionMapper>(ApiExceptionMapper());
}

T inject<T>({String name, dynamic param}) =>
    GetIt.instance.get<T>(instanceName: name, param1: param);
