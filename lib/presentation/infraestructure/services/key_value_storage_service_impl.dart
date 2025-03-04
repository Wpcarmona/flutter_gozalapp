import 'package:shared_preferences/shared_preferences.dart';
import 'key_value_storage_service.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final pref = await getSharedPrefs();

    if (T == int) return pref.getInt(key) as T?;
    if (T == String) return pref.getString(key) as T?;
    if (T == bool) return pref.getBool(key) as T?;
    if (T == double) return pref.getDouble(key) as T?;
    if (T == List<String>) return pref.getStringList(key) as T?;

    throw UnimplementedError('Get not implemented for type $T');
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final pref = await getSharedPrefs();

    bool success = false;
    if (value is int) {
      success = await pref.setInt(key, value);
    } else if (value is String) {
      success = await pref.setString(key, value);
    } else if (value is bool) {
      success = await pref.setBool(key, value);
    } else if (value is double) {
      success = await pref.setDouble(key, value);
    } else if (value is List<String>) {
      success = await pref.setStringList(key, value);
    } else {
      throw UnimplementedError('Set not implemented for type $T');
    }
    if (!success) {
      throw Exception('Failed to save key: $key');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final pref = await getSharedPrefs();
    return await pref.remove(key);
  }
}
