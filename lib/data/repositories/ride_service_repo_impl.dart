import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:gauva_userapp/core/errors/failure.dart';
import 'package:gauva_userapp/data/models/common_response.dart';
import 'package:gauva_userapp/data/repositories/base_repository.dart';
import 'package:gauva_userapp/domain/interfaces/ride_service_interface.dart';

import '../../core/state/rider_service_state.dart';
import '../models/ride_service_response.dart';
import 'interfaces/ride_service_repo_interface.dart';

class RiderServiceRepoImpl extends BaseRepository implements IRideServicesRepo {
  final IRideServicesService _rideServicesService;

  RiderServiceRepoImpl(this._rideServicesService);
  @override
  Future<Either<Failure, RideServiceResponse>> getRideServices({required RiderServiceState riderServiceFilter}) async {
    final data = await safeApiCall(() async {
      debugPrint('🚕 GET RIDE SERVICES - Filter: ${riderServiceFilter.toMap()}');
      final response = await _rideServicesService.getRideServices(riderServiceState: riderServiceFilter);
      debugPrint('📥 GET RIDE SERVICES Response: ${response.data}');
      try {
        dynamic responseData = response.data;

        // If response is a direct array (new fare estimate API format)
        if (responseData is List) {
          debugPrint('📋 Response is a List (array format) - transforming...');
          // Transform array items: each item has fare info + nested vehicle object
          final List<Map<String, dynamic>> transformedServices = responseData.map<Map<String, dynamic>>((item) {
            final Map<String, dynamic> itemMap = item is Map ? Map<String, dynamic>.from(item) : <String, dynamic>{};
            final Map<String, dynamic> serviceMap = Map<String, dynamic>.from(itemMap);

            // Extract vehicle info and merge with fare info
            if (itemMap['vehicle'] != null && itemMap['vehicle'] is Map) {
              final vehicle = itemMap['vehicle'] as Map<String, dynamic>;
              // Merge vehicle fields into service
              serviceMap.addAll(<String, dynamic>{
                'serviceId': vehicle['serviceId'] ?? serviceMap['serviceId'],
                'name': vehicle['name'] ?? serviceMap['name'],
                'displayName': vehicle['displayName'] ?? serviceMap['displayName'],
                'icon': vehicle['icon'] ?? serviceMap['icon'],
                'iconUrl': vehicle['iconUrl'] ?? serviceMap['iconUrl'],
                'capacity': vehicle['capacity'] ?? serviceMap['capacity'],
                'vehicleType': vehicle['vehicleType'] ?? serviceMap['vehicleType'],
                'category': vehicle['category'] ?? serviceMap['category'],
                'estimatedArrival': vehicle['estimatedArrival'] ?? serviceMap['estimatedArrival'],
                'description': vehicle['description'] ?? serviceMap['description'],
              });

              // Map fare fields
              serviceMap['baseFare'] = itemMap['baseFare'] ?? serviceMap['baseFare'];
              serviceMap['perKmRate'] = itemMap['perKmRate'] ?? serviceMap['perKmRate'];
              serviceMap['perMinRate'] = itemMap['timeRatePerMin'] ?? serviceMap['perMinRate'];
              serviceMap['totalFare'] = itemMap['finalTotal'] ?? itemMap['total'] ?? serviceMap['totalFare'];
              serviceMap['serviceFare'] = itemMap['total'] ?? serviceMap['serviceFare'];
              serviceMap['costAfterCoupon'] = itemMap['finalTotal'] ?? serviceMap['costAfterCoupon'];
              serviceMap['cancellationFee'] = itemMap['cancellationFee'] ?? serviceMap['cancellationFee'];
              serviceMap['isCouponApplicable'] = itemMap['appliedCoupon'] != null;

              // Remove nested vehicle object
              serviceMap.remove('vehicle');
            }

            return serviceMap;
          }).toList();

          // Transform to expected format
          responseData = <String, dynamic>{'services': transformedServices, 'total': transformedServices.length};
          debugPrint('✅ Transformed ${transformedServices.length} services');
        }

        // If response has services at root level
        if (responseData is Map && responseData['services'] == null && responseData['data'] == null) {
          // Check if it's an array wrapped in response
          if (responseData.containsKey('data') && responseData['data'] is List) {
            responseData = <String, dynamic>{
              'services': responseData['data'],
              'total': (responseData['data'] as List).length,
            };
          }
        }

        final result = RideServiceResponse.fromJson(responseData);
        debugPrint('✅ GET RIDE SERVICES - Parsed successfully');
        debugPrint('✅ Services count: ${result.data?.servicesList?.length ?? 0}');
        return result;
      } catch (e, stackTrace) {
        debugPrint('🔴 GET RIDE SERVICES - Parsing error: $e');
        debugPrint('🔴 Stack trace: $stackTrace');
        debugPrint('🔴 Raw response data: ${response.data}');
        rethrow;
      }
    });
    data.fold((l) => l, (r) => r);
    return data;
  }

  @override
  Future<Either<Failure, RideServiceResponse>> getAvailableServicesForRoute({
    required RiderServiceState riderServiceFilter,
  }) async {
    return await safeApiCall(() async {
      debugPrint('🚕 GET AVAILABLE SERVICES FOR ROUTE');
      final response = await _rideServicesService.getAvailableServicesForRoute(riderServiceState: riderServiceFilter);
      debugPrint('📥 GET AVAILABLE SERVICES Response: ${response.data}');
      if (response.data is Map && response.data['services'] != null) {
        // ensure fields are correct if needed, but assuming API matches
      }
      return RideServiceResponse.fromJson(response.data);
    });
  }

  @override
  Future<Either<Failure, RideServiceResponse>> getServicesHome() async => await safeApiCall(() async {
    debugPrint('🏠 GET SERVICES HOME');
    final response = await _rideServicesService.getServicesHome();
    debugPrint('📥 GET SERVICES HOME Response: ${response.data}');
    try {
      // Handle new API format: {total: X, services: [...]}
      // Filter only active services and sort by displayOrder
      if (response.data is Map && response.data['services'] != null) {
        final services = (response.data['services'] as List).where((s) => s['isActive'] == true).toList()
          ..sort((a, b) {
            final orderA = a['displayOrder'] ?? 999;
            final orderB = b['displayOrder'] ?? 999;
            return (orderA as num).compareTo(orderB as num);
          });
        response.data['services'] = services;
        debugPrint('✅ Filtered and sorted ${services.length} active services');
      }
      final result = RideServiceResponse.fromJson(response.data);
      debugPrint('✅ GET SERVICES HOME - Parsed successfully');
      debugPrint('✅ Total services: ${result.data?.servicesList?.length ?? 0}');
      return result;
    } catch (e, stackTrace) {
      debugPrint('🔴 GET SERVICES HOME - Parsing error: $e');
      debugPrint('🔴 Stack trace: $stackTrace');
      debugPrint('🔴 Raw response: ${response.data}');
      rethrow;
    }
  });

  @override
  Future<Either<Failure, CommonResponse>> applyCoupon({required String? coupon}) async => safeApiCall(() async {
    final response = await _rideServicesService.applyCoupon(coupon: coupon);
    return CommonResponse.fromMap(response.data);
  });
}
