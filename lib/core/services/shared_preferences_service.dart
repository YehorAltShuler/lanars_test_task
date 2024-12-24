import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/theme_mode_helper.dart';

const String _kThemeModeKey = 'theme_mode';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static late SharedPreferences _preferences;

  SharedPreferencesService._();

  // Using a singleton pattern
  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService._();

    _preferences = await SharedPreferences.getInstance();

    return _instance!;
  }

  //ThemeMode
  ThemeMode get themeMode {
    final themeString = _getData(_kThemeModeKey) ??
        ThemeModeHelper.toShortString(ThemeMode.system);
    return ThemeModeHelper.fromShortString(themeString);
  }

  set themeMode(ThemeMode value) {
    final themeString = ThemeModeHelper.toShortString(value);
    _saveData(_kThemeModeKey, themeString);
  }

  dynamic _getData(String key) {
    final value = _preferences.get(key);
    debugPrint('Retrieved $key: $value');
    return value;
  }

  void _saveData(String key, dynamic value) {
    debugPrint('Saving $key: $value');
    if (value is String) {
      _preferences.setString(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    } else {
      throw ArgumentError('Unsupported type for SharedPreferences: $value');
    }
  }

  void removeData(String key) {
    debugPrint('Removing $key');
    _preferences.remove(key);
  }

  void clearAll() {
    debugPrint('Clearing all data');
    _preferences.clear();
  }
}
