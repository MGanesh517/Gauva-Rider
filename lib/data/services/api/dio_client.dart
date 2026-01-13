import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../../core/config/environment.dart';
import 'dio_interceptors.dart';

// Top-level function for compute
@pragma('vm:entry-point')
_parseAndDecode(String response) {
  return jsonDecode(response);
}

@pragma('vm:entry-point')
_parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class DioClient {
  final Dio dio;

  DioClient({String? baseUrl})
    : dio = Dio(
        BaseOptions(
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          connectTimeout: const Duration(seconds: 10),
          baseUrl: baseUrl ?? Environment.apiUrl,
          contentType: 'application/json',
          headers: {'Accept': '*/*', 'Content-Type': 'application/json', 'Connection': 'keep-alive'},
          followRedirects: true,
          maxRedirects: 3,
          validateStatus: (status) => status! < 500,
        ),
      ) {
    // Configure background transformation
    if (dio.transformer is DefaultTransformer) {
      (dio.transformer as DefaultTransformer).jsonDecodeCallback = _parseJson;
    }

    // Add interceptors in order of execution
    dio.interceptors.add(DioInterceptors());

    // PERFORMANCE OPTIMIZATION: Disabled logging interceptors for maximum speed
    // PrettyDioLogger and TimingInterceptor add 50-200ms overhead per request
    // Uncomment only when debugging:
    // if (kDebugMode) {
    //   dio.interceptors.add(PrettyDioLogger(requestHeader: false, requestBody: false, responseBody: false, compact: true));
    //   dio.interceptors.add(TimingInterceptor());
    // }
  }
}
