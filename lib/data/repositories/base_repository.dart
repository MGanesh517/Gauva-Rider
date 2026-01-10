import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/errors/api_error_handler.dart';
import '../../core/errors/failure.dart';
import '../../generated/l10n.dart';

abstract class BaseRepository {
  // Handle API calls and maps response to [Either].
  // PERFORMANCE OPTIMIZED: Removed connectivity check (saves 200-500ms per request)
  // DioException.connectionError already handles no internet cases
  Future<Either<Failure, T>> safeApiCall<T>(
    Future<T> Function() apiCall, {
    bool verbose = false, // Optional verbose logging for debugging
  }) async {
    try {
      if (kDebugMode && verbose) {
        debugPrint('🔷 API CALL START');
      }

      // Let Dio handle connection errors - no pre-check needed
      // This removes 200-500ms overhead from connectivity checks
      final result = await apiCall();

      if (kDebugMode && verbose) {
        debugPrint('🟢 API call successful');
      }

      return Right(result);
    } on DioException catch (dioError) {
      // DioException.connectionError already covers no internet scenarios
      if (kDebugMode) {
        debugPrint('🔴 DIO EXCEPTION: ${dioError.type} - ${dioError.message}');
        if (dioError.response != null) {
          debugPrint('🔴 Status: ${dioError.response?.statusCode}');
        }
      }
      final failure = ApiErrorHandler.handleDioError(error: dioError);
      return Left(failure);
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        debugPrint('🔴 TIMEOUT EXCEPTION: $e');
      }
      return Left(
        Failure(message: AppLocalizations().request_timed_out_please_try_again),
      );
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('🔴 UNEXPECTED ERROR: $error');
        debugPrint('🔴 Stack Trace: $stackTrace');
      }
      return Left(Failure(message: error.toString()));
    }
  }
}
