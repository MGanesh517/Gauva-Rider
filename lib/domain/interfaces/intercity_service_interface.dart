import 'package:dio/dio.dart';

abstract class IIntercityService {
  Future<Response> getIntercityServiceTypes();
  Future<Response> searchIntercity({
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

  Future<Response> getIntercityDrivers({
    required String vehicleType,
    required int seatsNeeded,
    double? pickupLatitude,
    double? pickupLongitude,
    int? routeId,
  });
  Future<Response> createIntercityBooking({
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
