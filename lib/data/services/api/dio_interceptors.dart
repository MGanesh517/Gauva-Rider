import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../services/local_storage_service.dart';
import '../navigation_service.dart';

class DioInterceptors extends Interceptor {
  // PERFORMANCE OPTIMIZATION: Cache token to avoid async storage reads on every request
  // Saves 20-100ms per request (after first request)
  String? _cachedToken;
  DateTime? _tokenCacheTime;
  static const _tokenCacheDuration = Duration(minutes: 5);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Cache token for 5 minutes to avoid repeated storage reads
    if (_cachedToken == null ||
        _tokenCacheTime == null ||
        DateTime.now().difference(_tokenCacheTime!) > _tokenCacheDuration) {
      _cachedToken = await LocalStorageService().getToken();
      _tokenCacheTime = DateTime.now();
    }

    if (_cachedToken != null && _cachedToken!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $_cachedToken';
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final navigatorKey = NavigationService.navigatorKey;
    final currentContext = navigatorKey.currentContext;
    final currentRoute = currentContext != null ? ModalRoute.of(currentContext)?.settings.name : null;

    if (err.response?.statusCode == 401) {
      if (kDebugMode) {
        debugPrint('🔴 401 Unauthorized - Logging out user');
      }
      
      // Clear token cache when 401 occurs
      clearTokenCache();
      
      await LocalStorageService().clearToken();
      await LocalStorageService().clearStorage();

      if (currentContext != null && currentRoute != AppRoutes.login) {
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
      }
    }

    return super.onError(err, handler);
  }

  /// Clear the cached token (called when token is cleared or refreshed)
  void clearTokenCache() {
    _cachedToken = null;
    _tokenCacheTime = null;
  }

  /// Force refresh token from storage (useful after login/token update)
  Future<void> refreshToken() async {
    _cachedToken = await LocalStorageService().getToken();
    _tokenCacheTime = DateTime.now();
  }
}
