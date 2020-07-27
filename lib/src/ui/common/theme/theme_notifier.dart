import 'package:allthenews/src/domain/settings/app_theme.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/common/theme/theme.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {

  final SettingsRepository _settingsRepository;

  ThemeNotifier(this._settingsRepository);

  ThemeData _themeData;

  ThemeData get themeData => _themeData;
  bool get isLoading => _themeData == null;

  Future<void> initTheme() async {
    final AppTheme appTheme = await _settingsRepository.getTheme();
    updateAppTheme(appTheme);
  }

  void updateAppTheme(AppTheme theme) {
    _themeData = theme == AppTheme.light ? lightNewsTheme : darkNewsTheme;
    notifyListeners();
  }
}
