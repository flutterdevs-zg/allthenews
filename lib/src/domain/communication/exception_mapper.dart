import 'package:allthenews/src/domain/communication/all_the_news_exception.dart';

abstract class ExceptionMapper {
  AllTheNewsException toDomainException(Exception exception);
}
