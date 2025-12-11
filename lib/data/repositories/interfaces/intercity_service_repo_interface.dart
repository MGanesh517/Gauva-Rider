import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../models/intercity_service_type.dart';
import '../../models/intercity_search_response.dart';

abstract class IIntercityServiceRepo {
  Future<Either<Failure, List<IntercityServiceType>>> getIntercityServiceTypes();
  Future<Either<Failure, IntercitySearchResponse>> searchIntercity({
    required int routeId,
    required double pickupLatitude,
    required double pickupLongitude,
    required double dropLatitude,
    required double dropLongitude,
    required String vehicleType,
    required String preferredDeparture,
    int seatsNeeded = 0,
    double searchRadiusKm = 0,
  });
  Future<Either<Failure, Map<String, dynamic>>> createIntercityBooking({
    required String vehicleType,
    required String bookingType,
    required int seatsToBook,
    required String pickupAddress,
    required double pickupLatitude,
    required double pickupLongitude,
    required String dropAddress,
    required double dropLatitude,
    required double dropLongitude,
  });
}
