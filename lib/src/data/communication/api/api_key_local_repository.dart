import 'dart:convert';

import 'package:allthenews/src/domain/authorization/api_key.dart';
import 'package:allthenews/src/domain/authorization/api_key_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

abstract class _Constants {
  static const newYorkTimesApiKeyFileStorageKey = 'newYorkTimesApiKey';
  static const newYorkTimesApiKeyFileLocation = 'auth/secrets.json';
}

class ApiKeyLocalRepository extends ApiKeyRepository {
  final ApiKeyRepository _apiKeyRepository = _ApiKeyCompositeRepository();

  ApiKey _cachedKey;

  @override
  Future<ApiKey> getKey() async => _cachedKey ??= await _apiKeyRepository.getKey();
}

class _ApiKeyCompositeRepository extends ApiKeyRepository {
  final ApiKeyRepository _apiKeyFileRepository = _ApiKeyFileRepository();
  final ApiKeyRepository _apiKeyEnvironmentalVariableRepository =
      _ApiKeyEnvironmentalVariableRepository();

  @override
  Future<ApiKey> getKey() async =>
      await _apiKeyEnvironmentalVariableRepository.getKey() ?? await _apiKeyFileRepository.getKey();
}

class _ApiKeyEnvironmentalVariableRepository extends ApiKeyRepository {
  static const _apiKey = String.fromEnvironment(
    'nyTimesApiKey',
    defaultValue: null,
  );

  @override
  Future<ApiKey> getKey() => _apiKey == null ? Future.value() : Future.value(ApiKey(_apiKey));
}

class _ApiKeyFileRepository extends ApiKeyRepository {
  @override
  Future<ApiKey> getKey() {
    return rootBundle.loadStructuredData<ApiKey>(
      _Constants.newYorkTimesApiKeyFileLocation,
      (jsonStr) async {
        final credentialsMap = (json.decode(jsonStr) as Map).cast<String, String>();
        return ApiKey(
          credentialsMap[_Constants.newYorkTimesApiKeyFileStorageKey],
        );
      },
    );
  }
}
