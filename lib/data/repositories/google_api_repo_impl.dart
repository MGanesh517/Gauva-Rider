import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/data/repositories/base_repository.dart';
import 'package:gauva_userapp/domain/interfaces/google_api_service_interface.dart';

import '../../core/errors/failure.dart';
import '../models/place_model.dart';
import '../models/waypoint.dart';
import 'interfaces/way_point_repo_interface.dart';

class GoogleAPIRepoImpl extends BaseRepository implements IGoogleAPIRepo {
  final IGoogleApiService _googleApiService;

  GoogleAPIRepoImpl(this._googleApiService);
  @override
  Future<Either<Failure, String>> getAddressFromLatLng(LatLng latLng) async => await safeApiCall(() async {
      debugPrint('📍 GET ADDRESS FROM LATLNG - Lat: ${latLng.latitude}, Lng: ${latLng.longitude}');
      final response = await _googleApiService.getAddressFromLatLng(latLng);
      debugPrint('📥 Google Geocoding API Response Status: ${response.data['status']}');
      final data = response.data;
      if (data['status'] == 'OK') {
        final List<dynamic> results = data['results'];
        if (results.isNotEmpty) {
          final firstResult = results[0];
          final formattedAddress = firstResult['formatted_address'];
          debugPrint('✅ Address found: $formattedAddress');
          return formattedAddress;
        }
      }
      debugPrint('⚠️ Address not found, returning Unknown Location');
      return 'Unknown Location';
    });

  @override
  Future<List<LatLng>> getWayPoints() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<LatLng>>> fetchWayPoints({required List<Waypoint> waypoints}) async => await safeApiCall(() async {
      debugPrint('🗺️ FETCH WAYPOINTS - Count: ${waypoints.length}');
      for (int i = 0; i < waypoints.length; i++) {
        debugPrint('   Waypoint $i: ${waypoints[i].name} - ${waypoints[i].address}');
      }
      final PolylinePoints polylinePoints0 = PolylinePoints();
      final response = await _googleApiService.fetchWayPoints(waypoints: waypoints);
      debugPrint('📥 Google Directions API Response Status: ${response.data['status']}');
      final data = response.data;
      if (data['status'] == 'OK') {
        final String encodedPloyline = data['routes'][0]['overview_polyline']['points'];
        final List<PointLatLng> polylinePoints = polylinePoints0.decodePolyline(encodedPloyline);

        final List<LatLng> polylineCoordinates = polylinePoints.map((e) => LatLng(e.latitude, e.longitude)).toList();
        debugPrint('✅ FETCH WAYPOINTS - Decoded ${polylineCoordinates.length} points');
        return polylineCoordinates;
      }
      debugPrint('⚠️ FETCH WAYPOINTS - No routes found');
      return [];
    });

  @override
  Future<Either<Failure, List<String>>> fetchDistances(List<String> destinations, LatLng origin) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PlaceModel>>> searchPlace(String place, LatLng origin) async => safeApiCall(() async {
      debugPrint('🔍 SEARCH PLACE - Query: $place, Origin: ${origin.latitude}, ${origin.longitude}');
      final response = await _googleApiService.searchPlace(place);
      debugPrint('📥 Place Autocomplete Response Status: ${response.data['status']}');
      final data = response.data;
      if (data['status'] == 'OK') {
        final List<dynamic> unformattedData = data['predictions'];
        debugPrint('📍 Found ${unformattedData.length} predictions');
        final List<PlaceModel> places = unformattedData
            .map<PlaceModel>((prediction) => PlaceModel(
                  placeId: prediction['place_id'] as String? ?? '',
                  title: prediction['structured_formatting']?['secondary_text'] as String? ?? '',
                  subtitle: prediction['description'] as String? ?? '',
                  distance: 'N/A',
                  latLng: const LatLng(0.0, 0.0),
                ))
            .toList();
        debugPrint('✅ SEARCH PLACE - Returning ${places.length} places');
        return places;
      }
      debugPrint('⚠️ SEARCH PLACE - No results found');
      return [];
    });

  @override
  Future<Either<Failure, LatLng>> getLatLngFromPlaceId(String placeId) => safeApiCall(() async {
      final response = await _googleApiService.getLatLngFromPlaceId(placeId);
      final data = response.data;
      if (data['status'] == 'OK') {
        // New API format: result object directly
        final result = data['result'];
        if (result != null) {
          final geometry = result['geometry'];
          if (geometry != null) {
            final location = geometry['location'];
            if (location != null) {
              final latitude = location['lat'];
              final longitude = location['lng'];
              if (latitude != null && longitude != null) {
                return LatLng(latitude, longitude);
              }
            }
          }
        }
        // Fallback to old format
        final List<dynamic>? results = data['results'];
        if (results != null && results.isNotEmpty) {
          final firstResult = results[0];
          final geometry = firstResult['geometry'];
          if (geometry != null) {
            final location = geometry['location'];
            if (location != null) {
              final latitude = location['lat'];
              final longitude = location['lng'];
              if (latitude != null && longitude != null) {
                return LatLng(latitude, longitude);
              }
            }
          }
        }
      }
      return const LatLng(0, 0);
    });

  @override
  Future<Either<Failure, String>> getZoneId(LatLng location) => safeApiCall(() async {
      debugPrint('🏘️ GET ZONE ID - Lat: ${location.latitude}, Lng: ${location.longitude}');
      final response = await _googleApiService.getZoneId(location);
      final data = response.data;
      if (data['zoneId'] != null) {
        final zoneId = data['zoneId'] as String;
        debugPrint('✅ Zone found: $zoneId');
        return zoneId;
      }
      debugPrint('⚠️ Zone not found for location');
      return ''; // Return empty string if zone not found
    });
}
