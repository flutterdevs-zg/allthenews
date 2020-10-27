import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';

extension PopularNewsCriterionExtensions on PopularNewsCriterion {
  String getTitle() {
    switch (this) {
      case PopularNewsCriterion.viewed:
        return Strings.current.mostViewed;
      case PopularNewsCriterion.shared:
        return Strings.current.mostShared;
      case PopularNewsCriterion.emailed:
        return Strings.current.mostEmailed;
    }
    return '';
  }
}
