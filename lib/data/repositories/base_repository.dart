import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/errors/api_error_handler.dart';
import '../../core/errors/failure.dart';
import '../../generated/l10n.dart';

abstract class BaseRepository {
  // Handle API calls and maps response to [Either].
  Future<Either<Failure, T>> safeApiCall<T>(
    Future<T> Function() apiCall,
  ) async {
    try {
      debugPrint('');
      debugPrint('🔷 ═══════════════════════════════════════════════════════');
      debugPrint('🔷 SAFE API CALL START');
      debugPrint('🔷 ═══════════════════════════════════════════════════════');
      
      // Step 1: Check internet connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      final hasInternet =
          connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.ethernet);

      if (!hasInternet) {
        debugPrint('🔴 No Internet Connection');
        debugPrint('🔷 ═══════════════════════════════════════════════════════');
        debugPrint('');
        return Left(
          Failure(message: AppLocalizations().no_internet_connection),
        );
      }

      debugPrint('✅ Internet connection available');
      debugPrint('🔷 Executing API call...');

      // Step 2: Perform the API call
      final result = await apiCall();

      debugPrint('🟢 API call successful');
      debugPrint('🟢 Result Type: ${result.runtimeType}');
      debugPrint('🔷 ═══════════════════════════════════════════════════════');
      debugPrint('');

      return Right(result);
    } on DioException catch (dioError) {
      debugPrint('');
      debugPrint('🔴 ═══════════════════════════════════════════════════════');
      debugPrint('🔴 DIO EXCEPTION CAUGHT');
      debugPrint('🔴 Error Type: ${dioError.type}');
      debugPrint('🔴 Status Code: ${dioError.response?.statusCode}');
      debugPrint('🔴 Error Message: ${dioError.message}');
      debugPrint('🔴 Response Data: ${dioError.response?.data}');
      debugPrint('🔴 ═══════════════════════════════════════════════════════');
      debugPrint('');
      final failure = ApiErrorHandler.handleDioError(error: dioError);
      return Left(failure);
    } on TimeoutException catch (e) {
      debugPrint('');
      debugPrint('🔴 ═══════════════════════════════════════════════════════');
      debugPrint('🔴 TIMEOUT EXCEPTION');
      debugPrint('🔴 Error: $e');
      debugPrint('🔴 ═══════════════════════════════════════════════════════');
      debugPrint('');
      return Left(
        Failure(message: AppLocalizations().request_timed_out_please_try_again),
      );
    } catch (error, stackTrace) {
      debugPrint('');
      debugPrint('🔴 ═══════════════════════════════════════════════════════');
      debugPrint('🔴 UNEXPECTED ERROR');
      debugPrint('🔴 Error: $error');
      debugPrint('🔴 Stack Trace: $stackTrace');
      debugPrint('🔴 ═══════════════════════════════════════════════════════');
      debugPrint('');
      return Left(Failure(message: error.toString()));
    }
  }
}
