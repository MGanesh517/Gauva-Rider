import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/data/services/local_storage_service.dart';

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  final _local = LocalStorageService();

  Future<void> _loadTheme() async {
    state = _themeModeFromString(await _local.getThemeMode());
  }

  void setTheme(ThemeMode mode) {

    // setStatusBar(isDark: mode == ThemeMode.dark);
    state = mode;
    _local.setTheme(_themeModeToString(mode));

  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }

  ThemeMode _themeModeFromString(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  bool isDarkMode()=> state == ThemeMode.dark;
}
