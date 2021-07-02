import 'package:allthenews/src/data/persistence/cache/cache_policy.dart';
import 'package:allthenews/src/domain/model/article.dart';

class ArticleCachePolicy extends CachePolicy<Article> {
  @override
  bool isValid(Article? article) {
    final currentDateTime = DateTime.now();
    return article != null &&
        article.updateDateTime.isAfter(
          DateTime(
            currentDateTime.year,
            currentDateTime.month,
            currentDateTime.day,
            currentDateTime.hour,
          ),
        );
  }
}
