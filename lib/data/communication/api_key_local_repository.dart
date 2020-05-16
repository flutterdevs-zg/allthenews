import 'dart:convert';

import 'package:allthenews/domain/authorization/api_key.dart';
import 'package:allthenews/domain/authorization/api_key_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart' show rootBundle;

abstract class _Constants {
  static const newYorkTimesApiKeySecureStorageKey = 'newYorkTimesApiKeySecureStorageKey';
  static const newYorkTimesApiKeyRawStorageKey = 'newYorkTimesApiKey';
  static const newYorkTimesApiKeyRawLocation = 'auth/secrets.json';
}

class ApiKeyLocalRepository extends ApiKeyRepository {
  final ApiKeyRepository _apiKeyRepository = _ApiKeySecureRepository();

  ApiKey _cachedKey;

  @override
  Future<ApiKey> getKey() async {
    if (_cachedKey == null) {
      _cachedKey = await _apiKeyRepository.getKey();
    }
    return _cachedKey;
  }
}

class _ApiKeySecureRepository extends ApiKeyRepository {
  final ApiKeyRepository _rawStorage = _ApiKeyRawRepository();
  final _secureStorage = new FlutterSecureStorage();

  @override
  Future<ApiKey> getKey() async {
    final secureStoredKey = await _secureStorage.read(
        key: _Constants.newYorkTimesApiKeySecureStorageKey);
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
        final Map<String, dynamic> credentialsMap = json.decode(jsonStr);
        return ApiKey(
          credentialsMap[_Constants.newYorkTimesApiKeyRawStorageKey],
        );
      },
    );
  }
}