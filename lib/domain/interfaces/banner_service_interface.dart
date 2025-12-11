import 'package:dio/dio.dart';

abstract class IBannerService {
  Future<Response> getBanners();
}

