import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Performance monitoring interceptor to track API response times
/// Only active in debug mode
class TimingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['startTime'] = DateTime.now().millisecondsSinceEpoch;
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final startTime = response.requestOptions.extra['startTime'] as int?;
    if (startTime != null) {
      final duration = DateTime.now().millisecondsSinceEpoch - startTime;
      final method = response.requestOptions.method;
      final path = response.requestOptions.path;
      
      if (kDebugMode) {
        // Color code based on performance
        if (duration < 500) {
          debugPrint('⏱️ [$method] $path: ${duration}ms ✅');
        } else if (duration < 1500) {
          debugPrint('⏱️ [$method] $path: ${duration}ms ⚠️');
        } else {
          debugPrint('⏱️ [$method] $path: ${duration}ms 🔴 SLOW');
        }
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final startTime = err.requestOptions.extra['startTime'] as int?;
    if (startTime != null) {
      final duration = DateTime.now().millisecondsSinceEpoch - startTime;
      final method = err.requestOptions.method;
      final path = err.requestOptions.path;
      
      if (kDebugMode) {
        debugPrint('⏱️ [$method] $path: FAILED after ${duration}ms ❌');
      }
    }
    handler.next(err);
  }
}

