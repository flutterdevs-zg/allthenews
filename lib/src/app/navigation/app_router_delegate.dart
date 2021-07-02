import 'package:allthenews/src/app/navigation/app_path.dart';
import 'package:allthenews/src/app/navigation/route_page_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRouterDelegate extends RouterDelegate<AppPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppPath> {
  late RoutePageManager _pageManager;

  AppRouterDelegate() {
    _pageManager = RoutePageManager();
    _pageManager.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoutePageManager>.value(
      value: _pageManager,
      builder: (providerContext, child) {
        final pages = providerContext.watch<RoutePageManager>().pages;
        return Navigator(
          key: navigatorKey,
          onPopPage: _onPopPage,
          pages: List.of(pages),
        );
      },
    );
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (didPop) {
      _pageManager.didPop(route.settings);
    }
    return didPop;
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _pageManager.navigatorKey;

  @override
  AppPath? get currentConfiguration => _pageManager.currentPath;

  @override
  Future<void> setNewRoutePath(AppPath configuration) async {
    await _pageManager.setNewRoutePath(configuration);
  }
}
