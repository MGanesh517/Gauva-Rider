import 'package:dio/dio.dart';

abstract class IRatingService {
  Future<Response> rating({required double rating, String? comment, required int? orderId});
}
