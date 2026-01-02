import '../core/config/api_endpoints.dart';
import '../data/services/api/dio_client.dart';
import '../models/wallet_balance.dart';
import '../models/wallet_transaction.dart';

class DriverWalletService {
  final DioClient _dioClient;

  DriverWalletService({required DioClient dioClient}) : _dioClient = dioClient;

  Future<WalletBalance> getWalletBalance() async {
    try {
      final response = await _dioClient.dio.get(ApiEndpoints.driverWalletBalance);
      if (response.statusCode == 200 && response.data != null) {
        return WalletBalance.fromJson(response.data);
      }
      throw Exception('Failed to fetch driver wallet balance');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<WalletTransaction>> getTransactions({int page = 0, int size = 10}) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.driverWalletTransactions,
        queryParameters: {'page': page, 'size': size},
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> content = (response.data is List) ? response.data : (response.data['content'] ?? []);
        return content.map((json) => WalletTransaction.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
