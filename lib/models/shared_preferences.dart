
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<void> setData(String key,String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key)??"";
  }

}

