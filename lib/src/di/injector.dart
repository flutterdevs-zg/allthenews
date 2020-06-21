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

final locator = GetIt.instance;

abstract class _Constants {
  static const nyTimesBaseUrl = "https://api.nytimes.com/svc/";
}

void injectDependencies() {
  locator.registerSingleton<AppInfoRepository>(AppInfoLocalRepository());
  locator.registerSingleton<PersistenceRepository>(SharedPreferencesPersistenceRepository());
  locator.registerSingleton<SettingsRepository>(
      SettingsLocalRepository(locator<PersistenceRepository>()));
  locator.registerFactory(() => ThemeNotifier(locator<SettingsRepository>()));
  locator.registerFactory(
      () => SettingsNotifier(locator<SettingsRepository>(), locator<AppInfoRepository>()));
  _injectApiDependencies();
}

void _injectApiDependencies() {
  locator.registerSingleton<ApiKeyRepository>(ApiKeyLocalRepository());
  locator.registerSingleton<HttpClient>(
      HttpClient(_Constants.nyTimesBaseUrl, locator<ApiKeyRepository>()));
  locator.registerSingleton<NYTimesRepository>(NYTimesRestRepository(locator<HttpClient>()));
  locator.registerSingleton<ExceptionMapper>(ApiExceptionMapper());
}

T inject<T>({String name, dynamic param}) =>
    GetIt.instance.get<T>(instanceName: name, param1: param);
