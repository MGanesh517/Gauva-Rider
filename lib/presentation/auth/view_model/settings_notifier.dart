import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsNotifier extends StateNotifier<String> {
  SettingsNotifier() : super('en');

  void changeLanguage(String locale) => state = locale;
}
