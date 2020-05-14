import 'package:allthenews/ui/common/theme/theme.dart';
import 'package:allthenews/ui/pages/news_list/news_list_page.dart';
import 'package:allthenews/ui/pages/news_list/secondary_news/secondary_news_list_page.dart';
import 'package:flutter/material.dart';

class AllTheNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: newsTheme,
      initialRoute: NewsListPage.id,
      routes: {
        NewsListPage.id: (context) => NewsListPage(),
        SecondaryNewsListPage.id: (context) => SecondaryNewsListPage(),
      },
    );
  }
}
