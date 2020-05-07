import 'package:allthenews/allthenews_app.dart';
import 'package:allthenews/di/injector.dart';
import 'package:flutter/material.dart';

void main() {
  injectDependencies();
  runApp(AllTheNewsApp());
}
