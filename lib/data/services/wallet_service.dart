import 'package:dio/dio.dart';
import '../../core/config/api_endpoints.dart';
import '../../domain/interfaces/wallet_service_interface.dart';
import 'api/dio_client.dart';

class WalletService implements IWalletService {
  final DioClient dioClient;

  WalletService({required this.dioClient});

  @override
  Future<Response> getWallets() async {
    // Spring Boot: /api/v1/user/wallet/balance
    return await dioClient.dio.get('/api/v1/user/wallet/balance');
  }

  @override
  Future<Response> addBalance({required String amount}) async {
    // Spring Boot: Wallet top-up with Razorpay
    // POST /api/v1/payments/wallet/topup
    return await dioClient.dio.post(
      '/api/v1/payments/wallet/topup',
      data: {'amount': double.parse(amount), 'ownerType': 'USER'},
    );
  }

  @override
  Future<Response> addCard({required Map<String, dynamic> body}) async {
    // Spring Boot: Card management - may need to check actual endpoint
    return await dioClient.dio.post(ApiEndpoints.addCard, data: body);
  }

  @override
  Future<Response> myCards() async {
    // Spring Boot: Get payment methods/cards
    return await dioClient.dio.get(ApiEndpoints.myCard);
  }

  @override
  Future<Response> deleteCard(String? id) async {
    // Spring Boot: Delete card
    return await dioClient.dio.delete('${ApiEndpoints.deleteCard}/$id');
  }
}
