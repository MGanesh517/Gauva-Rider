import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../models/intercity_service_type.dart';
import '../../models/intercity_search_response.dart';
import '../../models/intercity_trip_model.dart';

abstract class IIntercityServiceRepo {
  Future<Either<Failure, List<IntercityServiceType>>> getIntercityServiceTypes();
  Future<Either<Failure, IntercitySearchResponse>> searchIntercity({
    required int routeId,
    required double pickupLatitude,
    required double pickupLongitude,
    required double dropLatitude,
    required double dropLongitude,
    String? vehicleType,
    required String preferredDeparture,
    int seatsNeeded = 0,
    double searchRadiusKm = 0,
  });

  Future<Either<Failure, List<IntercityTripModel>>> getIntercityDrivers({
    required String vehicleType,
    required int seatsNeeded,
    double? pickupLatitude,
    double? pickupLongitude,
    int? routeId,
  });
  Future<Either<Failure, Map<String, dynamic>>> createIntercityBooking({
    required String vehicleType,
    required String bookingType,
    required int seatsToBook,
    int? tripId,
    int? routeId,
    required String pickupAddress,
    required double pickupLatitude,
    required double pickupLongitude,
    required String dropAddress,
    required double dropLatitude,
    required double dropLongitude,
    required String paymentMethod,
    required String fullName,
    required String email,
    String? contactPhone,
    String? specialInstructions,
  });
}
