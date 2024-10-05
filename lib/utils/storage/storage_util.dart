import 'package:shared_preferences/shared_preferences.dart';

/// 本地持久化工具类
class StorageUtil {
  StorageUtil._();

  static Future get(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.get(key);
  }

  static Future<bool> setStringList(String key, List<String> values) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setStringList(key, values);
  }

  static Future<List<String>?> getStringList(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getStringList(key);
  }

  static Future setString(String key, String value) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setString(key, value);
  }

  static Future getString(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(key);
  }

  static Future<bool> setInt(String key, int value) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getInt(key);
  }

  static Future setDouble(String key, double value) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getDouble(key);
  }

  static Future getDouble(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getDouble(key);
  }

  static Future<bool> remove(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }

  static Future<bool> clear() async {
    final sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
}
