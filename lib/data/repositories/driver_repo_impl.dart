import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/core/errors/failure.dart';
import 'package:gauva_userapp/data/models/driver_response/driver_response.dart';
import 'package:gauva_userapp/data/repositories/base_repository.dart';
import 'package:gauva_userapp/data/repositories/interfaces/driver_repo_interface.dart';
import 'package:gauva_userapp/domain/interfaces/driver_service_interface.dart';

class DriverRepoImpl extends BaseRepository implements IDriverRepo {
  final IDriverService driverService;

  DriverRepoImpl({required this.driverService});
  @override
  Future<Either<Failure, DriverResponse>> getDrivers({
    required LatLng? location,
    int radiusMeters = 5000,
    int limit = 20,
    String? serviceType,
  }) async => await safeApiCall(() async {
    debugPrint('🚗 GET DRIVERS - Location: ${location?.latitude}, ${location?.longitude}, ServiceType: $serviceType');
    final response = await driverService.getDrivers(
      location: location,
      radiusMeters: radiusMeters,
      limit: limit,
      serviceType: serviceType,
    );
    debugPrint('📥 GET DRIVERS Response: ${response.data}');
    try {
      // Handle both array response and object response
      dynamic responseData = response.data;
      DriverResponse result;

      if (responseData is List) {
        // API returns array directly
        result = DriverResponse.fromMap({'data': responseData} as Map<String, dynamic>);
      } else if (responseData is Map) {
        // API returns object with data field
        result = DriverResponse.fromMap(responseData as Map<String, dynamic>);
      } else {
        throw Exception('Unexpected response format');
      }

      debugPrint('✅ GET DRIVERS - Parsed successfully');
      debugPrint('✅ Drivers count: ${result.data?.length ?? 0}');
      return result;
    } catch (e, stackTrace) {
      debugPrint('🔴 GET DRIVERS - Parsing error: $e');
      debugPrint('🔴 Stack trace: $stackTrace');
      rethrow;
    }
  });
}
