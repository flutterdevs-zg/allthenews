abstract class PersistenceRepository {

  Future<bool> saveString(String key, String value);

  Future<String> getString(String key);

  // ignore: avoid_positional_boolean_parameters
  Future<bool> saveBool(String key, bool value);

  Future<bool> getBool(String key);
}
