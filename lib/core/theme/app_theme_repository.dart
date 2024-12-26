import 'package:flutter/material.dart';
import 'package:lanars_test_task/core/services/impl/shared_preferences_service.dart';

class AppThemeRepository {
  final SharedPreferencesService _sharedPreferencesService;

  AppThemeRepository(this._sharedPreferencesService);

  ThemeMode getThemeMode() {
    final themeMode = _sharedPreferencesService.themeMode;
    return themeMode;
  }

  void setThemeMode(ThemeMode themeMode) {
    _sharedPreferencesService.themeMode = themeMode;
  }
}
