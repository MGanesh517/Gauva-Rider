import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'interfaces/home_map_repo_interface.dart';

class HomeMapRepoImpl implements IHomeMapRepo {
  // PERFORMANCE OPTIMIZATION: Cache last known location for faster initial load
  LatLng? _lastKnownLocation;
  DateTime? _lastLocationTime;
  static const _locationCacheDuration = Duration(minutes: 5); // Cache for 5 minutes

  @override
  Future<bool> checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Geolocator doesn't natively support requesting service enable like 'location' package
      // The LocationPermissionWrapper handles the dialog flow usually.
      // Returning false here will trigger the permission/service flows in UI.
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  @override
  Future<LatLng?> getUserLocation() async {
    // Check permission first
    // Note: We don't call checkLocationPermission() here to avoid duplicate requests
    // if already handled by UI, but for safety we check status.
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return null;
    }

    // PERFORMANCE OPTIMIZATION: Return cached location if available and recent
    if (_lastKnownLocation != null &&
        _lastLocationTime != null &&
        DateTime.now().difference(_lastLocationTime!) < _locationCacheDuration) {
      // Return cached location immediately, then update in background
      _updateLocationInBackground();
      return _lastKnownLocation;
    }

    // PERFORMANCE OPTIMIZATION: Try to get last known location from OS (very fast)
    try {
      final Position? lastPosition = await Geolocator.getLastKnownPosition();
      if (lastPosition != null) {
        final location = LatLng(lastPosition.latitude, lastPosition.longitude);
        _lastKnownLocation = location;
        _lastLocationTime = DateTime.now();

        // Trigger generic update in background
        _updateLocationInBackground();

        return location;
      }
    } catch (e) {
      debugPrint('⚠️ Failed to get last known position: $e');
    }

    // Fallback: Get fresh location with timeout
    try {
      // Use efficient settings for initial fetch
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium, // Equivalent to 100m block accuracy, fast
        timeLimit: const Duration(seconds: 5),
      );

      final location = LatLng(position.latitude, position.longitude);
      _lastKnownLocation = location;
      _lastLocationTime = DateTime.now();
      return location;
    } catch (e) {
      debugPrint('⚠️ Failed to get current position: $e');
    }

    return null;
  }

  // PERFORMANCE OPTIMIZATION: Update location in background for better accuracy
  void _updateLocationInBackground() {
    Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high, // Use high accuracy for background update
          timeLimit: const Duration(seconds: 10),
        )
        .then((position) {
          _lastKnownLocation = LatLng(position.latitude, position.longitude);
          _lastLocationTime = DateTime.now();
        })
        .catchError((e) {
          debugPrint('⚠️ Background location update failed: $e');
        });
  }
}
