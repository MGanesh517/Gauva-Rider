import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/data/services/api/dio_client.dart';
import 'package:gauva_userapp/domain/interfaces/driver_service_interface.dart';

import '../../core/config/api_endpoints.dart';

class DriverService implements IDriverService {
  final DioClient dioClient;

  DriverService({required this.dioClient});
  @override
  Future<Response> getDrivers({
    required LatLng? location,
    int radiusMeters = 5000,
    int limit = 20,
    String? serviceType,
  }) async {
    final queryParams = <String, dynamic>{
      'lat': location!.latitude,
      'lng': location.longitude,
      'radius_m': radiusMeters,
      'limit': limit,
    };
    
    // Add serviceType filter if provided
    if (serviceType != null && serviceType.isNotEmpty) {
      queryParams['serviceType'] = serviceType;
    }
    
    return dioClient.dio.get(
      ApiEndpoints.getDrivers,
      queryParameters: queryParams,
    );
  }
}
