import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class IDriverService {
  Future<Response> getDrivers({required LatLng? location});
}
