import 'package:dio/dio.dart';
import 'package:gauva_userapp/domain/interfaces/order_service_interface.dart';

import 'package:flutter/foundation.dart';
import '../../core/config/api_endpoints.dart';

import 'api/dio_client.dart';
import 'local_storage_service.dart';

class OrderService implements IOrderService {
  final DioClient dioClient;
  OrderService({required this.dioClient});

  /// Maps numeric service IDs to their string equivalents
  /// 1 = BIKE, 2 = CAR, 3 = AUTO, 4 = PREMIUM
  String _getServiceTypeString(dynamic serviceType) {
    // If already a string, return as-is
    if (serviceType is String) {
      return serviceType;
    }

    // If numeric, map to string
    if (serviceType is int || serviceType is num) {
      switch (serviceType) {
        case 1:
          return 'BIKE';
        case 2:
          return 'CAR';
        case 3:
          return 'AUTO';
        case 4:
          return 'PREMIUM';
        default:
          return 'BIKE'; // Default fallback
      }
    }

    // Fallback
    return 'BIKE';
  }

  @override
  Future<Response> createOrder({required Map<String, dynamic> data}) async {
    final userId = await LocalStorageService().getUserId();
    // Spring Boot: /api/v1/ride/request expects RideRequest
    // Map from booking sheet format to API format
    final pickupLocation = data['pickup_location'] as List<dynamic>? ?? [];
    final dropLocation = data['drop_location'] as List<dynamic>? ?? [];
    final waitLocation = data['wait_location'] as List<dynamic>? ?? [];

    // Get service type and ensure it's a string
    final serviceTypeRaw = data['service_id'] ?? data['serviceId'];
    final serviceTypeString = _getServiceTypeString(serviceTypeRaw);

    final rideRequest = {
      'pickupArea': data['pickup_area'] ?? data['pickupArea'] ?? data['pickup_address'] ?? '',
      'destinationArea': data['destination_area'] ?? data['destinationArea'] ?? data['drop_address'] ?? '',
      'pickupLatitude': pickupLocation.isNotEmpty
          ? pickupLocation[0]
          : (data['pickup_latitude'] ?? data['pickupLatitude'] ?? 0),
      'pickupLongitude': pickupLocation.length > 1
          ? pickupLocation[1]
          : (data['pickup_longitude'] ?? data['pickupLongitude'] ?? 0),
      'destinationLatitude': dropLocation.isNotEmpty
          ? dropLocation[0]
          : (data['destination_latitude'] ?? data['destinationLatitude'] ?? 0),
      'destinationLongitude': dropLocation.length > 1
          ? dropLocation[1]
          : (data['destination_longitude'] ?? data['destinationLongitude'] ?? 0),
      'serviceType': serviceTypeString,
      'couponCode': data['coupon_code'] ?? data['couponCode'] ?? '',
      'serviceOptionIds': data['service_option_ids'] ?? data['serviceOptionIds'] ?? [],
      'estimatedFare': data['estimatedFare'] ?? 0,
      'distanceKm': data['distanceKm'] ?? 0,
      'durationMin': data['durationMin'] ?? 0,
      if (waitLocation.isNotEmpty) ...{
        'waitLatitude': waitLocation[0],
        'waitLongitude': waitLocation.length > 1 ? waitLocation[1] : 0,
        'waitAddress': data['wait_address'] ?? '',
      },
      'userId': userId,
    };
    final response = await dioClient.dio.post(ApiEndpoints.createOrder, data: rideRequest);
    return response;
  }

  @override
  Future<Response> orderDetails({required int orderId}) async =>
      await dioClient.dio.get('${ApiEndpoints.orderDetails}/$orderId');

  @override
  Future<Response> checkActiveTrip() async {
    int userId = await LocalStorageService().getUserId();
    final token = await LocalStorageService().getToken();

    debugPrint('🔍 checkActiveTrip: Initial userId: $userId, token exists: ${token != null}');

    // Self-healing: If userId is 0 but we have a token, try to fetch the profile
    if (userId == 0 && token != null && token.isNotEmpty) {
      debugPrint('⚠️ checkActiveTrip: User ID is 0, attempting to fetch profile for self-healing...');
      try {
        final profileResponse = await dioClient.dio.get(
          ApiEndpoints.riderDetails,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        if (profileResponse.statusCode == 200 && profileResponse.data != null) {
          debugPrint('✅ checkActiveTrip: Profile fetched successfully for self-healing');
          final responseData = profileResponse.data;

          // Handle response wrapper if present
          final userData = (responseData is Map<String, dynamic> && responseData.containsKey('data'))
              ? responseData['data']
              : responseData;

          if (userData is Map<String, dynamic>) {
            debugPrint('💾 checkActiveTrip: Saving user data to local storage...');
            await LocalStorageService().saveUser(user: userData);

            // Re-fetch id
            userId = await LocalStorageService().getUserId();
            debugPrint('✅ checkActiveTrip: Self-healing complete. New userId: $userId');
          } else {
            debugPrint('❌ checkActiveTrip: Unexpected user data format: ${userData.runtimeType}');
          }
        } else {
          debugPrint('❌ checkActiveTrip: Failed to fetch profile. Status: ${profileResponse.statusCode}');
        }
      } catch (e) {
        debugPrint('❌ checkActiveTrip: Error fetching profile for self-healing: $e');
      }
    }

    // Spring Boot: /api/v1/user/{userId}/rides/current
    final url = '/api/v1/user/$userId/rides/current';
    debugPrint('🚀 checkActiveTrip: Requesting active trip from: $url');

    final response = await dioClient.dio.get(url, options: Options(headers: {'Authorization': 'Bearer $token'}));
    return response;
  }

  @override
  Future<Response> getIntercityRideHistory() async {
    final response = await dioClient.dio.get(ApiEndpoints.intercityRideHistory);
    return response;
  }
}
