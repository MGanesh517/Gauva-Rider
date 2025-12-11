import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/data/models/common_response.dart';
import '../../../core/errors/failure.dart';

abstract class IRatingRepo {
  Future<Either<Failure, CommonResponse>> rating({required double rating, String? comment, required int? orderId});
}
