import 'package:dio/dio.dart';
import 'package:gauva_userapp/domain/interfaces/banner_service_interface.dart';
import 'api/dio_client.dart';

class BannerService implements IBannerService {
  final DioClient dioClient;

  BannerService({required this.dioClient});

  @override
  Future<Response> getBanners() async {
    // Spring Boot: /api/v1/banners (GET)
    return dioClient.dio.get('/api/v1/banners');
  }
}

