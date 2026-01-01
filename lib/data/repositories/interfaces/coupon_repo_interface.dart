import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/core/errors/failure.dart';
import 'package:gauva_userapp/data/models/coupon_model/coupon_model.dart';

abstract class ICouponRepo {
  Future<Either<Failure, List<CouponModel>>> getAvailableCoupons();
  Future<Either<Failure, Map<String, dynamic>>> checkCoupon(String code);
  Future<Either<Failure, Map<String, dynamic>>> validateCoupon({required String code, required double baseFare});
  Future<Either<Failure, Map<String, dynamic>>> applyCoupon({
    required String code,
    required double baseFare,
    String? rideId,
  });
  Future<Either<Failure, List<Map<String, dynamic>>>> getMyRedemptions();
}
