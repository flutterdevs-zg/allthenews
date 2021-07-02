import 'dart:convert';

import 'package:allthenews/src/app/navigation/app_path.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';

class AppRouteInformationParser extends RouteInformationParser<AppPath> {
  @override
  Future<AppPath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    return parseRoute(uri);
  }

  @override
  RouteInformation? restoreRouteInformation(AppPath path) {
    if (_noArgsPagesConfiguration.containsValue(path)) {
      final String? pagePathLocation =
          _noArgsPagesConfiguration.entries.firstWhereOrNull((entry) => entry.value == path)?.key;
      return RouteInformation(location: pagePathLocation);
    } else if (path is WebViewPath) {
      return RouteInformation(
        location: '${PagePathLocation.webViewPage}?url=${const HtmlEscape().convert(path.url)}',
      );
    } else {
      return null;
    }
  }
}

final Map<String, AppPath> _noArgsPagesConfiguration = {
  PagePathLocation.homePage: const HomePath(),
  PagePathLocation.dashboardPage: const DashboardPath(),
  PagePathLocation.presentationPage: const PresentationPath(),
  PagePathLocation.mostPopularNewsPage: const MostPopularNewsPath(),
  PagePathLocation.latestNewsPage: const LatestNewsPath(),
  PagePathLocation.profilePage: const ProfilePath(),
  PagePathLocation.settingsPage: const SettingsPath(),
  PagePathLocation.loginPage: const LoginPath(),
  PagePathLocation.registrationPage: const RegistrationPath(),
  PagePathLocation.locationPage: const LocationPath(),
};

AppPath parseRoute(Uri uri) {
  if (_noArgsPagesConfiguration.containsKey(uri.path)) {
    return _noArgsPagesConfiguration[uri.path]!;
  } else if (uri.path == PagePathLocation.webViewPage) {
    final String url = uri.queryParameters['url']!;
    return WebViewPath(url);
  } else {
    return const PresentationPath();
  }
}
