import 'package:dio/dio.dart';
import '../../domain/interfaces/payment_method_service_interface.dart';
import 'api/dio_client.dart';

class PaymentMethodService implements IPaymentMethodsService {
  final DioClient dioClient;

  PaymentMethodService({required this.dioClient});

  @override
  Future<Response> getPaymentMethods() async {
    // Spring Boot: Get wallet transactions
    return dioClient.dio.get('/v1/user/wallet/transactions');
  }

}
