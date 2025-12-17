import 'package:dio/dio.dart';

import '../../core/config/api_endpoints.dart';
import '../../domain/interfaces/ride_history_service_interface.dart';
import 'api/dio_client.dart';

class RideHistoryService implements IRideHistoryService {
  final DioClient dioClient;

  RideHistoryService({required this.dioClient});
  @override
  Future<Response> getRideHistory(String? status, String? date) async {
    // Spring Boot: Use different endpoints for completed vs cancelled rides
    final endpoint = (status?.toLowerCase() == 'cancelled' || status?.toLowerCase() == 'canceled')
        ? ApiEndpoints.cancelledRideHistory
        : ApiEndpoints.rideHistory;
    
    final queryParams = <String, dynamic>{
      'page': 0, // Spring Boot uses pagination
      'size': 20,
    };
    
    // Add date filter if provided
    if (date != null && date.isNotEmpty) {
      queryParams['date'] = date;
    }
    
    return await dioClient.dio.get(
      endpoint,
      queryParameters: queryParams,
    );
  }

}
