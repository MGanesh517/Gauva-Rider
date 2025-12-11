import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'interfaces/i_geo_location_manager.dart';

class GeoLocationManager implements IGeoLocationManager {
  final Location _location = Location();

  @override
  Stream<LatLng> locationStream() => _location.onLocationChanged.map((locationData) => LatLng(locationData.latitude!, locationData.longitude!));

  @override
  Future<bool> checkLocationPermission() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return false;
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return false;
    }
    return true;
  }
}
