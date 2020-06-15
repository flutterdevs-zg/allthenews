import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/app_theme.dart';

abstract class SettingsRepository {

  Future<void> savePopularNewsCriterion(PopularNewsCriterion popularNewsCriterion);

  Future<PopularNewsCriterion> getPopularNewsCriterion();

  Future<void> saveTheme(AppTheme theme);

  Future<AppTheme> getTheme();
}
