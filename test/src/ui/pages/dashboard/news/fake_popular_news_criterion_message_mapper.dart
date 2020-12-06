import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/popular_news_criterion_message_mapper.dart';

class FakePopularNewsCriterionMessageMapper extends PopularNewsCriterionMessageMapper {
  @override
  String map(PopularNewsCriterion popularNewsCriterion) => popularNewsCriterion.toString();
}