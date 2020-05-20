import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/ui/common/theme/theme.dart';
import 'package:allthenews/src/ui/pages/news_list/news_list_page.dart';
import 'package:flutter/material.dart';

class AllTheNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: newsTheme,
      home: NewsListPage(),
      localizationsDelegates: [
        Strings.delegate,
      ],
      supportedLocales: Strings.delegate.supportedLocales,
    );
  }
}
