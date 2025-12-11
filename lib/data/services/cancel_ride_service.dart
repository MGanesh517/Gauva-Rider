import 'package:dio/dio.dart';

import '../../domain/interfaces/cancel_ride_service_interface.dart';
import 'api/dio_client.dart';

class CancelRideService implements ICancelRideService {
  final DioClient dioClient;

  CancelRideService({required this.dioClient});


  @override
  Future<Response> cancelRide({required int? orderId}) async {
    // Spring Boot: /api/v1/ride/{rideId}/decline (POST)
    return await dioClient.dio.post('/api/v1/ride/$orderId/decline');
  }

}
