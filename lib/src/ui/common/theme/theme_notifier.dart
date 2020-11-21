import 'package:allthenews/src/domain/settings/app_theme.dart';
import 'package:allthenews/src/domain/settings/settings_repository.dart';
import 'package:allthenews/src/ui/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    if (theme == AppTheme.light) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ));

      _themeData = lightNewsTheme;
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.black,
      ));

      _themeData = darkNewsTheme;
    }
    notifyListeners();
  }
}
