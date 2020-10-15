import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/ui/pages/feed/feed_page.dart';
import 'package:allthenews/src/ui/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedPage = 0;
  final _pages = [
    FeedPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _pages[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => setState(() => _selectedPage = index),
          items: _buildBottomNavigationItems(),
          currentIndex: _selectedPage,
        ),
      );

  List<BottomNavigationBarItem> _buildBottomNavigationItems() => [
        BottomNavigationBarItem(
          icon: const Icon(Icons.article),
          label: Strings.current.news,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle),
          label: Strings.current.profile,
        ),
      ];
}
