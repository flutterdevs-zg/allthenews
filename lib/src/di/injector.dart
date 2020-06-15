import 'package:allthenews/src/data/appinfo/app_info_local_repository.dart';
import 'package:allthenews/src/data/communication/api_key_local_repository.dart';
import 'package:allthenews/src/data/persistence/shared_preferences_persistence_repository.dart';
import 'package:allthenews/src/data/settings/settings_local_repository.dart';
import 'package:allthenews/src/domain/appinfo/app_info_repository.dart';
import 'package:allthenews/src/domain/authorization/api_key_repository.dart';
import 'package:allthenews/src/domain/common/persistence/persistence_repository.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/common/theme/theme_notifier.dart';
import 'package:allthenews/src/ui/pages/settings/settings_notifier.dart';
import 'package:get_it/get_it.dart';

void injectDependencies() {
  final locator = GetIt.instance;
  locator.registerSingleton<ApiKeyRepository>(ApiKeyLocalRepository());
  locator.registerSingleton<AppInfoRepository>(AppInfoLocalRepository());
  locator.registerSingleton<PersistenceRepository>(SharedPreferencesPersistenceRepository());
  locator.registerSingleton<SettingsRepository>(SettingsLocalRepository(locator<PersistenceRepository>()));
  locator.registerFactory(() => ThemeNotifier(locator<SettingsRepository>()));
  locator.registerFactory(() => SettingsNotifier(locator<SettingsRepository>(), locator<AppInfoRepository>()));
}

T inject<T>([String name]) => GetIt.instance.get<T>(instanceName: name);
