import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/interfaces/cancel_ride_service_interface.dart';
import 'api/dio_client.dart';

class CancelRideService implements ICancelRideService {
  final DioClient dioClient;

  CancelRideService({required this.dioClient});

  @override
  Future<Response> cancelRide({required int? orderId}) async {
    // Spring Boot: POST /api/v1/ride/{rideId}/decline
    // Authorization: Bearer {token} (handled by DioInterceptors)
    final endpoint = '/api/v1/ride/$orderId/decline';
    
    debugPrint('');
    debugPrint('🚫 ═══════════════════════════════════════════════════════');
    debugPrint('🚫 CANCEL RIDE API CALL');
    debugPrint('🚫 ═══════════════════════════════════════════════════════');
    debugPrint('📤 Endpoint: $endpoint');
    debugPrint('📤 Method: POST');
    debugPrint('📤 Order ID: $orderId');
    debugPrint('🔑 Authorization: Bearer token (from DioInterceptors)');
    
    final response = await dioClient.dio.post(endpoint);
    
    debugPrint('📥 Response Status: ${response.statusCode}');
    debugPrint('📥 Response Data: ${response.data}');
    debugPrint('🚫 ═══════════════════════════════════════════════════════');
    debugPrint('');
    
    return response;
  }
}
