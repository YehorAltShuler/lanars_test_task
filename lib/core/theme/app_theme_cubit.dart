import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_theme_repository.dart';

class AppThemeCubit extends Cubit<ThemeMode> {
  final AppThemeRepository _repository;

  AppThemeCubit(this._repository) : super(ThemeMode.system) {
    _initTheme();
  }

  void _initTheme() {
    final themeMode = _repository.getThemeMode();
    emit(themeMode);
  }

  void setThemeMode(ThemeMode themeMode) {
    _repository.setThemeMode(themeMode);
    emit(themeMode);
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      setThemeMode(ThemeMode.dark);
    } else {
      setThemeMode(ThemeMode.light);
    }
  }
}
