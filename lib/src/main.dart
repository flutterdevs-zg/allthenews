import 'package:allthenews/src/allthenews_app.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/common/theme/theme_notifier.dart';

void main() {
  injectDependencies();
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(
    ChangeNotifierProvider(
      create: (_) => inject<ThemeNotifier>(),
      child: AllTheNewsApp(),
    ),
  );
}
