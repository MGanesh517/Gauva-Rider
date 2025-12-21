import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/data/models/common_response.dart';

import '../../../core/errors/failure.dart';
import '../../../core/state/rider_service_state.dart';
import '../../models/ride_service_response.dart';

abstract class IRideServicesRepo {
  Future<Either<Failure, RideServiceResponse>> getRideServices({required RiderServiceState riderServiceFilter});
  Future<Either<Failure, RideServiceResponse>> getAvailableServicesForRoute({
    required RiderServiceState riderServiceFilter,
  });
  Future<Either<Failure, RideServiceResponse>> getServicesHome();
  Future<Either<Failure, CommonResponse>> applyCoupon({required String? coupon});
}
