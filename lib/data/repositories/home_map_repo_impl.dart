import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'interfaces/home_map_repo_interface.dart';

class HomeMapRepoImpl implements IHomeMapRepo {
  final Location _location = Location();
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

  @override
  Future<LatLng?> getUserLocation() async {
    if (!await checkLocationPermission()) return null;
    final userLocation = await _location.getLocation();
    return LatLng(userLocation.latitude!, userLocation.longitude!);
  }


}
