import 'package:allthenews/src/domain/common/error/all_the_news_exception.dart';

abstract class LocationException extends AllTheNewsException {}

class PermissionDeniedForeverException extends LocationException {}

class PermissionDeniedException extends LocationException {}

class LocationServiceDisabledException extends LocationException {}