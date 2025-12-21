import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../core/errors/failure.dart';
import '../../domain/interfaces/intercity_service_interface.dart';
import '../models/intercity_service_type.dart';
import '../models/intercity_search_response.dart';
import 'base_repository.dart';
import 'interfaces/intercity_service_repo_interface.dart';
import '../models/intercity_trip_model.dart';

class IntercityServiceRepoImpl extends BaseRepository implements IIntercityServiceRepo {
  final IIntercityService _intercityService;

  IntercityServiceRepoImpl(this._intercityService);

  @override
  Future<Either<Failure, List<IntercityServiceType>>> getIntercityServiceTypes() async {
    return await safeApiCall(() async {
      debugPrint('🚕 GET INTERCITY SERVICE TYPES');
      final response = await _intercityService.getIntercityServiceTypes();
      debugPrint('📥 GET INTERCITY SERVICE TYPES Response: ${response.data}');

      try {
        dynamic responseData = response.data;

        // Handle array response
        List<dynamic> serviceList;
        if (responseData is List) {
          serviceList = responseData;
        } else if (responseData is Map && responseData['data'] is List) {
          serviceList = responseData['data'];
        } else {
          serviceList = [];
        }

        // Filter only active services and sort by displayOrder
        final filteredServices = serviceList.where((s) => s['isActive'] == true).toList()
          ..sort((a, b) {
            final orderA = a['displayOrder'] ?? 999;
            final orderB = b['displayOrder'] ?? 999;
            return (orderA as num).compareTo(orderB as num);
          });

        final result = filteredServices.map((json) => IntercityServiceType.fromJson(json)).toList();

        debugPrint('✅ GET INTERCITY SERVICE TYPES - Parsed successfully');
        debugPrint('✅ Total services: ${result.length}');
        return result;
      } catch (e, stackTrace) {
        debugPrint('🔴 GET INTERCITY SERVICE TYPES - Parsing error: $e');
        debugPrint('🔴 Stack trace: $stackTrace');
        debugPrint('🔴 Raw response: ${response.data}');
        rethrow;
      }
    });
  }

  @override
  Future<Either<Failure, IntercitySearchResponse>> searchIntercity({
    required int routeId,
    required double pickupLatitude,
    required double pickupLongitude,
    required double dropLatitude,
    required double dropLongitude,
    String? vehicleType,
    required String preferredDeparture,
    int seatsNeeded = 0,
    double searchRadiusKm = 0,
  }) async {
    return await safeApiCall(() async {
      debugPrint('🔍 SEARCH INTERCITY');
      debugPrint('RouteId: $routeId, VehicleType: $vehicleType');
      final response = await _intercityService.searchIntercity(
        routeId: routeId,
        pickupLatitude: pickupLatitude,
        pickupLongitude: pickupLongitude,
        dropLatitude: dropLatitude,
        dropLongitude: dropLongitude,
        vehicleType: vehicleType,
        preferredDeparture: preferredDeparture,
        seatsNeeded: seatsNeeded,
        searchRadiusKm: searchRadiusKm,
      );
      debugPrint('📥 SEARCH INTERCITY Response: ${response.data}');

      try {
        final result = IntercitySearchResponse.fromJson(response.data);
        debugPrint('✅ SEARCH INTERCITY - Parsed successfully');
        debugPrint('✅ Vehicle options: ${result.vehicleOptions?.length ?? 0}');
        return result;
      } catch (e, stackTrace) {
        debugPrint('🔴 SEARCH INTERCITY - Parsing error: $e');
        debugPrint('🔴 Stack trace: $stackTrace');
        debugPrint('🔴 Raw response: ${response.data}');
        rethrow;
      }
    });
  }

  @override
  Future<Either<Failure, List<IntercityTripModel>>> getIntercityDrivers({
    required String vehicleType,
    required int seatsNeeded,
    double? pickupLatitude,
    double? pickupLongitude,
    int? routeId,
  }) async {
    return await safeApiCall(() async {
      debugPrint('🚕 GET INTERCITY DRIVERS');
      final response = await _intercityService.getIntercityDrivers(
        vehicleType: vehicleType,
        seatsNeeded: seatsNeeded,
        pickupLatitude: pickupLatitude,
        pickupLongitude: pickupLongitude,
        routeId: routeId,
      );
      debugPrint('📥 GET INTERCITY DRIVERS Response: ${response.data}');

      try {
        final List<dynamic> data = response.data is List ? response.data : (response.data['data'] ?? []);
        final result = data.map((json) => IntercityTripModel.fromJson(json)).toList();
        debugPrint('✅ GET INTERCITY DRIVERS - Parsed ${result.length} drivers');
        return result;
      } catch (e) {
        debugPrint('🔴 GET INTERCITY DRIVERS - Parsing error: $e');
        rethrow;
      }
    });
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> createIntercityBooking({
    required String vehicleType,
    required String bookingType,
    required int seatsToBook,
    int? tripId,
    int? routeId,
    required String pickupAddress,
    required double pickupLatitude,
    required double pickupLongitude,
    required String dropAddress,
    required double dropLatitude,
    required double dropLongitude,
    required String paymentMethod,
    required String fullName,
    required String email,
    String? contactPhone,
    String? specialInstructions,
  }) async {
    return await safeApiCall(() async {
      debugPrint('📝 CREATE INTERCITY BOOKING');
      final response = await _intercityService.createIntercityBooking(
        vehicleType: vehicleType,
        bookingType: bookingType,
        seatsToBook: seatsToBook,
        tripId: tripId,
        routeId: routeId,
        pickupAddress: pickupAddress,
        pickupLatitude: pickupLatitude,
        pickupLongitude: pickupLongitude,
        dropAddress: dropAddress,
        dropLatitude: dropLatitude,
        dropLongitude: dropLongitude,
        paymentMethod: paymentMethod,
        fullName: fullName,
        email: email,
        contactPhone: contactPhone,
        specialInstructions: specialInstructions,
      );
      debugPrint('📥 CREATE INTERCITY BOOKING Response: ${response.data}');

      return response.data is Map<String, dynamic> ? response.data as Map<String, dynamic> : {'data': response.data};
    });
  }
}
