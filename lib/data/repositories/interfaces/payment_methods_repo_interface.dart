import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../models/payment_methods_model/payment_methods_model.dart';

abstract class IPaymentMethodsRepo {
  Future<Either<Failure, PaymentMethodsModel>> getPaymentMethods();
}
