import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../core/errors/failure.dart';
import '../../domain/interfaces/ride_history_service_interface.dart';
import '../models/ride_history_response/ride_history_model.dart';
import 'base_repository.dart';
import 'interfaces/ride_history_repo_interface.dart';

class RideHistoryRepoImpl extends BaseRepository implements IRideHistoryRepo {
  final IRideHistoryService rideHistoryService;

  RideHistoryRepoImpl({required this.rideHistoryService});

  @override
  Future<Either<Failure, RideHistoryModel>> getRideHistory(String? status, String? date) async => await safeApiCall(()async{
      debugPrint('📜 GET RIDE HISTORY - Status: $status, Date: $date');
      final response = await rideHistoryService.getRideHistory(status, date);
      debugPrint('📥 GET RIDE HISTORY Response: ${response.data}');
      debugPrint('📥 Response Type: ${response.data.runtimeType}');
      
      try {
        // Handle empty array response (no rides)
        if (response.data is List && (response.data as List).isEmpty) {
          debugPrint('✅ GET RIDE HISTORY - No rides (empty array)');
          return RideHistoryModel(
            success: true,
            message: 'No rides found',
            data: Data(orders: []),
          );
        }
        
        // Handle array with data (Spring Boot returns array directly)
        if (response.data is List) {
          debugPrint('📦 GET RIDE HISTORY - Array response with ${(response.data as List).length} items');
          // Wrap array response in expected format
          final wrappedData = {
            'success': true,
            'message': 'Rides loaded',
            'data': {
              'orders': response.data,
            }
          };
          final result = RideHistoryModel.fromJson(wrappedData);
          debugPrint('✅ GET RIDE HISTORY - Parsed from array successfully');
          debugPrint('✅ Orders count: ${result.data?.orders?.length ?? 0}');
          return result;
        }
        
        // Handle normal object response
        final result = RideHistoryModel.fromJson(response.data);
        debugPrint('✅ GET RIDE HISTORY - Parsed successfully');
        debugPrint('✅ Orders count: ${result.data?.orders?.length ?? 0}');
        return result;
      } catch (e, stackTrace) {
        debugPrint('🔴 GET RIDE HISTORY - Parsing error: $e');
        debugPrint('🔴 Stack trace: $stackTrace');
        debugPrint('🔴 Raw response data: ${response.data}');
        // Return empty history model on error
        return RideHistoryModel(
          success: false,
          message: 'Error loading rides',
          data: Data(orders: []),
        );
      }

    });}