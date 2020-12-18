import 'package:allthenews/src/domain/common/error/all_the_news_exception.dart';

abstract class ExceptionMapper {
  AllTheNewsException toDomainException(Object error);
}
