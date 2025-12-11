import 'package:dio/dio.dart';
import 'package:gauva_userapp/domain/interfaces/rating_service_interface.dart';

import '../../core/config/api_endpoints.dart';
import 'api/dio_client.dart';
import 'local_storage_service.dart';

class RatingService implements IRatingService {
  final DioClient dioClient;

  RatingService({required this.dioClient});
  @override
  Future<Response> rating({required double rating, String? comment, required int? orderId}) async {
    // Spring Boot: /api/reviews expects CreateReviewRequest
    final userId = await LocalStorageService().getUserId();
    return await dioClient.dio.post(
      ApiEndpoints.rating, 
      data: {
        'rideId': orderId,
        'reviewerUserId': userId,
        'rating': rating.toInt(), // Spring Boot expects integer 1-5
        'comment': comment ?? '',
      }
    );
  }

}
