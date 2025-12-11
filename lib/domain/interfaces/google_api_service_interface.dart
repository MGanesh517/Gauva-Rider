import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/waypoint.dart';

abstract class IGoogleApiService {
  Future<Response> fetchWayPoints({required List<Waypoint> waypoints});
  Future<Response> getAddressFromLatLng(LatLng latLng);
  Future<Response> getLatLngFromPlaceId(String placeId);
  Future<Response> searchPlace(String place);
  Future<Response> getPlaceDetails(String placeId);
  Future<Response> fetchDistances(List<String> placeIds, LatLng origin);
  Future<Response> getZoneId(LatLng location);
}
