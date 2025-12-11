import 'package:dio/dio.dart';

abstract class IPaymentConfirmService {
  Future<Response> paymentConfirm({required int orderId, required String paymentMethodName});
  Future<Response> hitSuccessUrl({required String url});
}
