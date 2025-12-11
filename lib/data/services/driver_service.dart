import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/data/services/api/dio_client.dart';
import 'package:gauva_userapp/domain/interfaces/driver_service_interface.dart';

import '../../core/config/api_endpoints.dart';

class DriverService implements IDriverService {
  final DioClient dioClient;

  DriverService({required this.dioClient});
  @override
  Future<Response> getDrivers({required LatLng? location}) async => dioClient.dio.get(
      ApiEndpoints.getDrivers,
      queryParameters: {
        'lat': location!.latitude, // Spring Boot uses 'lat' and 'lng'
        'lng': location.longitude,
        'radius_m': 5000, // Optional: radius in meters
        'limit': 10, // Optional: limit results
      },
    );
}
