import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../models/coupon_model/coupon_model.dart';
import '../services/coupon_service.dart';
import 'base_repository.dart';
import 'interfaces/coupon_repo_interface.dart';

class CouponRepoImpl extends BaseRepository implements ICouponRepo {
  final CouponService _couponService;

  CouponRepoImpl({required CouponService couponService}) : _couponService = couponService;

  @override
  Future<Either<Failure, List<CouponModel>>> getAvailableCoupons() async => safeApiCall(() async {
    final response = await _couponService.getAvailableCoupons();
    final List<dynamic> data = response.data;
    return data.map((json) => CouponModel.fromJson(json)).toList();
  });

  @override
  Future<Either<Failure, Map<String, dynamic>>> checkCoupon(String code) async => safeApiCall(() async {
    final response = await _couponService.checkCoupon(code);
    return response.data;
  });

  @override
  Future<Either<Failure, Map<String, dynamic>>> validateCoupon({required String code, required double baseFare}) async =>
      safeApiCall(() async {
        final response = await _couponService.validateCoupon(code: code, baseFare: baseFare);
        return response.data;
      });

  @override
  Future<Either<Failure, Map<String, dynamic>>> applyCoupon({
    required String code,
    required double baseFare,
    String? rideId,
  }) async => safeApiCall(() async {
    final response = await _couponService.applyCoupon(code: code, baseFare: baseFare, rideId: rideId);
    return response.data;
  });

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getMyRedemptions() async => safeApiCall(() async {
    final response = await _couponService.getMyRedemptions();
    final List<dynamic> data = response.data;
    return data.cast<Map<String, dynamic>>();
  });
}
