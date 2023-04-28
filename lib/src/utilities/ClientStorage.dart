import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<SharedPreferences> get _instance async =>
      _preferencesInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _preferencesInstance;

  static Future<SharedPreferences?> init() async {
    _preferencesInstance = await _instance;
    return _preferencesInstance;
  }

  static String getString(String key, [String? defaultValue]) {
    return _preferencesInstance?.getString(key) ?? defaultValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var preferences = await _instance;
    return preferences.setString(key, value);
  }

  // --- Refactor: check return type
  static void setMultipleStrings(Map<String, String> map) async {
    var preferences = await _instance;
    map.forEach((key, value) {
      preferences.setString(key, value);
    });
  }

  static Future<bool> containsKey(String key) async {
    var preferences = await _instance;
    return preferences.containsKey(key);
  }

  static Future<String?> getExistingString(String key) async {
    var preferences = await _instance;
    return preferences.containsKey(key) ? preferences.getString(key) : "";
  }
}
