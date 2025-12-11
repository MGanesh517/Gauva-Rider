import 'package:dio/dio.dart';
import 'package:gauva_userapp/domain/interfaces/payment_confirm_service_interface.dart';

import 'api/dio_client.dart';

class PaymentConfirmService implements IPaymentConfirmService {
  final DioClient dioClient;

  PaymentConfirmService({required this.dioClient});
  @override
  Future<Response> paymentConfirm({required int orderId, required String paymentMethodName}) async {
    // Spring Boot: /api/payments/{rideId} (POST)
    return await dioClient.dio.post(
      '/api/payments/$orderId',
      data: {
        'paymentMethod': paymentMethodName
      }
    );
  }

  @override
  Future<Response> hitSuccessUrl({required String url}) async => await dioClient.dio
        .get(url,);

}
