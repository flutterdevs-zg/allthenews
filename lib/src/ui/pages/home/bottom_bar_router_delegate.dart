import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/app/navigation/app_path.dart';
import 'package:allthenews/src/ui/common/util/untranslatable_strings.dart';
import 'package:allthenews/src/ui/common/widget/ny_times_appbar.dart';
import 'package:allthenews/src/ui/pages/dashboard/dashboard_page.dart';
import 'package:allthenews/src/ui/pages/home/bottom_bar_notifier.dart';
import 'package:allthenews/src/ui/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

class BottomBarRouterDelegate extends RouterDelegate<BottomBarAppPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BottomBarAppPath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BottomBarNotifier _bottomBarNotifier;

  BottomBarNotifier get bottomBarNotifier => _bottomBarNotifier;

  set bottomBarNotifier(BottomBarNotifier value) {
    if (value == _bottomBarNotifier) {
      return;
    }
    _bottomBarNotifier = value;
    notifyListeners();
  }

  BottomBarRouterDelegate(this._bottomBarNotifier);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _bottomBarNotifier.selectedIndex == 0
          ? [
              MaterialPage(
                child: DashboardPage(),
                key: const ValueKey(PagePathLocation.dashboardPage),
              ),
            ]
          : [
              MaterialPage(
                child: ProfilePage(),
                key: const ValueKey(PagePathLocation.profilePage),
              ),
            ],
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  @override
  Future<void> setNewRoutePath(BottomBarAppPath path) async {
    assert(false);
  }

  List<BottomNavigationBarItem> buildBottomNavigationItems() => [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: UntranslatableStrings.news,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle),
          label: Strings.current.profile,
        ),
      ];

  Future<bool> onWillPop() {
    if (_bottomBarNotifier.selectedIndex == 0) {
      return Future.value(true);
    } else {
      _bottomBarNotifier.selectedIndex = 0;
      return Future.value(false);
    }
  }

  NyTimesAppBar? getAppBar({required bool isAuthenticated}) {
    if (bottomBarNotifier.selectedIndex == 0) {
      return const NyTimesAppBar(
        title: UntranslatableStrings.newYorkTimes,
        hasSearchAction: true,
        hasSettingsAction: true,
      );
    } else {
      if (isAuthenticated) {
        return const NyTimesAppBar(hasSettingsAction: true,);
      } else {
        return NyTimesAppBar(title: Strings.current.profile);
      }
    }
  }
}
