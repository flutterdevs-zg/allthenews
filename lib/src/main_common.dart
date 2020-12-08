import 'package:allthenews/src/app/allthenews_app.dart';
import 'package:allthenews/src/app/app_flavors.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/theme/theme_notifier.dart';
import 'package:allthenews/src/ui/pages/presentation/presentation_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> mainCommon(Environment flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  injectDependencies(flavor);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: inject<ThemeNotifier>()),
        ChangeNotifierProvider(create: (_) => inject<PresentationNotifier>()),
      ],
      child: AllTheNewsApp(),
    ),
  );
}
