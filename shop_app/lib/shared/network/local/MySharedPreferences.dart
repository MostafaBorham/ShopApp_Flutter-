// ignore_for_file: file_names
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static bool? getBoolean(String key) {
    return sharedPreferences!.getBool(key);
  }

  static Future<bool> putBoolean(String key, bool value) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static Future<dynamic> saveData(String key, dynamic value) async {
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    } else if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    } else if (value is double) {
      return await sharedPreferences!.setDouble(key, value);
    } else {
      return await sharedPreferences!.setStringList(key, value);
    }
  }

  static dynamic retreiveData(String key) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> clearData(String key) async {
    return await sharedPreferences!.remove(key);
  }
}
