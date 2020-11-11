import 'package:allthenews/src/domain/common/usecase/get_page_use_case.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/ui/common/pagination/pagination_notifier.dart';
import 'package:allthenews/src/ui/common/util/mapper.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/secondary_news/secondary_news_list_entity.dart';

class LatestNewsNotifier extends PaginationNotifier<Article, SecondaryNewsListEntity> {
  LatestNewsNotifier(
    GetPageUseCase<Article> getPageUseCase,
    Mapper<Article, SecondaryNewsListEntity> mapper,
  ) : super(getPageUseCase, mapper);
}
