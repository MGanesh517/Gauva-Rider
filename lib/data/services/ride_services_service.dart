import 'package:dio/dio.dart';

import '../../core/config/api_endpoints.dart';
import '../../core/state/rider_service_state.dart';
import '../../domain/interfaces/ride_service_interface.dart';
import 'api/dio_client.dart';
import 'local_storage_service.dart';

class RideServicesService implements IRideServicesService {
  final DioClient dioClient;

  RideServicesService({required this.dioClient});
  @override
  Future<Response> getRideServices(
      {required RiderServiceState riderServiceState}) async {
    // Spring Boot: /api/v1/services/fare-estimates expects FareEstimateRequest (POST)
    final userId = await LocalStorageService().getUserId();
    
    final fareRequest = {
      'distanceKm': riderServiceState.distanceKm ?? 0.0,
      'durationMin': riderServiceState.durationMin ?? 0,
      'pickupLat': riderServiceState.pickupLocation.isNotEmpty ? riderServiceState.pickupLocation[0] : 0.0,
      'pickupLng': riderServiceState.pickupLocation.length > 1 ? riderServiceState.pickupLocation[1] : 0.0,
      'dropLat': riderServiceState.dropLocation.isNotEmpty ? riderServiceState.dropLocation[0] : 0.0,
      'dropLng': riderServiceState.dropLocation.length > 1 ? riderServiceState.dropLocation[1] : 0.0,
      'pickupZoneReadableId': riderServiceState.pickupZoneReadableId ?? '',
      'dropZoneReadableId': riderServiceState.dropZoneReadableId ?? '',
      'couponCode': riderServiceState.couponCode ?? '',
      'userId': userId,
    };
    return dioClient.dio.post(ApiEndpoints.rideServices, data: fareRequest);
  }

  @override
  Future<Response> getServicesHome() => dioClient.dio.get(ApiEndpoints.servicesHome);

  @override
  Future<Response> applyCoupon({String? coupon}) async {
    // Spring Boot: /api/promotions/coupons/apply expects ApplyCouponRequest (POST)
    final userId = await LocalStorageService().getUserId();
    return await dioClient.dio.post(
      ApiEndpoints.applyCoupon, 
      data: {
        'code': coupon ?? '',
        'userId': userId,
        'baseFare': 0, // This should be the actual fare amount
      }
    );
  }
}
