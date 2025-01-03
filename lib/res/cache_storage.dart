import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  late final SharedPreferences _sharedPrefs;

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  Future<void> addToList(List<String> value, String key) async {
    _sharedPrefs.setStringList(key, value);
  }

  Future<List<String>> getList(String key) async {
    return _sharedPrefs.getStringList(key) ?? [];
  }
}
