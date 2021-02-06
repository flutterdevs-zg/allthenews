abstract class AppPath {
  const AppPath();
}

class HomePath extends AppPath {
  const HomePath();
}

abstract class BottomBarAppPath extends AppPath {
  const BottomBarAppPath();
}

class DashboardPath extends BottomBarAppPath {
  const DashboardPath();
}

class ProfilePath extends BottomBarAppPath {
  const ProfilePath();
}

class PresentationPath extends AppPath {
  const PresentationPath();
}

class MostPopularNewsPath extends AppPath {
  const MostPopularNewsPath();
}

class LatestNewsPath extends AppPath {
  const LatestNewsPath();
}

class RegistrationPath extends AppPath {
  const RegistrationPath();
}

class LoginPath extends AppPath {
  const LoginPath();
}

class SettingsPath extends AppPath {
  const SettingsPath();
}

class WebViewPath extends AppPath {
  final String url;

  const WebViewPath(this.url);
}

class LocationPath extends AppPath {
  const LocationPath();
}

class PagePathLocation {
  PagePathLocation._();

  static const homePage = 'home';
  static const presentationPage = 'presentation';
  static const dashboardPage = 'dashboard';
  static const settingsPage = 'settings';
  static const latestNewsPage = 'latest';
  static const mostPopularNewsPage = 'popular';
  static const webViewPage = 'web_view';
  static const profilePage = 'profile';
  static const loginPage = 'login';
  static const locationPage = 'location';
  static const registrationPage = 'registration';
}
