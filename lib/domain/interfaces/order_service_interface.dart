import 'package:dio/dio.dart';

abstract class IOrderService {
  Future<Response> createOrder({required Map<String, dynamic> data});
  Future<Response> orderDetails({required int orderId});
  Future<Response> checkActiveTrip();
}
