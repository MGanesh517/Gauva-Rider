import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gauva_userapp/core/extensions/storage_safe_read.dart';
import 'package:gauva_userapp/data/models/user_hive_model.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() => _instance;

  LocalStorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _languageKey = 'language';

  final ValueNotifier<String> languageNotifier = ValueNotifier('en');

  Future<void> init() async {
    final lang = await _storage.safeRead(key: _languageKey);
    languageNotifier.value = lang ?? 'en';
  }

  Future<void> selectLanguage(String language) async {
    await _storage.write(key: _languageKey, value: language);
    languageNotifier.value = language;
  }

  Future<String> getSelectedLanguage() async => await _storage.safeRead(key: _languageKey) ?? 'en';

  Future<String> getPhoneCode() async => await _storage.safeRead(key: 'country-code') ?? '+91';

  void savePhoneCode(String countryCode) async {
    await _storage.write(key: 'country-code', value: countryCode);
  }

  void setTheme(String mode) {
    _storage.write(key: 'themeMode', value: mode);
  }

  Future<String> getThemeMode() async => await _storage.safeRead(key: 'themeMode') ?? 'light';

  Future<void> saveUser({required Map<String, dynamic> user}) async {
    await _storage.write(key: 'user', value: jsonEncode(user));
  }

  Future<UserModel?> getSavedUser() async {
    final String? raw = await _storage.safeRead(key: 'user');
    if (raw == null) {
      throw Exception('No user found');
    }

    return UserModel.fromJson(jsonDecode(raw));
  }

  void setRegistrationProgress(String pageName) async {
    await _storage.write(key: 'registration', value: pageName);
  }

  Future<String?> getRegistrationProgress() async => await _storage.safeRead(key: 'registration');

  Future<int> getUserId() async {
    final user = await getSavedUser();
    return user?.id ?? 0;
  }

  Future<void> saveToken(String token) async {
    if (token.isEmpty) {
      debugPrint('⚠️ WARNING: Attempting to save empty token!');
      return;
    }
    await _storage.write(key: 'token', value: token);
    debugPrint('✅ Token saved to secure storage (${token.length} chars)');

    // Verify token was saved
    final savedToken = await _storage.safeRead(key: 'token');
    if (savedToken == null || savedToken.isEmpty) {
      debugPrint('❌ ERROR: Token was not saved properly to secure storage!');
    } else if (savedToken != token) {
      debugPrint('⚠️ WARNING: Saved token does not match original token!');
    } else {
      debugPrint('✅ Token verification: Token successfully saved and verified');
    }
  }

  Future<String?> getToken() async {
    final token = await _storage.safeRead(key: 'token');
    if (token == null || token.isEmpty) {
      debugPrint('⚠️ No token found in secure storage');
    } else {
      debugPrint('✅ Token retrieved from secure storage (${token.length} chars)');
    }
    return token;
  }

  Future<void> clearToken() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'refreshToken');
  }

  // Spring Boot: Store refresh token
  Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<String?> getRefreshToken() async => await _storage.safeRead(key: 'refreshToken');

  Future<void> clearUser() async {
    await _storage.delete(key: 'user');
  }

  Future<void> completeOnboarding() async {
    await _storage.write(key: 'onboarding', value: 'true');
  }

  Future<bool> isCompletedOnboarding() async => (await _storage.safeRead(key: 'onboarding')) == 'true';

  Future<bool> isLoggedIn() async => (await _storage.safeRead(key: 'token')) != null;

  Future<void> saveChatState({required bool isOpen}) async {
    await _storage.write(key: 'chat-state', value: isOpen.toString());
  }

  Future<bool> getChatState() async {
    final value = await _storage.safeRead(key: 'chat-state');
    return value == 'true';
  }

  Future<void> saveOrderId(int? id) async {
    await _storage.write(key: 'order_id', value: id?.toString());
  }

  Future<int?> getOrderId() async {
    final value = await _storage.safeRead(key: 'order_id');
    return value != null ? int.tryParse(value) : null;
  }

  Future<void> clearOrderId() async {
    await _storage.delete(key: 'order_id');
  }

  static const String _promotionalKey = 'promotional_enabled';
  static const String _vibrationKey = 'vibration_enabled';
  static const String _notificationsKey = 'notifications_enabled';

  Future<void> setPromotional(bool value) async {
    await _storage.write(key: _promotionalKey, value: value.toString());
  }

  Future<bool> getPromotional() async => (await _storage.safeRead(key: _promotionalKey)) != 'false';

  Future<void> setVibration(bool value) async {
    await _storage.write(key: _vibrationKey, value: value.toString());
  }

  Future<bool> getVibration() async => (await _storage.safeRead(key: _vibrationKey)) != 'false';

  Future<void> setNotificationPermission(bool granted) async {
    await _storage.write(key: _notificationsKey, value: granted.toString());
  }

  Future<bool> getNotificationPermission() async => (await _storage.safeRead(key: _notificationsKey)) == 'true';

  Future<void> clearStorage() async {
    await clearToken(); // This also clears refreshToken
    await clearUser();
  }

  Future<void> destroyAll() async {
    await clearToken();
    await clearUser();
    await clearOrderId();
  }
}
