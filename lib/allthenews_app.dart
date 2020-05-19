import 'package:allthenews/ui/common/theme/theme.dart';
import 'package:allthenews/ui/pages/news_list/home_page.dart';
import 'package:flutter/material.dart';

class AllTheNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: newsTheme,
      home: HomePage(),
    );
  }
}
