import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../core/config/environment.dart';
import 'dio_interceptors.dart';
import 'timing_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient({String? baseUrl})
    : dio = Dio(
        BaseOptions(
          sendTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          connectTimeout: const Duration(seconds: 30), // Reduced from 60s for faster failure detection
          baseUrl: baseUrl ?? Environment.apiUrl,
          contentType: 'application/json',
          headers: {
            'Accept': '*/*',
            'Content-Type': 'application/json',
            'Connection': 'keep-alive', // Keep connections alive for better performance
          },
          followRedirects: true,
          maxRedirects: 3,
        ),
      ) {
    // Add interceptors in order of execution
    dio.interceptors.add(DioInterceptors());
    
    // Add timing interceptor for performance monitoring (debug only)
    if (kDebugMode) {
      dio.interceptors.add(TimingInterceptor());
    }
    
    // Only enable verbose logging in debug mode (saves 50-100ms per request in production)
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: false,
        compact: true, // Use compact mode for better performance
      ));
    }
  }
}
