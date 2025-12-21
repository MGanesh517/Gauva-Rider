import 'package:dio/dio.dart';
import '../../core/config/api_endpoints.dart';
import '../../domain/interfaces/intercity_service_interface.dart';
import 'api/dio_client.dart';

class IntercityService implements IIntercityService {
  final DioClient dioClient;

  IntercityService({required this.dioClient});

  @override
  Future<Response> getIntercityServiceTypes() {
    return dioClient.dio.get(ApiEndpoints.intercityServiceTypes);
  }

  @override
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
  }) {
    return dioClient.dio.post(
      ApiEndpoints.intercitySearch,
      data: {
        'routeId': routeId,
        'pickupLatitude': pickupLatitude,
        'pickupLongitude': pickupLongitude,
        'dropLatitude': dropLatitude,
        'dropLongitude': dropLongitude,
        if (vehicleType != null) 'vehicleType': vehicleType,
        'preferredDeparture': preferredDeparture,
        'seatsNeeded': seatsNeeded,
        'searchRadiusKm': searchRadiusKm,
      },
    );
  }

  @override
  Future<Response> getIntercityDrivers({
    required String vehicleType,
    required int seatsNeeded,
    double? pickupLatitude,
    double? pickupLongitude,
    int? routeId,
  }) {
    return dioClient.dio.get(
      ApiEndpoints.intercityDrivers,
      queryParameters: {
        'vehicleType': vehicleType,
        'seatsNeeded': seatsNeeded,
        if (pickupLatitude != null) 'pickupLatitude': pickupLatitude,
        if (pickupLongitude != null) 'pickupLongitude': pickupLongitude,
        if (routeId != null) 'routeId': routeId,
      },
    );
  }

  @override
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
  }) {
    return dioClient.dio.post(
      ApiEndpoints.intercityBooking,
      data: {
        'vehicleType': vehicleType,
        'bookingType': bookingType,
        'seatsToBook': seatsToBook,
        if (tripId != null) 'tripId': tripId,
        if (routeId != null) 'routeId': routeId,
        'pickupAddress': pickupAddress,
        'pickupLatitude': pickupLatitude,
        'pickupLongitude': pickupLongitude,
        'dropAddress': dropAddress,
        'dropLatitude': dropLatitude,
        'dropLongitude': dropLongitude,
        'paymentMethod': paymentMethod,
        'fullName': fullName,
        'email': email,
        if (contactPhone != null) 'contactPhone': contactPhone,
        if (specialInstructions != null) 'specialInstructions': specialInstructions,
      },
    );
  }
}
