import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences preferences;
  static bool _init = false;

  static Future init() async {
    if (_init) return;
    preferences = await SharedPreferences.getInstance();
    _init = true;
    debugPrint('SharedPrefs initialized!');
    return preferences;
  }

  static Future<void> clearData() async {
    await preferences.clear();
  }

  static Future<bool> saveData<T>(String key, T value) async {
    if (value is String) {
      return await preferences.setString(key, value);
    } else if (value is int) {
      return await preferences.setInt(key, value);
    } else if (value is double) {
      return await preferences.setDouble(key, value);
    } else if (value is bool) {
      return await preferences.setBool(key, value);
    } else if (value is List<String>) {
      return await preferences.setStringList(key, value);
    } else {
      throw Exception('Cannot save to shared preferences!');
    }
  }

  static T? getData<T>(String key) {
    if (T == String) {
      return preferences.getString(key) as T?;
    } else if (T == int) {
      return preferences.getInt(key) as T?;
    } else if (T == double) {
      return preferences.getDouble(key) as T?;
    } else if (T == bool) {
      return preferences.getBool(key) as T?;
    } else if (T == List<String>) {
      return preferences.getStringList(key) as T?;
    } else {
      throw Exception('Cannot get from shared preferences!');
    }
  }

  static Future<bool> saveMapData(String key, Map<String, dynamic> value) async {
    final jsonString = jsonEncode(value);
    debugPrint('jsonString: $jsonString');
    return await preferences.setString(key, jsonString);
  }

  static Map<String, dynamic> getMapData(String key) {
    final jsonString = preferences.getString(key);
    if (jsonString == null) {
      return {};
    }
    return jsonDecode(jsonString);
  }
}
