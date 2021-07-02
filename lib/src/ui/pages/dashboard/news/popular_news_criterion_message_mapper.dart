import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';

abstract class PopularNewsCriterionMessageMapper {
  String map(PopularNewsCriterion popularNewsCriterion);
}

class PopularNewsCriterionMessageLocalMapper extends PopularNewsCriterionMessageMapper {
  @override
  String map(PopularNewsCriterion popularNewsCriterion) {
    switch (popularNewsCriterion) {
      case PopularNewsCriterion.viewed:
        return Strings.current.mostViewed;
      case PopularNewsCriterion.shared:
        return Strings.current.mostShared;
      case PopularNewsCriterion.emailed:
        return Strings.current.mostEmailed;
    }
  }
}
