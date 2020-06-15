abstract class PersistenceRepository {

  Future<bool> saveString(String key, String value);

  Future<String> getString(String key);
}
