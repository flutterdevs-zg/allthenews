import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:allthenews/src/data/communication/api/api_errors.dart';
import 'package:allthenews/src/data/communication/api/api_key_local_repository.dart';
import 'package:allthenews/src/domain/authorization/api_key.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

abstract class _Constants {
  static const Duration timeoutDuration = Duration(seconds: 15);
}

class RequestFactory {
  ApiKeyLocalRepository _apiKeyLocalRepository = ApiKeyLocalRepository();
  ApiKey _apiKey;
  final String baseUrl;

  RequestFactory(this.baseUrl) {
    _getApiKey();
  }

  Future<Result<dynamic>> networkRequest(String path) async {
    final Future<http.Response> futureResponse =
        http.get(baseUrl + path + "?api-key=${_apiKey.value}");

    try {
      final response = await futureResponse.timeout(_Constants.timeoutDuration);

      switch (response.statusCode) {
        case 200:
          if (response.body.isEmpty) {
            return Result<dynamic>.error(EmptyResponseError(response.statusCode));
          } else {
            //FIXME w tasku z tworzeniem modeli danych domenowych zobaczyc jak wygladaja poszczegolne jsony
            return Result<dynamic>.value(jsonDecode(response.body)['results']);
          }
          break;
        case 400:
          return Result<dynamic>.error(BadRequestError(response.statusCode));
        case 500:
          return Result<dynamic>.error(ServerError(response.statusCode));
        default:
          return Result<dynamic>.error(UnknownError(response.statusCode));
      }
    } on TimeoutException {
      return Result<dynamic>.error(TimeoutError(HttpStatus.gatewayTimeout));
    } on SocketException {
      return Result<dynamic>.error(ConnectionError());
    } on Exception catch (error) {
      return Result<dynamic>.error(UnknownError('$error'));
    }
  }

  _getApiKey() async {
    _apiKey = await _apiKeyLocalRepository.getKey();
  }
}
