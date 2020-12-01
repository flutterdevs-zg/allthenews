import 'dart:async';

import 'package:allthenews/src/domain/common/usecase/get_page_use_case.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/common/pagination/paginated_view_state.dart';
import 'package:allthenews/src/ui/common/pagination/pagination_notifier.dart';
import 'package:allthenews/src/ui/common/util/mapper.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/popular_news_criterion_message_mapper.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/secondary_news/secondary_news_list_entity.dart';

class MostPopularNewsNotifier extends PaginationNotifier<Article, SecondaryNewsListEntity> {
  final SettingsRepository _settingsRepository;
  final PopularNewsCriterionMessageMapper _popularNewsCriterionMessageMapper;

  String _mostPopularNewsPageTitle = '';

  MostPopularPaginatedViewState<SecondaryNewsListEntity> get mostPopularViewState => MostPopularPaginatedViewState(
        super.state,
        _mostPopularNewsPageTitle,
      );

  MostPopularNewsNotifier(
    GetPageUseCase<Article> getPageUseCase,
    Mapper<Article, SecondaryNewsListEntity> mapper,
    this._settingsRepository,
    this._popularNewsCriterionMessageMapper,
  ) : super(getPageUseCase, mapper);

  @override
  Future<void> loadFirstPage() async {
    super.setNotifierState(const PaginatedViewState(isLoading: true));
    await _settingsRepository.getPopularNewsCriterion().then((criterion) {
      _mostPopularNewsPageTitle = _popularNewsCriterionMessageMapper.map(criterion);
      super.loadFirstPage();
    }).catchError((error) => setNotifierState(PaginatedViewState(error: error)));
  }
}

class MostPopularPaginatedViewState<T> {
  final PaginatedViewState<T> _baseViewState;
  final String mostPopularNewsPageTitle;

  const MostPopularPaginatedViewState(
    this._baseViewState,
    this.mostPopularNewsPageTitle,
  );

  bool get isLoading => _baseViewState.isLoading;

  PaginatedItems<T> get paginatedItems => _baseViewState.paginatedItems;

  Object get error => _baseViewState.error;
}
