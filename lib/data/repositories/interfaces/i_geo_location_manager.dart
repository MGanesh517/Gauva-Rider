import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class IGeoLocationManager {
  Future<bool> checkLocationPermission();
  Stream<LatLng> locationStream();
}
