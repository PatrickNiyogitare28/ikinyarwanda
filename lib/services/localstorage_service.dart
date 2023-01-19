import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  static Future<LocalStorageService?> getServiceInstance() async {
    _instance ??= LocalStorageService();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance;
  }

  Future<void> saveStringListToDisk(String key, Set<String> list) async {
    await _preferences!.setStringList(key, list.toList());
  }

  void removeFromDisk(String key) {
    _preferences!.remove(key);
  }

  Set<String> getStringListFromDisk(String key) {
    var value = _preferences!.getStringList(key);
    if (value != null) {
      return value.toSet();
    } else {
      return {};
    }
  }
}
