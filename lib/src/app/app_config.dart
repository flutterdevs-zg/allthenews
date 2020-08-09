abstract class AppConfig {
  final String baseUrl;

  AppConfig(this.baseUrl);
}

class DevAppConfig implements AppConfig {
  @override
  final baseUrl = "https://api.nytimes.com/svc/";
}

class ProdAppConfig implements AppConfig {
  @override
  final baseUrl = "https://api.nytimes.com/svc/";
}