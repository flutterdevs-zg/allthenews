import 'package:allthenews/src/data/communication/api/http_client.dart';
import 'package:allthenews/src/data/communication/api/request.dart';
import 'package:allthenews/src/data/response/most_popular_article_response.dart';
import 'package:allthenews/src/data/response/newest_article_response.dart';
import 'package:allthenews/src/data/response/ny_times_response.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:allthenews/src/domain/nytimes/ny_times_repository.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';

abstract class _Urls {
  static const mostPopular = "mostpopular/v2/";
  static const responseDataExtension = ".json";
  static const newest = "news/v3/content/all/all";
}

abstract class _Constants {
  static const mostPopularFromPeriodInDays = 7;
}

class NYTimesRestRepository extends NYTimesRepository {
  final HttpClient _httpClient;
  final SettingsRepository _settingsRepository;

  NYTimesRestRepository(this._httpClient, this._settingsRepository);

  @override
  Future<List<Article>> getMostPopularArticles() async {
    final popularNewsCriterion = await _settingsRepository.getPopularNewsCriterion();
    final String popularNewsCriterionString = popularNewsCriterion.toString().split('.').last;

    final Map<String, dynamic> response = await _httpClient.get(
      Request(
        path:
            "${_Urls.mostPopular}$popularNewsCriterionString/${_Constants.mostPopularFromPeriodInDays}${_Urls.responseDataExtension}",
      ),
    ) as Map<String, dynamic>;

    return NyTimesResponse<MostPopularArticleResponse>.fromJson(
            response, MostPopularArticleResponse.fromJson)
        .articles
        .map((articleResponse) => MostPopularArticleResponse.toArticle(articleResponse))
        .toList();
  }

  @override
  Future<List<Article>> getNewestArticles() async {
    final Map<String, dynamic> response =
        await _httpClient.get(Request(path: _Urls.newest)) as Map<String, dynamic>;

    return NyTimesResponse<NewestArticleResponse>.fromJson(response, NewestArticleResponse.fromJson)
        .articles
        .map((articleResponse) => NewestArticleResponse.toArticle(articleResponse))
        .where((article) => article.title.isNotEmpty)
        .toList();
  }
}
