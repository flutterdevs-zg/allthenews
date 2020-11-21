import 'package:allthenews/src/app/allthenews_app.dart';
import 'package:allthenews/src/app/app_flavors.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/theme/theme_notifier.dart';
import 'package:allthenews/src/ui/pages/presentation/presentation_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> mainCommon(Environment flavor) async {
  injectDependencies(flavor);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => inject<ThemeNotifier>()),
        ChangeNotifierProvider(create: (_) => inject<PresentationNotifier>()),
      ],
      child: AllTheNewsApp(),
    ),
  );
}
