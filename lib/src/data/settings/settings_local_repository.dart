import 'package:allthenews/src/domain/common/persistence/persistence_repository.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/domain/settings/app_theme.dart';
import 'package:rxdart/rxdart.dart';

class _Constants {
  static const selectedPopularNewsCriterionKey = 'popularNewsCriterionKey';
  static const selectedThemeKey = 'selectedThemeKey';
}

class SettingsLocalRepository extends SettingsRepository {
  final PersistenceRepository _persistenceRepository;

  final _popularNewsCriterionStream = BehaviorSubject<PopularNewsCriterion>();

  SettingsLocalRepository(this._persistenceRepository);

  @override
  Future<PopularNewsCriterion> getPopularNewsCriterion() async {
    final criterionValue =
        await _persistenceRepository.getString(_Constants.selectedPopularNewsCriterionKey);
    return PopularNewsCriterion.values.firstWhere(
        (criterion) => criterion.toString() == criterionValue,
        orElse: () => PopularNewsCriterion.viewed);
  }

  @override
  Future<AppTheme> getTheme() async {
    final themeValue = await _persistenceRepository.getString(_Constants.selectedThemeKey);
    return AppTheme.values
        .firstWhere((theme) => theme.toString() == themeValue, orElse: () => AppTheme.light);
  }

  @override
  Future<void> savePopularNewsCriterion(PopularNewsCriterion popularNewsCriterion) async {
    _persistenceRepository.saveString(
        _Constants.selectedPopularNewsCriterionKey, popularNewsCriterion.toString());
    _popularNewsCriterionStream.add(popularNewsCriterion);
  }

  @override
  Future<void> saveTheme(AppTheme theme) =>
      _persistenceRepository.saveString(_Constants.selectedThemeKey, theme.toString());

  @override
  Stream<PopularNewsCriterion> getPopularNewsCriterionStream() {
    getPopularNewsCriterion().then((value) => _popularNewsCriterionStream.add(value));
    return _popularNewsCriterionStream;
  }
}
