import 'package:allthenews/src/allthenews_app.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:flutter/material.dart';

void main() {
  injectDependencies();
  runApp(AllTheNewsApp());
}
