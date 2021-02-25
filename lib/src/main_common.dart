import 'package:allthenews/src/app/allthenews_app.dart';
import 'package:allthenews/src/app/app_flavors.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:flutter/material.dart';

void mainCommon(Environment flavor) {
  WidgetsFlutterBinding.ensureInitialized();
  injectDependencies(flavor);
  runApp(AllTheNewsApp());
}
