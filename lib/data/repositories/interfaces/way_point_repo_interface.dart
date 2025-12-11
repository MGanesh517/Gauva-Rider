import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/core/errors/failure.dart';

import '../../models/place_model.dart';
import '../../models/waypoint.dart';

abstract class IGoogleAPIRepo {
  Future<List<LatLng>> getWayPoints();
  Future<Either<Failure, String>> getAddressFromLatLng(LatLng latLng);
  Future<Either<Failure, List<LatLng>>> fetchWayPoints(
      {required List<Waypoint> waypoints});
  Future<Either<Failure, List<PlaceModel>>> searchPlace(
      String place, LatLng latLng);
  Future<Either<Failure, List<String>>> fetchDistances(
      List<String> destinations, LatLng origin);
  Future<Either<Failure, LatLng>> getLatLngFromPlaceId(String placeId);
  Future<Either<Failure, String>> getZoneId(LatLng location);
}
