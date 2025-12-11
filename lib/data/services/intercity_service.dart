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
    required String vehicleType,
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
        'vehicleType': vehicleType,
        'preferredDeparture': preferredDeparture,
        'seatsNeeded': seatsNeeded,
        'searchRadiusKm': searchRadiusKm,
      },
    );
  }

  @override
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
  }) {
    return dioClient.dio.post(
      ApiEndpoints.intercityBooking,
      data: {
        'vehicleType': vehicleType,
        'bookingType': bookingType,
        'seatsToBook': seatsToBook,
        'pickupAddress': pickupAddress,
        'pickupLatitude': pickupLatitude,
        'pickupLongitude': pickupLongitude,
        'dropAddress': dropAddress,
        'dropLatitude': dropLatitude,
        'dropLongitude': dropLongitude,
      },
    );
  }
}
