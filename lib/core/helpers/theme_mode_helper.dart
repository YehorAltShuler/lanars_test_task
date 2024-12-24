import 'package:flutter/material.dart';

class ThemeModeHelper {
  static String toShortString(ThemeMode mode) {
    return mode.toString().split('.').last;
  }

  static ThemeMode fromShortString(String mode) {
    switch (mode.toLowerCase()) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        throw ArgumentError('Invalid ThemeMode string: $mode');
    }
  }
}
