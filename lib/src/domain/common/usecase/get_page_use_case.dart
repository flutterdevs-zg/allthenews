
import 'package:allthenews/src/domain/common/page.dart';

abstract class GetPageUseCase<T> {

  Future<List<T>?> call(Page page);

}