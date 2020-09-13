import 'dart:convert';

import 'package:allthenews/src/domain/authorization/api_key.dart';
import 'package:allthenews/src/domain/authorization/api_key_repository.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Constants {
  static const newYorkTimesApiKeySecureStorageKey = 'newYorkTimesApiKeySecureStorageKey';
  static const newYorkTimesApiKeyRawStorageKey = 'newYorkTimesApiKey';
  static const newYorkTimesApiKeyRawLocation = 'auth/secrets.json';
}

class ApiKeyLocalRepository extends ApiKeyRepository {
  final ApiKeyRepository _apiKeyRepository = _ApiKeySecureRepository();

  ApiKey _cachedKey;

  @override
  Future<ApiKey> getKey() async => _cachedKey ??= await _apiKeyRepository.getKey();
}

class _ApiKeySecureRepository extends ApiKeyRepository {
  final ApiKeyRepository _rawStorage = _ApiKeyRawRepository();
  final _secureStorage = const FlutterSecureStorage();

  @override
  Future<ApiKey> getKey() async {
    final secureStoredKey =
        await _secureStorage.read(key: _Constants.newYorkTimesApiKeySecureStorageKey);
    if (secureStoredKey != null && secureStoredKey.isNotEmpty) {
      return ApiKey(secureStoredKey);
    } else {
      final rawStoredKey = await _rawStorage.getKey();
      await _saveKey(rawStoredKey);
      return rawStoredKey;
    }
  }

  Future<void> _saveKey(ApiKey apiKey) => _secureStorage.write(
        key: _Constants.newYorkTimesApiKeySecureStorageKey,
        value: apiKey.value,
      );
}

class _ApiKeyRawRepository extends ApiKeyRepository {
  @override
  Future<ApiKey> getKey() {
    return rootBundle.loadStructuredData<ApiKey>(
      _Constants.newYorkTimesApiKeyRawLocation,
      (jsonStr) async {
        final credentialsMap = (json.decode(jsonStr) as Map).cast<String, String>();
        return ApiKey(
          credentialsMap[_Constants.newYorkTimesApiKeyRawStorageKey],
        );
      },
    );
  }
}
