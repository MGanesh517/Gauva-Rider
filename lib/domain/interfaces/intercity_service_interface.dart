import 'package:dio/dio.dart';

abstract class IIntercityService {
  Future<Response> getIntercityServiceTypes();
  Future<Response> searchIntercity({
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
  Future<Response> createIntercityBooking({
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
