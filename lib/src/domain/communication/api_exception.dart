import 'package:allthenews/src/domain/communication/all_the_news_exception.dart';

abstract class ApiException extends AllTheNewsException {}

class UnauthorizedException extends ApiException {}

class ServerErrorException extends ApiException {}

class InvalidUrlException extends ApiException {}

class UnknownException extends ApiException {}

class ConnectionException extends ApiException {}
