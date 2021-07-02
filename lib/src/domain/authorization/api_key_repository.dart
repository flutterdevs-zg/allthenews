import 'api_key.dart';

abstract class ApiKeyRepository {
  Future<ApiKey?> getKey();
}
