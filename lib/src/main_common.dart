import 'package:allthenews/src/app/allthenews_app.dart';
import 'package:allthenews/src/app/app_flavors.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/theme/theme_notifier.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void mainCommon(Environment flavor) {
  injectDependencies(flavor);
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(
    ChangeNotifierProvider(
      create: (_) => inject<ThemeNotifier>(),
      child: AllTheNewsApp(),
    ),
  );
}