import 'dart:async';
import 'dart:io';
import 'package:allthenews/src/data/communication/api/api_errors.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;


abstract class _Constants {
  static const Duration timeoutDuration = Duration(seconds: 15);
}

ciag dalszy api, tak zeby mozna bylo wyslac pojedynczy request
pytania: do czego utf8 encode
jak pobrac nestowane obiekty bez potrzeby tworzenia osobnych encji? czy tak sie da?
pisanie artykulu
class RequestFactory {
  final String baseUrl;

  RequestFactory(this.baseUrl);

  Future<Result<dynamic>> networkRequest(String path) async {
    final Future<http.Response> futureResponse = http.get(baseUrl + path);


    try {
      final response = await futureResponse.timeout(_Constants.timeoutDuration);

      switch (response.statusCode) {
        case 200:
          if (response.body.isEmpty) {
            return Result<dynamic>.error(EmptyResponseError(response.statusCode));
          } else {
            return Result<dynamic>.value(response.body);
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
}
