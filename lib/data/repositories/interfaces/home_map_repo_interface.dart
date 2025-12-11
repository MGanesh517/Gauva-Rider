import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class IHomeMapRepo {
  Future<bool> checkLocationPermission();
  Future<LatLng?> getUserLocation();
}
