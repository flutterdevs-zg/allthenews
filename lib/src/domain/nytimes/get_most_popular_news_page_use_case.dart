import 'package:allthenews/src/domain/common/page.dart';
import 'package:allthenews/src/domain/common/usecase/get_page_use_case.dart';
import 'package:allthenews/src/domain/model/article.dart';

import 'ny_times_paginated_repository.dart';

class GetMostPopularNewsPageUseCase extends GetPageUseCase<Article> {

  final NYTimesPaginatedRepository _nyTimesPaginatedRepository;

  GetMostPopularNewsPageUseCase(this._nyTimesPaginatedRepository);

  @override
  Future<List<Article>> call(Page page) => _nyTimesPaginatedRepository.getMostPopularArticlesPage(page);
}