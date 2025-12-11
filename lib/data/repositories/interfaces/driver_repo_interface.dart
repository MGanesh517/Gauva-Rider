import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/data/models/driver_response/driver_response.dart';

import '../../../core/errors/failure.dart';

abstract class IDriverRepo {
  Future<Either<Failure, DriverResponse>> getDrivers(
      {required LatLng? location});
}
