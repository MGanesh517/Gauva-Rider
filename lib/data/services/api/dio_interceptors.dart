import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../services/local_storage_service.dart';
import '../navigation_service.dart';

class DioInterceptors extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('');
    debugPrint('🔵 ═══════════════════════════════════════════════════════');
    debugPrint('🔵 API REQUEST');
    debugPrint('🔵 Method: ${options.method}');
    debugPrint('🔵 URL: ${options.uri}');
    debugPrint('🔵 Headers: ${options.headers}');
    if (options.data != null) {
      debugPrint('🔵 Request Body: ${options.data}');
    }
    if (options.queryParameters.isNotEmpty) {
      debugPrint('🔵 Query Params: ${options.queryParameters}');
    }
    debugPrint('🔵 ═══════════════════════════════════════════════════════');
    debugPrint('');

    // Token fetch from local storage
    final token = await LocalStorageService().getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      debugPrint('🔐 Token added to headers');
    } else {
      debugPrint('⚠️ No token found in storage');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('');
    debugPrint('🟢 ═══════════════════════════════════════════════════════');
    debugPrint('🟢 API RESPONSE SUCCESS');
    debugPrint('🟢 URL: ${response.requestOptions.uri}');
    debugPrint('🟢 Status Code: ${response.statusCode}');
    debugPrint('🟢 Response Data: ${response.data}');
    debugPrint('🟢 ═══════════════════════════════════════════════════════');
    debugPrint('');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('');
    debugPrint('🔴 ═══════════════════════════════════════════════════════');
    debugPrint('🔴 API ERROR');
    debugPrint('🔴 URL: ${err.requestOptions.uri}');
    debugPrint('🔴 Method: ${err.requestOptions.method}');
    debugPrint('🔴 Error Type: ${err.type}');
    debugPrint('🔴 Status Code: ${err.response?.statusCode}');
    debugPrint('🔴 Error Message: ${err.message}');
    if (err.response?.data != null) {
      debugPrint('🔴 Response Data: ${err.response?.data}');
    }
    debugPrint('🔴 ═══════════════════════════════════════════════════════');
    debugPrint('');

    final navigatorKey = NavigationService.navigatorKey;
    final currentContext = navigatorKey.currentContext;
    final currentRoute = currentContext != null ? ModalRoute.of(currentContext)?.settings.name : null;

    if (err.response?.statusCode == 401) {
      debugPrint('🔴 401 Unauthorized - Logging out user');
      await LocalStorageService().clearToken();
      await LocalStorageService().clearStorage();

      if (currentContext != null && currentRoute != AppRoutes.login) {
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
      }
    }

    return super.onError(err, handler);
  }

}
