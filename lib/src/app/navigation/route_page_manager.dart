import 'package:allthenews/src/app/navigation/app_path.dart';
import 'package:allthenews/src/app/navigation/app_router_information_parser.dart';
import 'package:allthenews/src/ui/pages/authentication/login/login_page.dart';
import 'package:allthenews/src/ui/pages/authentication/registration/registration_page.dart';
import 'package:allthenews/src/ui/pages/dashboard/dashboard_page.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/latest/latest_news_page.dart';
import 'package:allthenews/src/ui/pages/dashboard/news/most_popular/most_popular_news_page.dart';
import 'package:allthenews/src/ui/pages/home/bottom_bar_notifier.dart';
import 'package:allthenews/src/ui/pages/home/home_page.dart';
import 'package:allthenews/src/ui/pages/location/location_page.dart';
import 'package:allthenews/src/ui/pages/presentation/presentation_page.dart';
import 'package:allthenews/src/ui/pages/profile/profile_page.dart';
import 'package:allthenews/src/ui/pages/settings/settings_page.dart';
import 'package:allthenews/src/ui/pages/web_view/web_view_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RoutePageManager extends ChangeNotifier {
  final BottomBarNotifier _bottomBarNotifier = BottomBarNotifier();
  final List<Page> _pages = [];

  RoutePageManager() {
    _bottomBarNotifier.addListener(notifyListeners);
    _pages.addAll(_buildInitialPages(_bottomBarNotifier));
  }

  List<Page> _buildInitialPages(BottomBarNotifier state) {
    return [
      MaterialPage(
        child: PresentationPage(),
        key: const ValueKey(PagePathLocation.presentationPage),
      )
    ];
  }

  int get selectedIndex => _bottomBarNotifier.selectedIndex;

  set selectedIndex(int index) {
    _bottomBarNotifier.selectedIndex = index;
    notifyListeners();
  }

  List<Page> get pages => List.unmodifiable(_pages);
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  AppPath get currentPath {
    final lastPageKeyValue = (_pages.last.key as ValueKey<String>?)!.value;
    final currentPath = parseRoute(Uri.parse(lastPageKeyValue));
    if (currentPath == const HomePath()) {
      return _bottomBarNotifier.selectedIndex == 0 ? const DashboardPath() : const ProfilePath();
    } else {
      return currentPath;
    }
  }

  void pop() {
    _pages.removeLast();
    notifyListeners();
  }

  void didPop(RouteSettings routeSettings) {
    _pages.remove(routeSettings);
    notifyListeners();
  }

  Future<void> setNewRoutePath(AppPath configuration) async {
    if (configuration is SettingsPath) {
      _pages.add(MaterialPage(
        child: SettingsPage(),
        key: const ValueKey(PagePathLocation.settingsPage),
      ));
    } else if (configuration is PresentationPath) {
      _pages.clear();
      _pages.add(MaterialPage(
        child: PresentationPage(),
        key: const ValueKey(PagePathLocation.presentationPage),
      ));
    } else if (configuration is DashboardPath) {
      _pages.add(MaterialPage(
        child: DashboardPage(),
        key: const ValueKey(PagePathLocation.dashboardPage),
      ));
    } else if (configuration is LatestNewsPath) {
      _pages.add(MaterialPage(
        child: LatestNewsListPage(),
        key: const ValueKey(PagePathLocation.latestNewsPage),
      ));
    } else if (configuration is ProfilePath) {
      _bottomBarNotifier.selectedIndex = 1;
      _pages.add(MaterialPage(
        child: ProfilePage(),
        key: const ValueKey(PagePathLocation.profilePage),
      ));
    } else if (configuration is MostPopularNewsPath) {
      _pages.add(MaterialPage(
        child: MostPopularNewsListPage(),
        key: const ValueKey(PagePathLocation.mostPopularNewsPage),
      ));
    } else if (configuration is LoginPath) {
      _pages.add(MaterialPage(
        child: LoginPage(),
        key: const ValueKey(PagePathLocation.loginPage),
      ));
    } else if (configuration is RegistrationPath) {
      _pages.add(MaterialPage(
        child: RegistrationPage(),
        key: const ValueKey(PagePathLocation.registrationPage),
      ));
    } else if (configuration is LocationPath) {
      _pages.add(MaterialPage(
        child: LocationPage(),
        key: const ValueKey(PagePathLocation.locationPage),
      ));
    } else if (configuration is WebViewPath) {
      _pages.add(MaterialPage(
        child: WebViewPage(configuration.url),
        key: ValueKey('${PagePathLocation.webViewPage}?url=${configuration.url}'),
      ));
    } else if (configuration is HomePath) {
      _pages.clear();
      _pages.add(MaterialPage(
        child: HomePage(_bottomBarNotifier),
        key: const ValueKey(PagePathLocation.homePage),
      ));
    }
    notifyListeners();
    return;
  }

  void openDashboard() => setNewRoutePath(const DashboardPath());

  void openWebView(String url) => setNewRoutePath(WebViewPath(url));

  void openMostPopularNews() => setNewRoutePath(const MostPopularNewsPath());

  void openLatestNews() => setNewRoutePath(const LatestNewsPath());

  void openLogin() => setNewRoutePath(const LoginPath());

  void openRegistration() => setNewRoutePath(const RegistrationPath());

  void openProfile() => setNewRoutePath(const ProfilePath());

  void openSettings() => setNewRoutePath(const SettingsPath());

  void resetToHome() => setNewRoutePath(const HomePath());

  void openLocation() => setNewRoutePath(const LocationPath());
}
