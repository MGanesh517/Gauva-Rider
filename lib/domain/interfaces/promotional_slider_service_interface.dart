import 'package:dio/dio.dart';

abstract class IPromotionalSliderService {
  Future<Response> getPromotionalData();
}
