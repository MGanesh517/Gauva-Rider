import 'package:dio/dio.dart';
import 'package:gauva_userapp/domain/interfaces/ride_preference_service_interface.dart';
import 'api/dio_client.dart';

class RidePreferenceService implements IRidePreferenceService {
  final DioClient dioClient;

  RidePreferenceService({required this.dioClient});

  @override
  Future<Response> getPreference() async {
    // Spring Boot: User preferences via profile
    return dioClient.dio.get('/api/v1/user/profile');
  }

}
