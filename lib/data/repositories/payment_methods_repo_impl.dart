import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../core/errors/failure.dart';
import '../../domain/interfaces/payment_method_service_interface.dart';
import '../models/payment_methods_model/payment_methods_model.dart';
import 'base_repository.dart';
import 'interfaces/payment_methods_repo_interface.dart';

class PaymentMethodsRepoImpl extends BaseRepository implements IPaymentMethodsRepo {
  final IPaymentMethodsService paymentMethodsService;

  PaymentMethodsRepoImpl({required this.paymentMethodsService});
  @override
  Future<Either<Failure, PaymentMethodsModel>> getPaymentMethods() async => await safeApiCall(() async {
      debugPrint('💳 GET WALLET TRANSACTIONS');
      final response = await paymentMethodsService.getPaymentMethods();
      debugPrint('📥 GET WALLET TRANSACTIONS Response: ${response.data}');
      debugPrint('📥 Response Type: ${response.data.runtimeType}');
      
      try {
        // Handle empty array (no transactions)
        if (response.data is List && (response.data as List).isEmpty) {
          debugPrint('✅ GET WALLET TRANSACTIONS - Empty array');
          return PaymentMethodsModel(
            success: true,
            message: 'No transactions',
            data: Data(paymentMethods: []),
          );
        }
        
        // Handle transactions array directly
        if (response.data is List) {
          debugPrint('📦 GET WALLET TRANSACTIONS - Array response detected');
          final wrappedData = {
            'success': true,
            'message': 'Transactions loaded',
            'data': {
              'paymentMethods': response.data,
            }
          };
          final result = PaymentMethodsModel.fromJson(wrappedData);
          debugPrint('✅ GET WALLET TRANSACTIONS - Parsed successfully');
          debugPrint('✅ Transactions count: ${result.data?.paymentMethods?.length ?? 0}');
          return result;
        }
        
        // Handle normal wrapped response
        final result = PaymentMethodsModel.fromJson(response.data);
        debugPrint('✅ GET WALLET TRANSACTIONS - Parsed successfully');
        debugPrint('✅ Transactions count: ${result.data?.paymentMethods?.length ?? 0}');
        return result;
      } catch (e, stackTrace) {
        debugPrint('🔴 GET WALLET TRANSACTIONS - Parsing error: $e');
        debugPrint('🔴 Stack trace: $stackTrace');
        debugPrint('🔴 Raw response data: ${response.data}');
        // Return empty on error
        return PaymentMethodsModel(
          success: false,
          message: 'Error loading transactions',
          data: Data(paymentMethods: []),
        );
      }
    });

}
