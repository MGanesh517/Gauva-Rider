import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../core/errors/failure.dart';
import '../../domain/interfaces/ride_history_service_interface.dart';
import '../models/ride_history_response/ride_history_item.dart';
import 'base_repository.dart';
import 'interfaces/ride_history_repo_interface.dart';

class RideHistoryRepoImpl extends BaseRepository implements IRideHistoryRepo {
  final IRideHistoryService rideHistoryService;

  RideHistoryRepoImpl({required this.rideHistoryService});

  @override
  Future<Either<Failure, List<RideHistoryItem>>> getRideHistory(String? status, String? date) async =>
      await safeApiCall(() async {
        debugPrint('📜 GET RIDE HISTORY - Status: $status, Date: $date');
        final response = await rideHistoryService.getRideHistory(status, date);
        debugPrint('📥 GET RIDE HISTORY Response: ${response.data}');
        debugPrint('📥 Response Type: ${response.data.runtimeType}');

        try {
          // Handle empty array response (no rides)
          if (response.data is List && (response.data as List).isEmpty) {
            debugPrint('✅ GET RIDE HISTORY - No rides (empty array)');
            return <RideHistoryItem>[];
          }

          // Handle array with data (Spring Boot returns array directly)
          if (response.data is List) {
            debugPrint('📦 GET RIDE HISTORY - Array response with ${(response.data as List).length} items');
            final rides = (response.data as List)
                .map((item) => RideHistoryItem.fromJson(item as Map<String, dynamic>))
                .toList();
            debugPrint('✅ GET RIDE HISTORY - Parsed ${rides.length} rides successfully');
            return rides;
          }

          // Handle unexpected format
          debugPrint('⚠️ GET RIDE HISTORY - Unexpected response format');
          return <RideHistoryItem>[];
        } catch (e, stackTrace) {
          debugPrint('🔴 GET RIDE HISTORY - Parsing error: $e');
          debugPrint('🔴 Stack trace: $stackTrace');
          debugPrint('🔴 Raw response data: ${response.data}');
          return <RideHistoryItem>[];
        }
      });
}
