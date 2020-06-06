import 'package:allthenews/src/domain/appinfo/app_info_repository.dart';
import 'package:package_info/package_info.dart';

class AppInfoLocalRepository implements AppInfoRepository {
  @override
  Future<String> getAppVersion() async => (await PackageInfo.fromPlatform()).version;
}
