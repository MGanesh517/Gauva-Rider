import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/data/models/common_response.dart';
import 'package:gauva_userapp/data/models/payent_confirm_model/payment_confirm_model.dart';
import '../../../core/errors/failure.dart';

abstract class IPaymentConfirmRepo {
  Future<Either<Failure, PaymentConfirmModel>> paymentConfirm({required int orderId, required String paymentMethodName});
  Future<Either<Failure, CommonResponse>> hitSuccessUrl({required String url});
}
