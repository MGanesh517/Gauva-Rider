import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:gauva_userapp/data/models/common_response.dart';
import 'package:gauva_userapp/data/models/payent_confirm_model/payment_confirm_model.dart';
import 'package:gauva_userapp/data/repositories/interfaces/payment_confirm_repo_interface.dart';
import 'package:gauva_userapp/domain/interfaces/payment_confirm_service_interface.dart';

import '../../core/errors/failure.dart';
import 'base_repository.dart';

class PaymentConfirmRepoImpl extends BaseRepository implements IPaymentConfirmRepo {
  final IPaymentConfirmService paymentConfirmService;

  PaymentConfirmRepoImpl({required this.paymentConfirmService});

  @override
  Future<Either<Failure, PaymentConfirmModel>> paymentConfirm({required int orderId, required String paymentMethodName}) async => await safeApiCall(()async{
      debugPrint('💳 PAYMENT CONFIRM - Order: $orderId, Method: $paymentMethodName');
      final response = await paymentConfirmService.paymentConfirm(orderId: orderId, paymentMethodName: paymentMethodName);
      debugPrint('📥 PAYMENT CONFIRM Response: ${response.data}');
      try {
        final result = PaymentConfirmModel.fromJson(response.data);
        debugPrint('✅ PAYMENT CONFIRM - Parsed successfully');
        return result;
      } catch (e, stackTrace) {
        debugPrint('🔴 PAYMENT CONFIRM - Parsing error: $e');
        debugPrint('🔴 Stack trace: $stackTrace');
        throw Exception('Parsing error: $e');
      }

    });

  @override
  Future<Either<Failure, CommonResponse>> hitSuccessUrl({required String url}) async => await safeApiCall(()async{
      final response = await paymentConfirmService.hitSuccessUrl(url: url);
      try {
        return CommonResponse.fromMap(response.data);
      } catch (e) {
        throw Exception('Parsing error');
      }

    });

}