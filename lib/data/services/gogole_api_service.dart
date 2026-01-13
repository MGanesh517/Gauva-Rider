import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/core/config/api_endpoints.dart';
import 'package:gauva_userapp/core/config/environment.dart';
import 'package:gauva_userapp/data/services/api/dio_client.dart';
import 'package:gauva_userapp/data/services/local_storage_service.dart';

import '../../domain/interfaces/google_api_service_interface.dart';
import '../models/waypoint.dart';

class GoogleApiService implements IGoogleApiService {
  final DioClient dioClient;
  GoogleApiService({required this.dioClient});
  
  // Get Google Maps API key from .env
  String get apiKey {
    final key = dotenv.env['GOOGLE_MAPS_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('GOOGLE_MAPS_API_KEY is not set in .env file');
    }
    return key;
  }
  
  // Get base URL from .env
  String get baseUrl => Environment.baseUrl;

  @override
  Future<Response> fetchWayPoints({required List<Waypoint> waypoints}) async {
    final String languageCode = await LocalStorageService()
        .getSelectedLanguage();

    final LatLng origin = waypoints.first.location;
    final LatLng destination = waypoints.last.location;
    final List<LatLng> stopPoints = waypoints
        .sublist(1, waypoints.length - 1)
        .map((e) => e.location)
        .toList();
    
    return dioClient.dio.get(
      ApiEndpoints.fetchWayPoints,
      queryParameters: {
        'originLat': origin.latitude,
        'originLng': origin.longitude,
        'destinationLat': destination.latitude,
        'destinationLng': destination.longitude,
        'language': languageCode,
        'waypoints': stopPoints.map((e) => '${e.latitude},${e.longitude}').join('|'),
        'googleMapsApiKey': apiKey,
      },
    );
  }

  @override
  Future<Response> getAddressFromLatLng(LatLng latLng) async {
    return dioClient.dio.get(
      ApiEndpoints.getAddressFromLatLng,
      queryParameters: {
        'lat': latLng.latitude,
        'lng': latLng.longitude,
      },
    );
  }

  @override
  Future<Response> getLatLngFromPlaceId(String placeId) async {
    return dioClient.dio.get(
      ApiEndpoints.getPlaceDetails,
      queryParameters: {
        'place_id': placeId,
        'fields': 'geometry,name,formatted_address,place_id',
      },
    );
  }

  @override
  Future<Response> searchPlace(String place) async {
    // PERFORMANCE OPTIMIZATION: Don't fetch location on every search
    // Backend autocomplete works fast without location parameters
    // Location is optional and only helps with ranking, not required for search
    // This matches the HTML tool behavior for faster search (1 second response)
    return dioClient.dio.get(
      ApiEndpoints.searchPlace,
      queryParameters: {
        'search_text': place,
        // Removed location parameters for faster search (matches HTML tool)
        // Backend will handle search without location, making it faster
      },
    );
  }
  
  /// Get zone ID for a location
  Future<Response> getZoneId(LatLng location) async {
    return dioClient.dio.get(
      ApiEndpoints.getZoneId,
      queryParameters: {
        'lat': location.latitude,
        'lng': location.longitude,
      },
    );
  }

  @override
  Future<Response> getPlaceDetails(String placeId) async {
    return dioClient.dio.get(
      ApiEndpoints.getPlaceDetails,
      queryParameters: {
        'place_id': placeId,
        'fields': 'geometry,name,formatted_address,place_id',
      },
    );
  }

  @override
  Future<Response> fetchDistances(List<String> placeIds, LatLng origin) async {
    final String languageCode = await LocalStorageService()
        .getSelectedLanguage();

    return dioClient.dio.get(
      ApiEndpoints.fetchDistances,
      queryParameters: {
        'originLat': origin.latitude,
        'originLng': origin.longitude,
        'placeIds': placeIds.join(','),
        'language': languageCode,
        'googleMapsApiKey': apiKey,
      },
    );
  }

  /// Step 1: Get current country code
  Future<String?> getCurrentCountryCode() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    final Position position = await Geolocator.getCurrentPosition(
      // desiredAccuracy: LocationAccuracy.high,
    );

    final List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      return placemarks.first.isoCountryCode?.toLowerCase();
    }

    return null;
  }

}
