import 'package:allthenews/src/domain/appinfo/app_info_repository.dart';
import 'package:allthenews/src/domain/common/function.dart';
import 'package:allthenews/src/domain/settings/app_theme.dart';
import 'package:allthenews/src/domain/settings/popular_news_criterion.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/common/theme/theme_notifier.dart';
import 'package:flutter/material.dart';

class SettingsNotifier extends ChangeNotifier {
  final AppInfoRepository _appInfoRepository;
  final SettingsRepository _settingsRepository;

  SettingsNotifier(this._settingsRepository, this._appInfoRepository);

  SettingsViewState _viewState = SettingsViewState(
    isLoading: true,
    appVersion: null,
    isDarkModeEnabled: false,
    selectedPopularNewsCriterion: PopularNewsCriterion.viewed,
  );

  SettingsViewState get viewState => _viewState;

  Future<void> loadSettings() async {
    final appTheme = _settingsRepository.getTheme();
    final appVersion = _appInfoRepository.getAppVersion();
    final selectedCriterion = _settingsRepository.getPopularNewsCriterion();
    _viewState = SettingsViewState(
      appVersion: await appVersion,
      isDarkModeEnabled: await appTheme == AppTheme.dark,
      selectedPopularNewsCriterion: await selectedCriterion,
    );
    notifyListeners();
  }

  Future<void> selectDarkMode({required bool isSelected, required Read read}) async {
    await _settingsRepository.saveTheme(isSelected ? AppTheme.dark : AppTheme.light);
    final selectedTheme = await _settingsRepository.getTheme();
    _viewState = SettingsViewState(
      appVersion: _viewState.appVersion,
      isDarkModeEnabled: selectedTheme == AppTheme.dark,
      selectedPopularNewsCriterion: _viewState.selectedPopularNewsCriterion,
    );
    notifyListeners();
    read<ThemeNotifier>().updateAppTheme(selectedTheme);
  }

  Future<void> selectPopularNewsCriterion(PopularNewsCriterion criterion) async {
    await _settingsRepository.savePopularNewsCriterion(criterion);
    _viewState = SettingsViewState(
      appVersion: _viewState.appVersion,
      isDarkModeEnabled: _viewState.isDarkModeEnabled,
      selectedPopularNewsCriterion: await _settingsRepository.getPopularNewsCriterion(),
    );
    notifyListeners();
  }
}

class SettingsViewState {
  final bool isLoading;
  final String? appVersion;
  final bool isDarkModeEnabled;
  final PopularNewsCriterion selectedPopularNewsCriterion;

  SettingsViewState({
    required this.appVersion,
    required this.isDarkModeEnabled,
    required this.selectedPopularNewsCriterion,
    this.isLoading = false,
  });
}
