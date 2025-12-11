import 'package:dio/dio.dart';
import 'package:gauva_userapp/domain/interfaces/promotional_slider_service_interface.dart';
import 'api/dio_client.dart';

class PromotionalSliderService implements IPromotionalSliderService {
  final DioClient dioClient;

  PromotionalSliderService({required this.dioClient});

  @override
  Future<Response> getPromotionalData() async {
    // Spring Boot: /api/promotions/coupons (GET)
    return dioClient.dio.get('/api/promotions/coupons');
  }

}
