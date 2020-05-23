import 'package:allthenews/src/data/communication/api_key_local_repository.dart';
import 'package:allthenews/src/domain/authorization/api_key_repository.dart';
import 'package:get_it/get_it.dart';

void injectDependencies() {
  final locator = GetIt.instance;
  locator.registerSingleton<ApiKeyRepository>(ApiKeyLocalRepository());
}

T inject<T>([String name]) => GetIt.instance.get<T>(instanceName: name);
